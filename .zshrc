# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
ZSH_THEME="thebitlink"
ENABLE_CORRECTION="true"
plugins=(git safe-paste sudo zsh-autosuggestions command-not-found)
source $ZSH/oh-my-zsh.sh

# User configuration
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=32
#export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

export LANG=en_US.UTF-8
export TERM=xterm-256color

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

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
        source /etc/profile.d/vte.sh
fi

# Local NPM packages
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
unset MANPATH
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

