# this took so long who knew awk was an entire language lmao
function number_for(str) {
	match($0, str ": [0-9]*")
	line = substr($0, RSTART, RLENGTH)
	split(line, split_line, " ")
	return split_line[3]
}

{
	active = number_for("Pages active")
	inactive = number_for("Pages inactive")
	percent = 100 / (active + inactive) * active
	printf("%.1f%% ", percent)
}
