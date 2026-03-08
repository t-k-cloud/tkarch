while true; do
	timeout --kill-after 5s 3m \
	opencode run -m MeAsProvider/Qwen3.5-35B-A3B-FP8  \
	去我已经登录的 https://x.com，在侧面栏找到 Profile 点进去，然后找到帐号的 following 个数（比如 1234 Following），点击那个 Following 链接进入 Profile 的 following 标签。调用 devtool 工具把网页中的 HTML 输出出来，所有你看得到的帐号名，以一个帐号名一个文件的形式，手动 touch 到本地，不要尝试使用任何编码和脚本去做！简单的看到一个帐号就 touch 一下 —— 例如，你看到帐号 @foo 就 touch foo 新建一个叫 foo 的文件，帐号全部小写！。文件不需要包含任何内容。touch 完这批帐号名以后，sroll 得到新的一批帐号，同样地输出 touch 文件。然后一直 scroll, touch, scroll, touch, ... 直到页面高度不发生变化。
	sleep 1
done
