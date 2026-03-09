while true; do
	filename=$(ls -tr ./accounts | head -n 1)
	timeout --foreground --kill-after 5s 12m \
	opencode run -m LocalSGLangProvider/Qwen3.5-FP8  \
	使用 devtools 在我的浏览器内**新建一个tab** 并访问 https://x.com/${filename}。再之后告诉我任务结果以前，记得关闭这个新打开的页面。好，开始！首先，如果页面显示账户不存在、被暂停、或者属于隐私账户，请删除 ./accounts/${filename} 并告诉我。如果页面显示账户存在，不用汇报我，直接继续。好，到了这步，下面所有动作直接用浏览器 devtools 工具查看输出就行，完全不需要自己写程序或者调用其他工具：找出这个用户 Posts 标签下的最新 5 天内的所有 posts 和 repost, 不要包括任何 Pinned posts。如果首屏的所有 posts 都没不在这 5 天内更新，就不用继续了，后面的 posts 肯定更老。否则，如果有更新的话，把这些最近更新的 Posts 总结成中文的 markdown 文档。原文包含的加心个数（点赞个数）、所有链接和图片记得也嵌入到 markdown 文档中，并且存到 ./updates/${filename}.md。
	touch ./accounts/${filename}
	sleep 1
done
