# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# added by t.k.
parse_git_branch() {
	if which git &> /dev/null; then
		git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1 /'
	fi
}

show_conda_env() {
	if [ -n "$CONDA_DEFAULT_ENV" ]; then
		echo "($CONDA_DEFAULT_ENV) "
	fi
}

get_gitstatus() {
	red_ink=$(tput setaf 1)
	green_ink=$(tput setaf 2)
	cyan_ink=$(tput setaf 6)
	if which git &> /dev/null; then
		if git rev-parse --is-inside-work-tree &> /dev/null; then
			if ! git diff --quiet; then
				echo "${red_ink}●"
			elif ! git diff --cached --quiet; then
				echo "${green_ink}●"
			elif [ "$(git log --branches --not --remotes)" != "" ]; then
				echo "${cyan_ink}↑"
			fi
		fi
	fi
}

mytput() {
	echo -n '\['
	tput $@
	echo -n '\]'
}

__prompt_command() {
	lastcode=$?
	bold=$(mytput bold)
	dim=$(mytput dim)
	normal=$(mytput sgr0)
	red_bkgd=$(mytput setab 1)
	magenta_fg=$(mytput setaf 5)
	blue_fg=$(mytput setaf 4)
	yellow_fg=$(mytput setaf 3)
	green_fg=$(mytput setaf 2)
	white_fg=$(mytput setaf 7)
	underline=$(mytput smul)
	show_user="\u"
	show_host="\h"
	show_wdir="\w"
	show_newline="\n"
	show_date=$(date +%d/%m\|%Y)
	show_time="\t"
	show_pyenv="${blue_fg}${bold}\$(show_conda_env)"
	show_gitbrance="${dim}${yellow_fg}\$(parse_git_branch)"
	show_gitstatus="\$(get_gitstatus)"
	show_prompt_head="${white_fg}${bold}\\$"
	if [ ! $lastcode -eq 0 ]; then
		show_prompt_head="${white_fg}${red_bkgd}\${lastcode}${normal} ${show_prompt_head}"
	fi
	PS1="╭─ ${bold}${show_wdir}${normal} ${show_pyenv}${show_gitstatus}${show_gitbrance}${normal} ${bold}${magenta_fg}${show_user}@${show_host}${normal} ${underline}${show_date} ${show_time}${normal}${show_newline}${normal}╰─ ${show_prompt_head}${normal} "
}

PROMPT_COMMAND=__prompt_command

alias gg='xdg-open &> /dev/null'
alias tt='stat -c "%y"'
alias rl='readlink -f'

export PATH=$PATH:$HOME/.cabal/bin:$HOME/bin:$HOME/.local/share/gem/ruby/3.0.0/bin
# man page highlight color
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4) # yellow on blue
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
# set 256 color, otherwise vim-airline has no color in MATE-terminal 
TERM=screen-256color

# auto cd, this feature only appeared in bash 4.0
shopt -s autocd

alias to-polipo="http_proxy=http://localhost:8123 https_proxy=http://localhost:8123"

function do_countdown(){
   date1=$((`date +%s` + $1));
   while [ "$date1" -ge `date +%s` ]; do
     echo -ne "$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)\r";
     sleep 0.2
   done
}

function do_repeat() {
	[ -z $1 ] && return;
	while true; do clear; $1; sleep 1; done;
}

function do_srchcntnt() {
	d=100
	[ -z $2 ] && return;
	[ ! -z $3 ] && d=$3;
	#set -x
	bash -c "find . -maxdepth ${d} -name .git -prune -o \
	\( ! \( -type d \) -a \( $1 \) \) \
	-exec grep -n -H -C 3 -P --color '$2' \{\} \;"
	#set +x
}

function do_srchname() {
	[ -z $1 ] && return;
	find . -name "*${1}*"
}

alias repeat="do_repeat"
alias cntdown="do_countdown"

alias srch="do_srchcntnt    \"-name '*'\""
alias srchjs="do_srchcntnt  \"-name '*.js'\""
alias srchpy="do_srchcntnt  \"-name '*.py'\""
alias srchC="do_srchcntnt   \"\\( -name '*.[ch]' -o -name '*.cpp' \\)\""
alias srchc="do_srchcntnt   \"-name '*.c'\""
alias srchcpp="do_srchcntnt \"-name '*.cpp'\""
alias srchh="do_srchcntnt   \"-name '*.h'\""
alias srchtex="do_srchcntnt  \"-name '*.tex'\""
alias srchmk="do_srchcntnt  \"\\( -name '*.mk' -o -name '[Mm]akefile' -o -name 'Android.mk' \\)\""
alias srchname="do_srchname"

function do_svnshow() {
	[ -z $2 ] && return;
	svn diff $1 -c $2 | vim -R -
}

alias svndiff="svn diff --diff-cmd=diff -x -U50"
alias svndif="svn diff | vim -R -"
alias svnshow="do_svnshow '' "
alias svnlog="svn log | less"
alias svnshownameonly="do_svnshow --summarize"

alias pipgfw="sudo pip install -i http://pypi.douban.com/simple/ --trusted-host=pypi.douban.com/simple"

export SVN_EDITOR=vi

conda_prefix=/mnt/hg_cache

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$($conda_prefix/anaconda3/bin/conda 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f $conda_prefix/anaconda3/etc/profile.d/conda.sh ]; then
        . $conda_prefix/anaconda3/etc/profile.d/conda.sh
    else
        export PATH=$conda_prefix/anaconda3/bin:$PATH
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if ! conda env config vars list | grep -q "LD_LIBRARY_PATH"; then
    conda env config vars set LD_LIBRARY_PATH="$CONDA_PREFIX/lib"
fi

# https://wiki.archlinux.org/title/SSH_keys
# This will run a ssh-agent process if there is not one already, and save the output thereof. If there is one running already, we retrieve the cached ssh-agent output and evaluate it which will set the necessary environment variables. The lifetime of the unlocked keys is set to 24 hour.
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

if [ -f $HOME/.env ]; then
	source $HOME/.env
fi
