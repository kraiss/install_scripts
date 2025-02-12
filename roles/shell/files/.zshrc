##############################
# Load Modules and functions #
##############################

# Autoload necessary modules
autoload -U zmv
autoload -U zcp
autoload -U colors
autoload -Uz vcs_info
autoload -Uz compinit
autoload zargs
zmodload zsh/complist

# Initialize colors
colors

# Initialize completion system
compinit -u

#########################
## Prompt configuration #
#########################

# Function to automatically list directory contents if no command is entered
auto-ls () {
    if [[ $#BUFFER -eq 0 ]]; then
        echo ""
        ls --color
        zle redisplay
    else
        zle .$WIDGET
    fi
}

# Bind auto-ls to specific widgets
zle -N auto-ls
zle -N accept-line auto-ls
zle -N other-widget auto-ls

# Improve autocompletion messages
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, rien de trouvé pour: %d%b'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Change the format of cvs_info
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s:%b%F{5})%F{3}-%F{5}[%F{2}%r/%S%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

export RPROMPT="[%{$fg[green]%}%*%{$reset_color%}]"
export PS2='>'

precmd() {
  vcs_info
  if [[ -z "${vcs_info_msg_0_}" ]]; then
    PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%B%{$fg[blue]%}%~%b%{$reset_color%} ${vcs_info_msg_0_}%f%(?.. [%?])%# '
  else
    PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%{$reset_color%}${vcs_info_msg_0_}%f%(?.. [%?])%# '
  fi
  if [[ "${VIRTUAL_ENV}" ]]; then
    PROMPT="${PROMPT}[py-venv]$ "
  fi
}
vcs_info
if [[ -z "${vcs_info_msg_0_}" ]]; then
  PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%B%{$fg[blue]%}%~%b%{$reset_color%} ${vcs_info_msg_0_}%f%(?.. [%?])%# '
else
  PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%{$reset_color%}${vcs_info_msg_0_}%f%(?.. [%?])%# '
fi

#####################
# Configure History #
#####################

# Disable verification when using "!cmd"
unsetopt HIST_VERIFY
# Remove duplicate entries in the history file, keeping only the last occurrence
setopt HIST_IGNORE_ALL_DUPS
# When searching the history with the zsh command editor, do not show the same line more than once, even if it was recorded multiple times
setopt HIST_FIND_NO_DUPS
# Append history entries to the history file, rather than overwriting it
setopt APPENDHISTORY
# Incrementally append commands to the history file as they are entered
setopt INC_APPEND_HISTORY
# Share history between all sessions
setopt SHARE_HISTORY
# Record timestamp and duration of each command in the history file
setopt EXTENDED_HISTORY
# Automatically remove duplicate entries from the command history
setopt HIST_IGNORE_DUPS

export HISTFILE=~/.histfile
export HISTSIZE=10000
export SAVEHIST=${HISTSIZE}

#####################
# Configure Options #
#####################

# Change to a directory just by typing its name
setopt AUTOCD
# Automatically push the old directory onto the directory stack when changing directories
setopt AUTO_PUSHD
# Use a minus sign to rotate the directory stack when using 'pushd'
setopt PUSHDMINUS

# Prevent the shell from being stopped by the SIGHUP signal
setopt NOHUP
# Notify when a job running in the background finishes
setopt NOTIFY

# Change the way autocompletion is handled
unsetopt LIST_AMBIGUOUS
# Move the cursor to the end of the word when completing
setopt ALWAYS_TO_END
# Allow completion to occur anywhere in the word
setopt COMPLETE_IN_WORD
# Allow the use of variables in the prompt
setopt PROMPT_SUBST

# Allow patterns that do not match any files to expand to an empty string
setopt NULL_GLOB
# Include hidden files (those starting with a dot) in filename generation
setopt GLOB_DOTS
# Enable extended globbing syntax
setopt EXTENDEDGLOB

######################
# Aliases and abbrev #
######################

# Rewrite del key as delete char
bindkey "^[[3~" delete-char

# Function to expand abbreviations
magic-abbrev-expand() {
    local MATCH
    LBUFFER="${LBUFFER%%(#m)[_a-zA-Z0-9]#}"
    LBUFFER+="${abbreviations[$MATCH]:-$MATCH}"
    zle self-insert
}

# Function to prevent magic abbreviation expansion
no-magic-abbrev-expand() {
    LBUFFER+=' '
}

# Bind abbreviation expansion functions to keys
zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey ' ' magic-abbrev-expand
bindkey '^x ' no-magic-abbrev-expand

export PAGER=less
typeset -Ag abbreviations
abbreviations=(
  'Ia'    '| awk'
  'Ig'    '| grep'
  'Ip'    "| $PAGER"
  'Ih'    '| head'
  'It'    '| tail'
  'Is'    '| sort'
  'Iw'    '| wc'
)

alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -h'
alias free='free -m'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias mkdir='mkdir -pv'
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias cls='clear'

##################
# Configure less #
##################

export LESS="-FSRX"
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'
export LESS_TERMCAP_ue=$'\E[0m'

#######################
# Other Configuration #
#######################

export PATH="$HOME/bin:$PATH"
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
export GREP_OPTIONS="--color=auto"

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

XZ_OPT=-e9
export EDITOR=vim

#######################################
# Load additional config and flavours #
#######################################

## Require zsh-syntax-highlighting
export ZSH_HIGHLIGHT_HOME=$(whereis zsh-syntax-highlighting | awk '{print $2}')
if [[ -f "$ZSH_HIGHLIGHT_HOME/zsh-syntax-highlighting.zsh" ]]; then
  source "$ZSH_HIGHLIGHT_HOME/zsh-syntax-highlighting.zsh"
fi

# Load additional configuration and flavours
for rc in ~/.zshrc-*; do
  source $rc
done
