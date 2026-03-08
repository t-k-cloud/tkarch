while true; do
	rm -f updates.md
	timeout --foreground --kill-after 5s 12m \
	opencode run -m MeAsProvider/Qwen3.5-35B-A3B-FP8  \
	Find the browser tab https://www.youtube.com/feed/subscriptions, REFRESH it if it exists, otherwise open a new tab and navigate to it. Then, click the guide icon on the top left. Under "Subscriptions", find me the top 1st account with unwatched videos indicated by a blue dot near the icon. If there is no unwatched ones, just let me know and do not proceed. Otherwise, click into that account, open Videos, summarize its most updated video into a markdown file updates.md, utilizing video title, descriptions, or transcribed subtitles. The summary is preferred to be in Chinese, with a URL to the video included. After you have done writing updates.md, go back to the original feed/subscriptions page and let me know.
	filename=$(date +"%Y-%m-%d_%H-%M-%S").md
	cp updates.md $filename && cat $filename
	sleep 1
done

