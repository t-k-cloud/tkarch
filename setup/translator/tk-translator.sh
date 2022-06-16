tempfile=$(mktemp)
echo "tempfile: $tempfile"
while true; do
	sel_str="$(xclip -o 2>/dev/null | sed -e 's-/- -g' | awk '{print $1, $2}')"
	last_str="$(cat $tempfile)"
	if [[ "$sel_str" != "$last_str" ]]; then
		echo "$sel_str" > $tempfile
		cat $tempfile
		clear
		trans -show-dictionary n -no-auto -speak ":zh" "$sel_str"
	fi
	sleep 0.1
done
