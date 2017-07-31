#
# TheBITLINK's zsh theme.
#
# Based on my own .bashrc (https://github.com/TheBITLINK/dotfiles/blob/master/.bashrc)
#
# # README
#
# This theme uses some [powerline](https://github.com/Lokaltog/powerline-fonts) characters.
#
case ${SOLARIZED_THEME:-dark} in
    light) fgc=black;;
    *)     fgc=white;;
esac

local w="%{$reset_color%}"

precmd() {
  export TBL_ZSH_JST=''
  [[ $(jobs -l | wc -l) -gt 0 ]] && export TBL_ZSH_JST=' ⚙'
}

if [[ $EUID -eq 0 ]]; then
  # Root Prompt
  _USERCOLOR="%{$fg_bold[red]%}"
else
  # User Prompt
  _USERCOLOR="%{$fg[green]%}"
fi

PROMPT=$' ${(r:$(($COLUMNS - 8))::\u2500:)} %D{%H:%M}\n${w}[${_USERCOLOR}%n${w}@%m %{$fg[cyan]%}%c$(git_prompt_info)${w}]%(!.#.$) '
RPROMPT='%{$fg_bold[magenta]%}%(?.. [%?])%{$fg_bold[cyan]%}${TBL_ZSH_JST}%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="${w}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[yellow]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
