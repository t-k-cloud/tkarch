#!/bin/bash
if [ "$1" == "-h" ] || [ $# -lt 2 ]; then
cat << USAGE
Description:
sshfs mount with options for a robust (auto-reconnect, keepalive) and
near real-time (minimal caching) connection. Extra args are passed to sshfs.
Re-running on an existing (possibly stale) mount point remounts it.
Unmount with: fusermount3 -u <dst>
Examples:
$0 user@host:/remote/path ~/mnt/host
$0 host: ~/mnt/host -p 2222
USAGE
exit
fi

src="$1"
dst="$2"
shift 2

# sftp does not expand "~": "host:~/foo" -> "host:foo" (relative paths are home-relative)
if [[ "$src" == *:* ]]; then
	host="${src%%:*}"
	rpath="${src#*:}"
	if [[ "$rpath" == "~" ]]; then
		rpath=""
	elif [[ "$rpath" == "~/"* ]]; then
		rpath="${rpath#\~/}"
	fi
	src="${host}:${rpath}"
fi

mkdir -p "$dst"

# clean up a stale/previous mount on dst (e.g. "Transport endpoint is not connected")
if mountpoint -q "$dst" 2>/dev/null || ! ls "$dst" >/dev/null 2>&1; then
	echo "unmounting existing mount on $dst"
	fusermount3 -uz "$dst" 2>/dev/null || fusermount -uz "$dst" 2>/dev/null
fi

opts=(
	# --- robustness ---
	reconnect                 # transparently reconnect when the ssh link drops
	ServerAliveInterval=5     # probe server every 5s ...
	ServerAliveCountMax=3     # ... and give up on the link after ~15s of silence
	TCPKeepAlive=yes
	ConnectTimeout=10
	# --- real time (minimal caching) ---
	dir_cache=no              # always list directories from the server
	entry_timeout=0           # don't cache name lookups
	negative_timeout=0        # don't cache "file does not exist"
	attr_timeout=0            # don't cache file attributes (size/mtime)
	auto_cache                # invalidate page cache when remote mtime/size changes
	# --- convenience ---
	idmap=user                # map remote uid to local user
	follow_symlinks
	Compression=no
)

opt_str=$(IFS=,; echo "${opts[*]}")

set -x
sshfs "$src" "$dst" -o "$opt_str" "$@"
