tempfile=$(mktemp)
echo "tempfile: $tempfile"
while true; do
	sel_str=$(xclip -o 2>/dev/null)
	last_str=$(tail -n 1 $tempfile)
	if [[ "$sel_str" != "$last_str" ]]; then
		echo $sel_str >> $tempfile
		clear
		trans -show-dictionary n -no-auto -speak ":zh" $sel_str
	fi
	sleep 0.1
done
