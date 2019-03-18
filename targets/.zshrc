#!/bin/zsh

## Charset
export LANG='ja_JP.UTF-8'
export LC_TIME='en_US.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## Color
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
## Color for completion
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## Colort for prompt
autoload -U colors; colors
setopt prompt_subst
## Avoid zsh: no matches found:
setopt nonomatch
export CLICOLOR=true

## PROMPT
PROMPT='%F{magenta}[%F{magenta}%B%n%b%f%F{magenta}@%F%F{magenta}%U%m%u%f%F{magenta}]%f '
PROMPT='%B%{'${fg[yellow]}'%}[%n@%U%m%u]%{'${reset_color}'%}%b '
## RPROMPT
RPROMPT=$'[`check_git_status` %~]' # %~はpwd
setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する

## Display git branch
function check_git_status {
local name st color

if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    return 0
fi

name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")

if [[ -z $name ]]; then
    return 0
fi

st=`git status --short 2> /dev/null`

if [ -z "$st" ]; then
    # Status clean
    color=${fg[green]}
elif [[ $st =~ "[\n]?\?\? " ]]; then
    # Untracked
    color=${fg[yellow]}
elif [[ $st =~ "[\n]? M " ]]; then
    # Modified
    color=${fg[red]}
else
    # Added to commit
    color=${fg[cyan]}
fi

echo "%{$color%}$name%{$reset_color%}"
                    }

## Check spell
setopt correct
## Strong completion
autoload -U compinit promptinit; compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
setopt auto_menu
setopt auto_list
setopt list_packed
setopt list_types

## Other
setopt noautoremoveslash
setopt auto_param_slash
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
setopt auto_param_keys
setopt magic_equal_subst
unsetopt promptcr
setopt nobeep
setopt extended_glob
setopt share_history
setopt hist_verify
setopt hist_ignore_dups
setopt extended_history
setopt numeric_glob_sort
setopt print_eight_bit

## Path
export PATH=/usr/local/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH

## aliases
setopt complete_aliases

case "${OSTYPE}" in
  darwin*)
    ## Mac
    alias ls="ls -aG -w"
    alias ll="ls -alG -w"
    ;;
  linux*)
    ## linux
    alias ls="ls -a --color"
    alias ll="ls -la --color"
    ;;
  cygwin*)
    ## Windows(Cygwin)
    alias ls="ls -a --color"
    alias ll="ls -la --color"
    ;;
esac

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Gem
export GEM_HOME=$HOME/.gem/ruby/2.0.0
export PATH="$GEM_HOME/bin:$PATH"

### tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

### Editor
export EDITOR='vim'

### jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

### pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

### nodenv
eval "$(nodenv init -)"

### OpenSSL
export LDFLAGS="-L/usr/local/opt/openssl/lib"
export CPPFLAGS="-I/usr/local/opt/openssl/include"
export PKG_CONFIG_PATH="/usr/local/opt/openssl/lib/pkgconfig"

### Java Home
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`

### go
export GOPATH="$HOME/.go"
export PATH="$PATH:$GOPATH/bin"

### play setting
export PLAY_HOME="$HOME/dotfiles/source/play-1.2.7"
export PATH="$PATH:$PLAY_HOME"

### Ant setting
export ANT_HOME="$HOME/dotfiles/source/apache-ant-1.9.9"
export PATH="$PATH:$ANT_HOME/bin"

### DockerSlim
export DOCKER_SLIM_HOME="$HOME/dotfiles/source/dist_mac"
export PATH="$PATH:$DOCKER_SLIM_HOME"

### Gosu
export GOSU_HOME="$HOME/dotfiles/source/gosu-1.14.10/bin"
export PATH="$PATH:$GOSU_HOME"

### Custom alia
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'
alias acuc="activator clean update compile"
alias pa="activator \"run 9010\""
alias pb="activator \"run 9020\""
alias pc="activator run"

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# direnv
eval "$(direnv hook zsh)"

# Postgresql
export PGDATA=/usr/local/var/postgres
alias pg_start="pg_ctl -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Custom function
function history-all { history -E 1 }

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh

export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator
