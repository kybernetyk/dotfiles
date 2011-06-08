# zshrc by j. szpilewski
# it's a mess
# nntp.pl
setopt auto_pushd
setopt PUSHD_IGNOREDUPS
setopt PUSHD_SILENT
setopt no_ignore_eof
setopt no_beep

export CLICOLOR=1
export LSCOLORS=dxfxcxdxgxegedabagacad

#show all killable processes for kill <tab>
zstyle ':completion:*:kill:*:processes' command "ps x"

#menu for short lists
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
#zstyle ':completion:*' menu yes select 

#menu for kill command
#zstyle ':completion:*:*:kill:*' menu select=1 _complete _ignored _approximate

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always

#don't waste space in completion lists
setopt list_packed

setopt no_share_history

bindkey "\e[3~" delete-char

export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin
