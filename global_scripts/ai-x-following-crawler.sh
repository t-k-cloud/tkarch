while true; do
	timeout --foreground --kill-after 5s 12m \
	opencode run -m MeAsProvider/Qwen3.5-35B-A3B-FP8  \
	去我已经登录的 https://x.com，在侧面栏找到 Profile 点进去，然后找到帐号的 following 个数（比如 1234 Following），点击那个 Following 链接进入 Profile 的 following 标签。调用 devtool 工具把网页中的 HTML 输出出来。对于你看得到的帐号名，一个帐号名对应一个当前目录下的相同的文件名字。如果存在，就不新建这个文件；如果不存在，就新建（touch），不要尝试使用任何编码和脚本去做！简单的看到一个本地没有对应文件的帐号就 touch 一下 —— 例如，你看到帐号 @foo ，但是 foo 文件不存在于当前目录，就 touch foo 新建一个叫 foo 的文件，全部小写！。文件不需要包含任何内容。touch 完这批帐号名以后，sroll 得到新的一批帐号，同样地输出 touch 文件。然后一直 scroll, touch, scroll, touch, ... 直到页面高度不发生变化。
	sleep 1
	for f in *; do
		mv "$f" "$(echo "$f" | tr '[:upper:]' '[:lower:]')" 2> /dev/null
	done
	find . -maxdepth 1 -type d ! -path . -exec rm -rf {} +
	find . -maxdepth 1 -type f -name "* *" -delete
	echo -n "帐号个数："
	find . -type f | wc -l
done
