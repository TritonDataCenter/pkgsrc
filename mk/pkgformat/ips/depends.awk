function basever(pkg, out,   i, n, c) {
	n = length(pkg)
	for (i = n; i > 1; i--) {
		if (substr(pkg, i, 1) != "-")
			continue
		c = substr(pkg, i + 1, 1)
		if (c >= "0" && c <= "9") {
			out[1] = substr(pkg, 1, i - 1)
			out[2] = substr(pkg, i + 1)
			return 1
		}
	}
	out[1] = pkg
	out[2] = ""
	return 0
}

function category(dir,   n, a) {
	n = split(dir, a, "/")
	if (n < 2)
		return ""
	return a[n - 1]
}

FNR == NR {
	if (NF >= 3)
		cat[$2] = category($3)
	next
}

NF >= 3 {
	if ($1 == "full") {
		if (!basever($3, bv))
			next
		c = cat[$2]
		if (c == "")
			next
		printf "DEPEND %s/%s %s\n", c, bv[1], bv[2]
	} else {
		printf "BLDDEP %s\n", $3
	}
}
