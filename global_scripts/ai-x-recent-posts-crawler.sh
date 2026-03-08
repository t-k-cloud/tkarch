while true; do
	timeout --foreground --kill-after 5s 12m \
	opencode run -m MeAsProvider/Qwen3.5-35B-A3B-FP8  \
	./accounts 目录下有很多文件，请用操作系统命令以他们 touch 的时间排序，找出最早最老那个 touch 的文件，假设这个文件名叫做 foo，第一步更新（touch）一下 ./accounts/foo 的时间戳。然后：使用 devtools 在我的浏览器内访问 https://x.com/foo。如果页面显示账户不存在、被暂停、或者属于隐私账户，请把 ./accounts/foo 删掉并告诉我。如果页面显示账户存在，不用汇报我，直接继续，下面所有动作直接用浏览器 devtools 工具查看输出就行，完全不需要自己写程序或者调用其他工具：找出这个用户 Posts 标签下的最新 5 天内的所有 posts 和 repost, 不要包括任何 Pinned posts。如果这段时间没有什么更新就不用继续。否则的话把这些最近更新的 Posts 总结成中文的 markdown 文档，原文包含的加心个数（点赞个数）、所有链接和图片记得也嵌入到 markdown 文档中。保存路径每个 markdown 的文件名就简单以 timestamp 格式存在 ./output 目录，假设刚才访问的名字叫 foo , 那么就存到 ./output/foo.md。再告诉我任务完成以前，记得关闭刚才打开的页面。
	sleep 1
done
