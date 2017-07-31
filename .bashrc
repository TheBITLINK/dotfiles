#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

# ye olde prompt
export PS1=" \[\033[38;5;250m\]$(if [[ -z $i ]] ; then i=$(tput cols) ; while (( i-- > 8 )) ; do echo -n '—' ; done ; echo -n " " ; unset i ; fi)\[\033[38;5;15m\]\A\n[\[$(tput sgr0)\]\[\033[38;5;154m\]\u\[$(tput sgr0)\]\[\033[38;5;15m\]@\h \[$(tput sgr0)\]\[\033[38;5;14m\]\w\[$(tput sgr0)\]\[\033[38;5;15m\]]\\$ \[$(tput sgr0)\]"

# git functions
# copy/paste from https://github.com/jimeh/git-aware-prompt/blob/master/prompt.sh
find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="$branch"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='y'
  else
    git_dirty=''
  fi
}

# "dynamic" prompt
export PROMPT_COMMAND=__prompt_command

function __prompt_command() {
    local EXIT="$?"
    find_git_branch;
    find_git_dirty;

    local RCol='\[\e[0m\]'
    local Lime='\[\033[38;5;154m\]'
    local Orange='\[\033[38;5;208m\]'
    local Cyan='\[\033[38;5;51m\]'
    local Mag='\[\033[38;5;200m\]'
    local White='\[\033[38;5;231m\]'
    local Blue='\[\033[38;5;33m\]'
    local Yellow='\[\033[38;5;11m\]'
    local DarkGray='\[\033[38;5;247m\]'

    # Title
    PS1="\[\033]0;\u@\H: \W\007\] ${DarkGray}"

    if [[ -z $i ]]; then
        i=$(tput cols)
        while (( i-- > 8 )); do
            PS1+='—'
        done;
            PS1+="${White} \A\n"
        unset i
    fi
    # Store Line 2 in a separate variable
    local LINE2=""
    # Username
    if [ "$(id -u)" != "0" ]; then
        # Green for users
        LINE2+="[${Lime}\u${White}@\H ${Cyan}\W${White}"
    else
        # Orange for root
        LINE2+="[${Orange}\u${White}@\H ${Cyan}\W${White}"
    fi

    # git branch
    if [ $git_branch ]; then
        if [ $git_dirty ]; then
            LINE2+=" ${Yellow}${git_branch}${White}"
        else
            LINE2+=" ${Blue}${git_branch}${White}"
        fi
    fi

    # exit code if not 0
    if [ $EXIT != 0 ]; then
        LINE2+="${Mag} ${EXIT}${White}"
    fi

    LINE2+="]"
    # Newline if LINE2 is 2big
    local cols=$(tput cols)
    if [ ${#LINE2} -gt $(($cols+60)) ]; then
        PS1+="${LINE2}\n"
    else
        PS1+=$LINE2
    fi
    PS1+="\\$ ${White}\[$(tput sgr0)\]"

}

# Aliases

# Downloads a video as mp3
alias ytmp3="youtube-dl -f bestaudio -x --audio-format mp3 --default-search ytsearch"
# Downloads a video as ogg
alias ytogg="youtube-dl -f bestaudio -x --audio-format vorbis --default-search ytsearch"
alias startx="startx ~/.xinitrc"
alias waifu2x="waifu2x-converter-cpp -j 2"

# Creates a directory and CDs into it
mkd () {
  mkdir -p $1 && cd $1
}

# Starts GNOME on Wayland from a tty
startwayland() {
  export QT_QPA_PLATFORM=wayland
  XDG_SESSION_TYPE=wayland dbus-run-session gnome-session
}

# Random Password
gen_pass(){
  if [ -z "$1" ]; then
    length=100
  else
    length="$1"
  fi

  echo $(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-$length};echo;)
}

# The colorrrrrrssssss
export TERM=xterm-256color

NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
