mkdir -p ./x.com/following ./x.com/updates
cd x.com

############################################
# Step 1: collecting following accounts
############################################
pushd ./following
timeout --foreground --kill-after 5s 20m \
opencode run -m LocalSGLangProvider/Qwen3.5-FP8 \
Find the browser tab https://x.com, REFRESH it if it exists, otherwise open a **NEW** tab and navigate to it. Then, click the "Profile" icon on left panel. Under the logged-in account Profile page, find the following stats of this account and click that link to the "Following" page of this account. For each account, they have an account handler shown next to their account name, e.g., @foo. For each visible account handler in this page, issue "touch" command to create an empty file named after the handler id. For example, if the account handler is @foo, just issue "touch foo". Keep doing so until all visible accounts in this following list are touched. Note that, you have exhausted visible accounts in the "Following" page, try scroll to the bottom of the page and see if there are more accounts to be loaded. Until no further accounts are loaded, you keep doing the above collecting process until you believe you have done all accounts followed by this profile. You will be indicated that you have seen a complete list if scrolling to the bottom of this page does not trigger any page height changes.
echo -n "清除 invalid 帐号..."
for f in *; do
	mv "$f" "$(echo "$f" | tr '[:upper:]' '[:lower:]')" 2> /dev/null
done
find . -maxdepth 1 -type d ! -path . -exec rm -rf {} +
find . -maxdepth 1 -type f -name "* *" -delete
echo -n "帐号个数："
find . -type f | wc -l
popd

########################################################################################
# Step 2: go through each account and summarize updates (if any) in a stateless manner
########################################################################################
while true; do
	timeout --foreground --kill-after 5s 20m \
	opencode run -m LocalSGLangProvider/Qwen3.5-FP8 \
	Find the file with the oldest timestamp in ./following, assuming it is called "foo", remove ./following/foo and open the associated x.com profile page of that account, i.e., https://x.com/foo. Stop here and let me know if you do not see any files in ./following. Otherwise, if the account page is shown non-existing, blocked, private, or suspended. Go find another file with the oldest timestamp in ./following, remove it and retry. Next, if you find an account page shows normally, check whether their recent posts or reposts under the "Posts" tab have any updates in the past 5 days, excluding any "Pinned" posts. If nothing is updated, go find another file with the oldest timestamp in ./following, remove it and retry. Until, if you have found any new posts or reposts under an account in the given time past, summarize those posts into a markdown file named "updates.md". The summary should be written in Chinese as much as possible, while trying to include all orignal mentions, embedded video links, images, and social reaction stats such that I can preview easily from the markdown preview, e.g., instead of only copying the image link into markdown, embed the image as a markdown image. If you have reached here and have created a "updates.md", before tell me your finishing the task, close all open x.com tabs in the browser which you have opened previously.
	if [ -e updates.md ]; then
		filename=$(date +"%Y-%m-%d_%H-%M-%S").md
		mv updates.md updates/$filename
	else
		break
	fi
	sleep 3
done
