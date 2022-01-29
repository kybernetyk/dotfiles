# zshrc by j. szpilewski
# it's a mess
setopt auto_pushd
setopt PUSHD_IGNOREDUPS
setopt PUSHD_SILENT
setopt no_ignore_eof
setopt no_beep
bindkey -e
export CLICOLOR=1
export LSCOLORS=dxfxcxdxgxegedabagacad
autoload -U colors && colors
autoload -U compinit && compinit

zstyle ":completion:*:commands" rehash 1

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

export ZLSCOLORS="${LS_COLORS}"

setopt extendedglob
zmodload -a colors
zmodload -a autocomplete
zmodload -a complist

zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

#zstyle ':completion:*' list-colors ${LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31' 
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'

#zstyle ':completion:*' completer _complete _match _approximate
#zstyle ':completion:*:match:*' original only
#zstyle ':completion:*:approximate:*' max-errors 1 numeric


setopt share_history

bindkey "\e[3~" delete-char

export PATH=/opt/local/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PATH=/usr/local/sbin:$PATH
function prompt_kerbaugh_help { print "nothing customizable yet"}

function prompt_kerbaugh_setup {
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

	function prompt_kerbaugh_precmd {
		issucceed "$?"
		#		PS1="${PREFIX}[$BOLD_BLUE%n$BLACK@$BOLD_GREEN%m$BLACK]$BOLD_MAUVE%3c $HIST_COLOR%! $DEFAULT%# $RED $GREEN"
#		PENIS=$(git_super_status)
#		PS1="${PREFIX}[$BOLD_BLUE%n$BLACK::$BOLD_GREEN%m$BLACK]->($BOLD_YELLOW%3c$BLACK)$PENIS $RED# $DEFAULT"
		PS1="${PREFIX}[$BOLD_BLUE%n$BLACK::$BOLD_GREEN%m$BLACK]->($BOLD_YELLOW%3c$BLACK) $RED# $DEFAULT"
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

	function precmd { prompt_kerbaugh_precmd }

}



################################################################


#source $HOME/zsh-git-prompt/zshrc.sh
#PROMPT='%B%m%~%b$(git_super_status) %# '

prompt_kerbaugh_setup "$@"

export LC_CTYPE="en_US.UTF-8"

export PATH=$HOME/bin:$PATH
export PATH=$PATH:$HOME/src/huescripts
export PATH=/usr/local/bin:$PATH

export EDITOR=vim

alias ll="ls -l"
alias lla="ls -la"


play () { . ~/.difm.conf
	[[ -z $1 ]] && echo "$STATIONS" && return
	mpg123 -C --no-gapless http://prem2.di.fm/$1_hi\?$API 
}

rock () { . ~/.difm.conf
	[[ -z $1 ]] && echo "$STATIONS_ROCK" && return
	mpg123 -C --no-gapless http://prem2.rockradio.com/$1\?$API 
}

classic () { . ~/.difm.conf
	[[ -z $1 ]] && echo "$STATIONS_CLASSIC" && return
	mpg123 -C --no-gapless http://prem2.classicalradio.com/$1\?$API 
}

radio () { . ~/.difm.conf
	[[ -z $1 ]] && echo "$STATIONS_RADIO" && return
	mpg123 -C --no-gapless http://prem2.radiotunes.com/$1\?$API 
}

. ~/z.sh


google() {
	search=""
	echo "Googling: $@"
	for term in $@; do
		search="$search%20$term"
	done
	open "http://www.google.com/search?q=$search"
}

export MAIL=/var/mail/kyb
export PATH=$PATH:/usr/local/opt/go/libexec/bin
export GOPATH=$HOME/golang
export PATH=$PATH:$GOPATH/bin
DISABLE_AUTO_TITLE="true"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
#export PATH="$PATH:$HOME/.rvm/bin"
export LANG=en_EN.UTF-8
export LC_ALL=en_US.UTF-8

linx(){
	open `curl -T "$@" -H "Linx-Randomize: yes" https://linx.li/upload/`
}

upload() {
    # write to output to tmpfile because of progress bar
    tmpfile=$( mktemp -t transferXXX )
    curl --progress-bar --upload-file $1 https://transfer.sh/$(basename $1) >> $tmpfile;
    open `cat $tmpfile`;
    rm -f $tmpfile;
}

myip() {
	curl $1 icanhazip.com
}

alias vimx='vim -c %\!xxd'
#export PATH="$(brew --prefix homebrew/php/php70)/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

#iterminator -s "Monokai Soda"
#iterminator -s "WildCherry"
#iterminator -s "Glacier" 2>/dev/null
#iterminator -s "MonaLisa" 2>/dev/null
export GPG_TTY=$(tty)
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
export PATH="$HOME/.local/share/gem/ruby/3.0.0/bin:/opt/homebrew/opt/ruby/bin:/opt/homebrew/lib/ruby/gems/3.0.0/bin:$PATH"
