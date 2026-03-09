mkdir -p ./x.com && cd x.com
timeout --foreground --kill-after 5s 12m \
	opencode run -m LocalSGLangProvider/Qwen3.5-FP8 \
	Find the browser tab https://x.com, REFRESH it if it exists, otherwise open a new tab and navigate to it. Then, click the "Profile" icon on left panel. Under the logged-in account Profile page, find the following stats of this account and click that link to the "Following" page of this account. Click into each visible account in that list, skip an account if it is blocked, private, or suspended. If an account page shows normally, check whether their recent posts under the "Posts" tab have any updates in the past 5 days, excluding any "Pinned" posts. If you have found any new posts for an account in the given time past, summarize those posts into a markdown file named after the account name. For example, if the account name is @foo and it has 3 updates in the given time past, summarize the 3 update posts into a foo.md file in Chinese, trying to include all orignal mentions, embedded video links, images, and social reaction stats such that I can preview easily from the markdown format, e.g., instead of only copying the image link into markdown, embed the image as markdown image. After you have done summarizing a updated account, go back to the "Following" list page, and click into the next visible one, and repeat collecting updates. If you have exhausted visible accounts in the "Following" page, try scroll to the bottom of the page and see if there are more accounts to be loaded. Until no further accounts are loaded, you keep doing the above collecting process until you believe all updates have been collected from all accounts followed by this profile.

echo -n "清除 invalid 帐号..."
for f in *; do
	mv "$f" "$(echo "$f" | tr '[:upper:]' '[:lower:]')" 2> /dev/null
done
find . -maxdepth 1 -type d ! -path . -exec rm -rf {} +
find . -maxdepth 1 -type f -name "* *" -delete

echo -n "帐号个数："
find . -type f | wc -l
