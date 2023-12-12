# PATH: echo $PATH | sed "s/:/\n/g"
# GNUPATH=$(find /usr/local/Cellar -type d | grep gnubin)
export BAT_THEME="Catppuccin-mocha"
export FZF_DEFAULT_COMMAND="fd --hidden --follow --exclude '.git' --exclude 'node_modules' --exclude '__pycache__' --exclude '.dropbox.cache'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"
export FZF_DEFAULT_OPTS="
--layout=reverse
--info=inline
--color=hl:#8CDE5A
--color=hl+:#8CDE5A
--color='prompt:#d7005f'
--preview-window=:hidden,border-sharp
--preview '(bat --style=numbers --color=always {} ||  highlight -O ansi -l {} || coderay {} || rougify {} || cat {}) 2> /dev/null | head -200'
--pointer='ᐅ'
--marker='✓'
--bind 'ctrl-q:abort'
--bind '?:toggle-preview'
--bind 'ctrl-e:execute(echo {+} | xargs nvim)'
--bind 'ctrl-c:execute-silent(echo {+} | pbcopy)'
--header '?: Toggle Preview
ctrl-q: Abort
ctrl-c: Copy to Clipboard'"

[[ -d $HOME/.bin ]] && export PATH="${HOME}/.bin:$PATH"
[[ -d $HOME/.cabal/bin ]] && export PATH="${HOME}/.cabal/bin:$PATH"
[[ -d $HOME/.emacs.d/bin ]] && export PATH="${HOME}/.emacs.d/bin:$PATH"
[[ -d $HOME/.venv/python/bin ]] && export PATH="${HOME}/.venv/python/bin:$PATH"

export PATH="/usr/local/sbin:$PATH"

######### openssl
export LIBRARY_PATH="/usr/local/opt/openssl@3/lib"

######### ruby
export PATH="${HOME}/.gem/ruby/2.6.0/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/ruby/lib"
export CPPFLAGS="-I/usr/local/opt/ruby/include"
export PKG_CONFIG_PATH="/usr/local/opt/ruby/lib/pkgconfig"

######### openjdk
export PATH="/usr/local/opt/openjdk@11/bin:$PATH"
# export CPPFLAGS="-I/usr/local/opt/openjdk@11/include"

######### pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

######### editor
export EDITOR="emacsclient"
export ALTERNATE_EDITOR="nvim"

######### nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
