
###########################
#          BASH           #
###########################

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

###########################
#          ALIAS          #
###########################

###  unix   ###
alias ll="ls -al"


### python  ###
alias python=python3
alias pip=pip3


###   gcc   ###
alias g++="g++ -std=c++14"

gcco() {  # gcc compile
	gcc -pthread -lm -o "$1.out" "$1.c"
}

g++o() {  # g++ compile
	g++ -o "$1.out" "$1.cpp"
}


###   git   ###
alias gadd="git add *"
alias gaddd="git add ."
alias gsta="git status"
alias gcom="git commit -m"
alias glog="git log --pretty=oneline --graph --all"
alias gchk="git checkout -b"
alias gmer="git merge"
alias gdif="git diff"

gclo() {  # git clone
	if [[ $# -eq 1 ]]; then
		id='cpm0722'
		repo=$1
	else
		id=$1
		repo=$2
	fi
	git clone https://cpm0722:${GIT_TOKEN}@github.com/${id}/${repo}.git ${repo}
}

grem() {
	if [[ $# -eq 1 ]]; then
		id='cpm0722'
		repo=$1
	else
		id=$1
		repo=$2
	fi
	git remote add origin https://cpm0722:${GIT_TOKEN}@github.com/${id}/${repo}.git
}

gpul() {  # git pull for now branch
	branch=`git rev-parse --abbrev-ref HEAD`
	git pull origin ${branch}
}

gpus() {  # git push for now branch
	branch=`git rev-parse --abbrev-ref HEAD`
	git push origin ${branch}
}


###   ssh   ###
alias lnx="ssh lnx"
alias nas="ssh nas"
alias gpu="ssh gpu -N -f ; ssh lab -N -f"


###  util   ###
copy() {  # copy all text in file to the clipboard
	pbcopy <$1
}

gdrive() {  # download file from google drive
	link=$1
	id=${link%/view?usp=sharing}
	id=${id#https://drive.google.com/file/d/}
	if [[ $# -eq 2 ]]; then
		wget --no-check-certificate "https://docs.google.com/uc?export=download&id=$id" -O $2
	else
		wget --no-check-certificate "https://docs.google.com/uc?export=download&id=$id"
	fi
}

scp_download() {
	scp -i ~/.ssh/id_rsa_braincloud -P 17460 root@instance.cloud.kakaobrain.com:$1 ./
}

scp_upload() {
	scp -i ~/.ssh/id_rsa_braincloud -P 17460 $1 root@instance.cloud.kakaobrain.com:/data/private
}

algo() {
	# temp directory for input data files
	target_dir="$HOME/.algo_test_tmp"
	mkdir -p $target_dir
	touch $target_dir/latest
	# load latest number
	latest=$(<$target_dir/latest)
	# if now question number is not equal to latest number
	if [[ $latest -ne $1 ]]; then
		# save now question number to latest for next execute
		echo $1 > $target_dir/latest
		# delete before input data files
		rm -rf $target_dir/input*.txt
		# crwaling BOJ site and get input data files
		# get test case count
		CNT=`python3 $HOME/wd/setting/res/algo.py $1 $target_dir`
	else  # if now question number is equal to latest number
		# get test case count using latest input data files
		CNT=`ls -l $target_dir/input*.txt | wc -l`
	fi
	exec_file=$1.py
	# if argc == 1 (execute all test case)
	if [[ $# -eq 1 ]]; then
		for ((i= 1; i <= CNT; i++)); do
			echo ""
			echo "[test $i]"
			python $exec_file <$target_dir/input$i.txt
		done
	else  # if argc >= 2 (execute specific test case)
		shift  # ignore argv[1] (question number)
		while test $# -gt 0; do
			echo ""
			echo "[test $1]"
			python $exec_file <$target_dir/input$1.txt
			shift
		done
	fi
}

forever_on() {
	ps_count=$(ps -ejfc | grep repeat_compute.py | wc -l)  # check already executed

	if [[ $ps_count -eq 1 ]]; then                 # doesn't executed yet
		RESULT=$(nvidia-smi)                       # check gpu
		EXIT_CODE=$?

		if [[ $EXIT_CODE -eq 0 ]]; then
			if [[ ${#RESULT} -eq 0 ]]; then
				DEVICE="cpu"
			else
				DEVICE="cuda"
			fi
		else
			DEVICE="cpu"
		fi

		echo $DEVICE

		nohup /home/ubuntu/personal_unix_setting/repeat_compute.py --device $DEVICE 2>&1 1>&/dev/null &

		if [ -f nohup.out ]; then        # remove nohup.out
			rm nohup.out
		fi
	fi
}

forever_off() {
	ps_count=$(ps -ejfc | grep repeat_compute.py | wc -l)         # check already executed

	if [[ $ps_count -ne 1 ]]; then                                # already executed
		ps_result=$(ps -ejfc | grep repeat_compute.py | head -1)  # get ps result's first line
		tokenized=(${ps_result//\t/ })                            # tokenized with \t
		pid=${tokenized[1]}                                       # get first token (PID)
		kill $pid
	echo [1] $pid killed
	fi
}

### 42seoul ###
export USER_42="hanskim"
export MAIL_42="hanskim@student.42seoul.kr"
alias norminette="~/.norminette/norminette.rb"
alias nm="norminette -R CheckForbiddenSourceHeader"
alias cc="gcc -Wall -Wextra -Werror"


### cpplint ###
alias cstyle="cpplint --filter=-whitespace/tab,-whitespace/braces,-legal/copyright,-build/include_subdir,-readability/casting,-runtime/arrays,-runtime/printf,-runtime/threadsafe_fn"
alias cnaming="python2 $HOME/wd/setting/res/cncc.py --style=$HOME/wd/setting/res/c.style"


###  ctags  ###
alias ctags="/opt/homebrew/bin/ctags"


###########################
#          CONDA          #
###########################

check_conda_info() {
	info=`conda info | head -2 | tail -1`
	info=${info// /}
	info=${info#activeenvironment:}
	if [[ $info == "torch" ]]; then
		conda deactivate
		echo "Deactivate torch conda environment..."
	else
		conda activate torch
		echo "Activate torch conda environment..."
	fi
}

alias torch=check_conda_info


##########################
#          PATH          #
##########################

export PATH=/home/ubuntu/anaconda3/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
export PATH=${PATH}

GIT_TOKEN=""
