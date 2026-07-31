function normmode(m,   u, l) {
	l = length(m)
	if (l < 3)
		return m
	m = substr(m, l - 2)
	u = substr(m, 1, 1)
	if (u == "7" || u == "5")
		return "0" u "55"
	if (u == "6" || u == "4")
		return "0" u "44"
	if (u == "2")
		return "0644"
	if (u == "1" || u == "3")
		return "0755"
	return "0" m
}

function fixmode(l,   m) {
	if (match(l, /mode=[0-7]+/) == 0)
		return l
	m = substr(l, RSTART + 5, RLENGTH - 5)
	return substr(l, 1, RSTART - 1) "mode=" normmode(m) substr(l, RSTART + RLENGTH)
}

function getpath(l,   p) {
	if (match(l, /(^| )path=[^ ]+/) == 0)
		return ""
	p = substr(l, RSTART, RLENGTH)
	sub(/^ /, "", p)
	return substr(p, 6)
}

BEGIN {
	while ((getline line < plist) > 0) {
		if (line == "" || substr(line, 1, 1) == "@")
			continue
		keep[prefix "/" line] = 1
	}
	close(plist)
}

/^dir/ {
	print fixmode($0)
	next
}

/^(file|link|hardlink)/ {
	p = getpath($0)
	if (p == "" || !(p in keep))
		next
	print fixmode($0)
	next
}

{
	print
}
