typeset -A __CONFIG
__CONFIG[ITALIC_ON]=$'\e[3m'
__CONFIG[ITALIC_OFF]=$'\e[23m'

######### 󰌒 : menu complete
autoload -U compinit
compinit -u
zstyle ':completion:*' matcher-list '' '+m:{[:lower:]}={[:upper:]}' '+m:{[:upper:]}={[:lower:]}' '+m:{_-}={-_}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors ''
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(..) ]] && reply=(..)'
zstyle ':completion:*:complete:(cd|pushd):*' tag-order 'local-directories named-directories'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format %F{default}%B%{$__CONFIG[ITALIC_ON]%}%F{cyan}----- %d -----%{$__CONFIG[ITALIC_OFF]%}%b%f
zstyle ':completion:*' menu select

######### 󰘶 + 󰌒 : reverse menu complete
if tput cbt &> /dev/null; then
  bindkey "$(tput cbt)" reverse-menu-complete
fi

######### 󰌌 : bindkey
autoload -U select-word-style
select-word-style bash
bindkey -e
bindkey \^U backward-kill-line
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

######### cdr + 󰌒 : recent dirs
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':completion:*:*:cdr:*:*' menu selection
zstyle ':chpwd:*' recent-dirs-default true

#########  : emacs terminal
if [[ $TERM == "dumb" ]]; then
  PS1='%(?..[%?])%!:%~%# '
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd
  unfunction preexec
fi

#########  : spaceship
source $(brew --prefix)/opt/spaceship/spaceship.zsh

#########  : alias
[[ -f $HOME/.zsh/.alias.zsh ]] && source $HOME/.zsh/.alias.zsh
[[ -f $HOME/.zsh/.env.zsh ]] && source $HOME/.zsh/.env.zsh
[[ -f $HOME/.zsh/.functions.zsh ]] && source $HOME/.zsh/.functions.zsh
[[ -f $HOME/.zsh/.fzf.zsh ]] && source $HOME/.zsh/.fzf.zsh
[[ -f $HOME/.zsh/.gnu.zsh ]] && source $HOME/.zsh/.gnu.zsh

######### 󰊲 : plugins
source ~/.zsh.plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh.plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source ~/.zsh.plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
