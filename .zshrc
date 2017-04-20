export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

#!/bin/zsh
## 文字コード設定
export LANG='ja_JP.UTF-8'
export LC_TIME='en_US.UTF-8'
export LC_MESSAGES='ja_JP.UTF-8'
export _JAVA_OPTIONS='-Dfile.encoding=UTF-8'

HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

## カラー設定
#export TERM=xterm-256color
export LSCOLORS=ExFxCxdxBxegedabagacad
export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
export ZLS_COLORS=$LS_COLORS
## 補完候補をカラー表示
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
## vkillの候補にも色付き表示
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([%0-9]#)*=0=01;31'

## プロンプトにカラーを使用する
autoload -U colors; colors
## 表示毎にPROMPTで設定されている文字列を評価する
setopt prompt_subst
## avoid zsh: no matches found: 
setopt nonomatch

export CLICOLOR=true

## PROMPT
PROMPT='%F{magenta}[%F{magenta}%B%n%b%f%F{magenta}@%F%F{magenta}%U%m%u%f%F{magenta}]%f '
PROMPT='%B%{'${fg[yellow]}'%}[%n@%U%m%u]%{'${reset_color}'%}%b '
## RPROMPT
RPROMPT=$'[`check_git_status` %~]' # %~はpwd
setopt prompt_subst #表示毎にPROMPTで設定されている文字列を評価する

## gitのbranch名とstatus表示
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

## スペルチェック
setopt correct
## 補完機能の強化
autoload -U compinit promptinit; compinit
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*:default' menu select=1
## コマンドにsudoを付けても補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
## TAB で順に補完候補を切り替える
setopt auto_menu
## 補完候補を一覧表示
setopt auto_list
## 補完候補を詰めて表示
setopt list_packed
## 補完候補一覧でファイルの種別をマーク表示
setopt list_types
## 最後のスラッシュを自動的に削除しない
setopt noautoremoveslash
## ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_param_slash
## 大文字，小文字を区別しないで補完（大文字は開始は大文字限定）
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
## カッコの対応などを自動的に補完
setopt auto_param_keys
## --prefix=/usr などの = 以降も補完
setopt magic_equal_subst
## 出力の文字列末尾に改行コードが無い場合でも表示
unsetopt promptcr
## ビープを鳴らさない
setopt nobeep
## ファイル名で #, ~, ^ の 3 文字を正規表現として扱う
setopt extended_glob
## ヒストリを共有
setopt share_history
## ヒストリを呼び出してから実行する間に一旦編集
setopt hist_verify
## 直前と同じコマンドをヒストリに追加しない
setopt hist_ignore_dups
## zsh の開始, 終了時刻をヒストリファイルに書き込む
setopt extended_history
## ファイル名の展開で辞書順ではなく数値的にソート
setopt numeric_glob_sort
## 出力時8ビットを通す
setopt print_eight_bit

## PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/bin:$PATH
export PATH=/usr/local/sbin:$PATH
export PATH=$HOME/bin:$PATH

## エイリアス
## エイリアスを展開してもとのコマンドに応じた補完をしてくれる
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
export GEM_HOME=/usr/local/ruby/Gems/2.0.14
export PATH=/usr/local/heroku/bin:/Users/k00068/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/Users/k00068/.jenv/shims:/Users/k00068/.jenv/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/ruby/Gems/2.0.14/bin
export EDITOR='vim'
if which jenv > /dev/null; then eval "$(jenv init -)"; fi
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# Python version management: pyenv.
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

alias acuc="activator clean update compile"
alias pa="activator \"run 9010\""
alias pb="activator \"run 9020\""
alias pc="activator run"

#play setting
export PLAY_HOME=~/play-1.2.5.6
export PATH=$PATH:$PLAY_HOME
alias soumu="sh ~/soumu.sh"
alias ctags='/usr/local/Cellar/ctags/5.8_1/bin/ctags'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# sbt setting
#export SBT_OPTS="-Xmx=1G"

# Postgresql
export PGDATA=/usr/local/var/postgres
alias pg_start="pg_ctl -l /usr/local/var/postgres/server.log start"
alias pg_stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
