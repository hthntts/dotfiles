######### fzf-tmux -p 80%

######### cdb | cd to bookmark from file
cdb() {
    local dest_dir=$(cat ~/.cdg | sort | fzf --prompt='  Fuzzy Finder > ' --header='Choose Bookmarks (Folder)')
    if [[ $dest_dir != '' ]]; then
        cd "$dest_dir"
    fi
}

######### tmuxj | tmux jump other session
tmuxj() {
    local session
    session=$(tmux list-session | fzf --prompt='  Fuzzy Finder > ' --header='Choose Tmux Session' | awk -F: '{print $1}')
    if [[ ! -z ${TMUX} ]]; then
        tmux switch-client -t $session
    else
        tmux a -t $session
    fi
}

######### venv | choose python venv
venv() {
    mkdir -p $HOME/.venv
    local selected_env
    selected_env=$(command ls ~/.venv/ | fzf --prompt='  Fuzzy Finder > ' --header 'Choose Python Virtualenv')
    if [ -n "$selected_env" ]; then
        source "$HOME/.venv/$selected_env/bin/activate"
    fi
}

######### meh | edge history open
meh() {
    local cols sep
    cols=$((COLUMNS / 3))
    sep='{::}'
    cp -f ~/Library/Application\ Support/Microsoft\ Edge/Default/History /tmp/h
    sqlite3 -separator $sep /tmp/h \
        "select substr(title, 1, $cols), url
      from urls order by last_visit_time desc" |
        awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\x1b[m\n", $1, $2}' |
        fzf --prompt='  Fuzzy Finder > ' --header='Choose history (Microsoft Edge)' --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}

######### Ctrl + G : cd project repo
cd-fzf-ghqlist() {
    local GHQ_ROOT=$(ghq root)
    local REPO=$(ghq list -p | sed -e 's;'${GHQ_ROOT}/';;g' | fzf --prompt='  Fuzzy Finder > ' --header='Choose Project')
    if [ -n "${REPO}" ]; then
        BUFFER="cd ${GHQ_ROOT}/${REPO}"
    fi
    zle accept-line
}
zle -N cd-fzf-ghqlist
bindkey '^G' cd-fzf-ghqlist

######### Ctrl + R : command history
fzf-history-buffer() {
    local HISTORY=$(history -n -r 1 | fzf --prompt='  Fuzzy Finder > ' --header='Choose History Command Line' +m)
    BUFFER=$HISTORY
    if [ -n "$HISTORY" ]; then
        CURSOR=$#BUFFER
    else
        zle accept-line
    fi
}
zle -N fzf-history-buffer
bindkey '^R' fzf-history-buffer

######### Ctrl + \ : ssh manager
fzf-sshconfig-ssh() {
    local SSH_HOST=$(awk '
      tolower($1)=="host" {
          for (i=2; i<=NF; i++) {
              if ($i !~ "[*?]") {
                  print $i
              }
          }
      }
  ' ~/.ssh/config | sort | fzf --prompt='  Fuzzy Finder > ' --header='Choose Server SSH' +m)
    if [ -n "$SSH_HOST" ]; then
        BUFFER="ssh $SSH_HOST"
    fi
    zle accept-line
}
zle -N fzf-sshconfig-ssh
bindkey '^\' fzf-sshconfig-ssh

######### git-delete-branches
git-delete-branches() {
    local branches_to_delete
    branches_to_delete=$(git branch | fzf --multi)

    if [ -n "$branches_to_delete" ]; then
        git branch --delete --force $branches_to_delete
    fi
}
