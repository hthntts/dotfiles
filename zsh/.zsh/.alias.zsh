######### 󰪋 : my aliases
alias color24bit="curl -s https://raw.githubusercontent.com/JohnMorales/dotfiles/master/colors/24-bit-color.sh | bash"
alias myip="curl http://ipecho.net/plain; echo"
alias psg="ps aux $([[ -n "$(uname -a | grep CYGWIN)" ]] && echo '-W') | grep -i $1"
alias pullall="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias reload="source $HOME/.zshrc"
alias search="python3 ~/Sync/personal/other/search.py"
alias tmuxw="sh ~/Sync/personal/other/tmuxw.sh"
alias v="fd --type f | fzf -m --prompt='  Fuzzy Finder > ' --reverse | xargs nvim"

#########  : use `\vim` or `command vim` to get the real vim.
if
    command -v nvim >/dev/null 2>&1
then
    alias vim=nvim
fi

#########  : fast and user-friendly alternative to 'find'
if
    command -v fd-find >/dev/null 2>&1
then
    alias fd=fdfind
fi

######### 󰉋 : exa icon
if
    command -v exa >/dev/null 2>&1
then
    alias ls="exa --icons --group-directories-first"
    alias ll="exa -l -g --icons --group-directories-first"
    alias lla="ll -a"
    alias tree="exa -T --icons"
else
    if [[ "$(uname -s | awk '{print tolower($1)}')" = darwin* ]]; then
        alias ls="gls --color -h --group-directories-first"
        alias ll="gls --color -l -h --group-directories-first"
        alias lla="ll -a"
    else
        alias ls="ls --color -h --group-directories-first"
        alias ll="ls --color -l -h --group-directories-first"
        alias lla="ll -a"
    fi
fi

######### 󰇄 : open app on macos
alias mate="open -a TextMate"
alias excel="open -a Microsoft\ Excel"
alias word="open -a Microsoft\ Word"

#########  : global aliases
# (work at any position within the command line)
alias -g C="| pbcopy"
alias -g F="| fzf -m --prompt='  Fuzzy Finder > '"
alias -g G="| grep -i"
alias -g H="| head"
alias -g L="| less"
alias -g M="| more"
alias -g P="| peco"
alias -g W="| wc -l"

#########  : suffix aliases
# (eg. "foo.md" to open Markdown files in nvim)
# alias -s md=nvim
# alias -s sh=nvim
# alias -s py=nvim
# alias -s vim=nvim
# alias -s lua=nvim
# alias -s txt=nvim
# alias -s log=nvim
# alias -s ini=nvim
# alias -s yml=nvim
# alias -s yaml=nvim
# alias -s toml=nvim
