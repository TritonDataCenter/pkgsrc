#
# Record REQUIRES entries based on illumos elfdump(1) or GNU readelf output.
#

BEGIN {
	system_rpath = ENVIRON["SYSTEM_DEFAULT_RPATH"]
	destdir = ENVIRON["DESTDIR"]
}

/NEEDED/ {
	# readelf wraps the filename in "[libfoo.so]"
	gsub(/[\[\]]/, "", $NF);
	dsolibs = dsolibs (dsolibs ? ":" : "") $NF
}

/RPATH/ {
	# readelf wraps the path in "[/lib/foo:/lib/bar]"
	gsub(/[\[\]]/, "", $NF);

	# Add the default system paths as they won't be included in RPATH
	nrpath = split($NF ":" system_rpath, rpath, ":")
	nlibs = split(dsolibs, libs, ":")

	for (l = 1; l <= nlibs; l++) {
		for (r = 1; r <= nrpath; r++) {
			sub(/\/$/, "", rpath[r])

			# Look first under DESTDIR for any libraries that the
			# package ships, and ignore them if found.
			libfile = destdir rpath[r] "/" libs[l]
			if (!(libfile in libcache)) {
				libcache[libfile] = system("test -f " libfile)
			}
			if (libcache[libfile] == 0) {
				break
			}

			# Now search for installed libraries and record as
			# dependencies.
			libfile = rpath[r] "/" libs[l]
			if (!(libfile in libcache)) {
				libcache[libfile] = system("test -f " libfile)
			}
			if (libcache[libfile] == 0) {
				print libfile
				break
			}
		}
	}

	# Reset dsolibs as multiple elfdump outputs are combined together and
	# parsed in one go to improve efficiency.
	dsolibs = ""
}
