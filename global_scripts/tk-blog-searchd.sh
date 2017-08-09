#!/bin/bash
if [ "$1" == "-h" ]; then
cat << USAGE
Description:
start blog searchd
Examples:
$0 init (install jieba and whoosh, then chmod)
$0 start
$0 start-and-never-die
$0 reindex (must after searchd is started)
$0 clear (delete index)
$0 kill
USAGE
exit
fi

searchd_path=/home/tk/tksync/proj/tkblog/searchd
auto_respawn="respawn-on-crash.sh"
searchd_name="searchd.py"
cd $searchd_path

if [ $# -ne 1 ]; then
	echo 'bad arg.' && exit
fi

function kill_searchd() {
	pid_respwan=`ps aux | grep "${auto_respawn}" | grep bash | awk '{print $2}'`
	pid_searchd=`ps aux | grep "${searchd_name}" | grep python3 | awk '{print $2}'`

	kill ${pid_respwan}
	echo "killing PID=${pid_respwan}..."

	sleep 3

	kill ${pid_searchd}
	echo "killing PID=${pid_searchd}..."
}

if [ "$1" == "start" ]; then
	echo "[ starting searchd... ]"
	python3 "./${searchd_name}" &

elif [ "$1" == "start-and-never-die" ]; then
	echo "[ starting searchd forever... ]"
	bash -c "./${auto_respawn}" &
	
elif [ "$1" == "init" ]; then
	sudo pip3 install whoosh
	sudo pip3 install jieba
	sudo chmod +x "./${auto_respawn}"

elif [ "$1" == "reindex" ]; then
	curl "http://127.0.0.1/tkblog/resource/search/search_req.php?action=clear"
	python3 "${searchd_path}/reindex.py"

elif [ "$1" == "clear" ]; then
	curl "http://127.0.0.1/tkblog/resource/search/search_req.php?action=clear"

elif [ "$1" == "kill" ]; then
	kill_searchd
else
	echo 'bad option arg.'
	exit
fi

echo "[ done ]"
