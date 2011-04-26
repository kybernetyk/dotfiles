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
bindkey -e		#emacs

#GNU ls
alias ls='ls --color'

autoload -U colors
colors

function set_prompt {
	#--------------------------------------------------------------------------------------------------------------------
	# function issucceed: Sets the "HISTORY_COLOR" based on the success of the previous command
	#--------------------------------------------------------------------------------------------------------------------
	function issucceed {
		if [ "$1" -eq 0 ]; then
			HIST_COLOR="$BOLD_RED"
			PREFIX=""
		else
			HIST_COLOR="$BOLD_BLACK"
			PREFIX="[$BOLD_RED${1}$BLACK]"
		fi
	}

	#------------------------------------------------------------------------------------
	# function precmd: Calls the other functions and creates the prompt
	#------------------------------------------------------------------------------------
	# Store the current argument string for "precmd" to avoid clobbering it

	function set_prompt_precmd {
		issucceed "$?"
	    PS1="${PREFIX}[$BOLD_BLUE%n$BLACK@$BOLD_GREEN%m$BLACK]$BOLD_MAUVE%3c $HIST_COLOR%! $DEFAULT%# "
	}

 
	#--------------------------------------------
	# Color constants used in the prompt
	#--------------------------------------------
	BLACK="%{[0m%}"
	BOLD_BLACK="%{[1;30m%}"
	RED="%{[0;31m%}"
	BOLD_RED="%{[1;31m%}"
	GREEN="%{[0;32m%}"
	BOLD_GREEN="%{[1;32m%}"
	YELLOW="%{[0;33m%}"
	BOLD_YELLOW="%{[1;33m%}"
	BLUE="%{[0;34m%}"
	BOLD_BLUE="%{[1;34m%}"
	MAUVE="%{[0;35m%}"
	BOLD_MAUVE="%{[1;35m%}"
	CYAN="%{[0;36m%}"
	BOLD_CYAN="%{[1;36m%}"
	WHITE="%{[0;37m%}"
	DEFAULT="%{[0;39m%}"

 

	#typeset -ga precmd_functions
	#precmd_functions+=prompt_kerbaugh_precmd
 
	function precmd { set_prompt_precmd }

}



################################################################

set_prompt "$@"

#go lang settings
export GOROOT=$HOME/go
export PATH=$PATH:$GOROOT/bin


