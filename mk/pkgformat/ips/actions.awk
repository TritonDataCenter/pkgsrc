function q(s) {
	if (s !~ /[ \t"'\\]/)
		return s
	gsub(/\\/, "\\\\", s)
	gsub(/"/, "\\\"", s)
	return "\"" s "\""
}

function abspath(p) {
	if (substr(p, 1, 1) == "/")
		return substr(p, 2)
	return prefix "/" p
}

function reesc(s,   i, n, c, o) {
	o = ""
	n = length(s)
	for (i = 1; i <= n; i++) {
		c = substr(s, i, 1)
		if (index(".+*?[]()^$|\\{}", c) > 0)
			o = o "\\" c
		else
			o = o c
	}
	return o
}

function rest(l, skip,   i, n, a, o) {
	n = split(l, a, " ")
	o = ""
	for (i = skip + 1; i <= n; i++)
		o = (o == "" ? a[i] : o " " a[i])
	return o
}

$1 == "SET" {
	v[$2] = rest($0, 2)
	next
}

$1 == "USERS" { for (i = 2; i <= NF; i++) users[++nusers] = $i; next }
$1 == "GROUPS" { for (i = 2; i <= NF; i++) groups[++ngroups] = $i; next }
$1 == "DIRS" { for (i = 2; i <= NF; i++) dirs[++ndirs] = $i; next }
$1 == "DIRPERMS" { for (i = 2; i <= NF; i++) dp[++ndp] = $i; next }
$1 == "CONF" { for (i = 2; i <= NF; i++) cf[++ncf] = $i; next }
$1 == "CONFPERMS" { for (i = 2; i <= NF; i++) cfp[++ncfp] = $i; next }
$1 == "REQD" { for (i = 2; i <= NF; i++) rf[++nrf] = $i; next }
$1 == "REQDPERMS" { for (i = 2; i <= NF; i++) rfp[++nrfp] = $i; next }
$1 == "PERMS" { for (i = 2; i <= NF; i++) sp[++nsp] = $i; next }
$1 == "CONFMODE" { confmode = $2; next }
$1 == "REQDMODE" { reqdmode = $2; next }
$1 == "UID" { uid[$2] = $3; next }
$1 == "HOME" { home[$2] = $3; next }
$1 == "SHELL" { shell[$2] = $3; next }
$1 == "GECOS" { gecos[$2] = rest($0, 2); next }
$1 == "GID" { gid[$2] = $3; next }
$1 == "SMF" { smf[++nsmf] = $2; next }
$1 == "DEPEND" { dname[++ndep] = $2; dver[ndep] = $3; next }
$1 == "BLDDEP" { blddep[++nbld] = $2; next }

END {
	prefix = v["prefix"]
	branch = v["ipsbranch"]
	buildrelease = v["ipsbuildrelease"]

	printf "set name=pkg.fmri value=%s@%s\n", v["ipsname"],
	    fullversion(v["pkgversion"])
	if (v["summary"] != "")
		printf "set name=pkg.summary value=%s\n", q(v["summary"])
	printf "set name=pkg.human-version value=%s\n", q(v["pkgversion"])
	if (v["homepage"] != "")
		printf "set name=info.upstream-url value=%s\n", q(v["homepage"])
	printf "set name=pkgsrc.pkgname value=%s\n", q(v["pkgname"])
	printf "set name=pkgsrc.pkgpath value=%s\n", q(v["pkgpath"])
	if (v["options"] != "")
		printf "set name=pkgsrc.options value=%s\n", q(v["options"])
	if (v["license"] != "")
		printf "set name=pkgsrc.license value=%s\n", q(v["license"])

	desc = ""
	if (v["descr"] != "") {
		while ((getline line < v["descr"]) > 0) {
			if (line == "")
				continue
			desc = (desc == "" ? line : desc " " line)
		}
		close(v["descr"])
	}
	if (desc != "")
		printf "set name=pkg.description value=%s\n", q(desc)

	for (i = 1; i <= nbld; i++)
		printf "set name=pkgsrc.blddep value=%s\n", q(blddep[i])

	for (i = 1; i <= ndep; i++) {
		encode(dver[i], o)
		printf "depend type=require fmri=%s@%s\n", dname[i], o[1]
	}

	for (i = 1; i <= nusers; i++) {
		n = index(users[i], ":")
		if (n == 0)
			continue
		u = substr(users[i], 1, n - 1)
		g = substr(users[i], n + 1)
		l = "user username=" u " group=" g " ftpuser=false"
		if (uid[u] != "")
			l = l " uid=" uid[u]
		if (home[u] != "")
			l = l " home-dir=" home[u]
		if (shell[u] != "")
			l = l " login-shell=" shell[u]
		if (gecos[u] != "")
			l = l " gcos-field=" q(gecos[u])
		print l
	}

	for (i = 1; i <= ngroups; i++) {
		l = "group groupname=" groups[i]
		if (gid[groups[i]] != "")
			l = l " gid=" gid[groups[i]]
		print l
	}

	for (i = 1; i <= ndirs; i++)
		printf "dir path=%s owner=root group=bin mode=0755\n",
		    abspath(dirs[i])

	for (i = 1; i + 3 <= ndp; i += 4)
		printf "dir path=%s owner=%s group=%s mode=%s\n",
		    abspath(dp[i]), dp[i + 1], dp[i + 2], dp[i + 3]

	for (i = 1; i + 1 <= ncf; i += 2)
		printf "file %s path=%s mode=%s preserve=renamenew\n",
		    abspath(cf[i]), abspath(cf[i + 1]), confmode

	for (i = 1; i + 4 <= ncfp; i += 5)
		printf "file %s path=%s owner=%s group=%s mode=%s preserve=renamenew\n",
		    abspath(cfp[i]), abspath(cfp[i + 1]), cfp[i + 2],
		    cfp[i + 3], cfp[i + 4]

	for (i = 1; i + 1 <= nrf; i += 2)
		printf "file %s path=%s mode=%s preserve=true\n",
		    abspath(rf[i]), abspath(rf[i + 1]), reqdmode

	for (i = 1; i + 4 <= nrfp; i += 5)
		printf "file %s path=%s owner=%s group=%s mode=%s preserve=true\n",
		    abspath(rfp[i]), abspath(rfp[i + 1]), rfp[i + 2],
		    rfp[i + 3], rfp[i + 4]

	for (i = 1; i + 3 <= nsp; i += 4) {
		p = reesc(abspath(sp[i]))
		printf "<transform file dir path=%s$ -> set owner %s>\n",
		    p, sp[i + 1]
		printf "<transform file dir path=%s$ -> set group %s>\n",
		    p, sp[i + 2]
		printf "<transform file dir path=%s$ -> set mode %s>\n",
		    p, sp[i + 3]
	}

	for (i = 1; i <= nsmf; i++)
		printf "<transform file path=%s$ -> add restart_fmri svc:/system/manifest-import:default>\n",
		    reesc(abspath(smf[i]))
}
