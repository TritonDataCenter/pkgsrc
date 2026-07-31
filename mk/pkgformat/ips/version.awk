function isdig(c) {
	return (c >= "0" && c <= "9")
}

function encode(v, out,   i, n, c, j, num, nrel, qual, qualnum, nb, hit, k, s, rel) {
	split("", rel)
	nrel = 0
	qual = 5
	qualnum = 0
	nb = 0
	hit = 0
	i = 1
	n = length(v)
	while (i <= n) {
		c = substr(v, i, 1)
		if (isdig(c)) {
			j = i
			while (j <= n && isdig(substr(v, j, 1)))
				j++
			num = substr(v, i, j - i) + 0
			if (hit == 1) {
				qualnum = num
				hit = 0
			} else {
				nrel++
				rel[nrel] = num
			}
			i = j
			continue
		}
		if (tolower(substr(v, i, 5)) == "alpha") {
			qual = 0; hit = 1; i += 5; continue
		}
		if (tolower(substr(v, i, 4)) == "beta") {
			qual = 1; hit = 1; i += 4; continue
		}
		if (tolower(substr(v, i, 3)) == "pre") {
			qual = 2; hit = 1; i += 3; continue
		}
		if (tolower(substr(v, i, 2)) == "rc") {
			qual = 2; hit = 1; i += 2; continue
		}
		if (tolower(substr(v, i, 2)) == "pl") {
			i += 2; continue
		}
		if (tolower(substr(v, i, 2)) == "nb") {
			j = i + 2
			while (j <= n && isdig(substr(v, j, 1)))
				j++
			nb = substr(v, i + 2, j - i - 2) + 0
			i = j
			continue
		}
		if (c == "." || c == "_") {
			i++; continue
		}
		k = index("abcdefghijklmnopqrstuvwxyz", tolower(c))
		if (k > 0) {
			nrel++
			rel[nrel] = k
		}
		i++
	}
	if (nrel == 0) {
		nrel = 1
		rel[1] = 0
	}
	s = rel[1]
	for (k = 2; k <= nrel; k++)
		s = s "." rel[k]
	out[1] = s
	out[2] = qual
	out[3] = qualnum
	out[4] = nb
	return s
}

BEGIN {
	if (branch == "")
		branch = "0"
	if (buildrelease == "")
		buildrelease = "5.11"
}

function fullversion(v,   o) {
	encode(v, o)
	return o[1] "," buildrelease "-" branch "." o[2] "." o[3] "." o[4]
}

NF > 0 && encodeonly == 1 {
	print fullversion($1)
}
