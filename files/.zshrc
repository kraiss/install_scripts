autoload -U zmv
autoload -U zcp
# Charge les couleurs
autoload -U colors
colors

autoload -Uz vcs_info

autoload -Uz compinit
compinit -u

autoload zargs

zmodload zsh/complist

magic-abbrev-expand() {
    local MATCH
    LBUFFER="${LBUFFER%%(#m)[_a-zA-Z0-9]#}"
    LBUFFER+="${abbreviations[$MATCH]:-$MATCH}"
    zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

auto-ls () {
  if [[ $#BUFFER -eq 0 ]]; then
      echo ""
      ls --color
      zle redisplay
  else
      zle .$WIDGET
  fi
}

zle -N auto-ls
zle -N accept-line auto-ls
zle -N other-widget auto-ls


zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey ' ' magic-abbrev-expand
bindkey '^x ' no-magic-abbrev-expand
#############################
# Configuration des options #
#############################

# Permet d'ajouter les répertoires dans les quels on navigue dans une pile
# de manière automatique
setopt AUTO_PUSHD
setopt PUSHDMINUS
#setopt printeightbit
setopt CORRECT # Correction des commandes
setopt COMPLETE_IN_WORD # Complétion à l'interieur d'un mot
setopt ALWAYS_TO_END # Positionne à la fin lors de la complétion
setopt APPENDHISTORY # Ajout les historiques
# Pour avoir le même historique dans tous les shells
setopt INC_APPEND_HISTORY SHARE_HISTORY
# Mode verbose (date, ...) ; incompatible avec les autres shells
setopt EXTENDED_HISTORY

setopt AUTOCD # Faire un cd sans cd
setopt NOTIFY # Notifie instantanément les fin de process
setopt EXTENDEDGLOB # Permet d'utiliser le find de zsh
setopt NULL_GLOB
setopt GLOB_DOTS
setopt NOHUP

unsetopt HIST_VERIFY # Supprime la vérification lors de l'usage de "!cmd"
unsetopt LIST_AMBIGUOUS # Modifie la manière dont est gérée l'autocomplétement

# Supprime les  répétitions dans le fichier  d'historique, ne conservant
# que la dernière occurrence ajoutée
setopt HIST_IGNORE_ALL_DUPS

# La recherche dans  l'historique avec l'éditeur de commandes  de zsh ne
# montre  pas  une même  ligne  plus  d'une fois,  même  si  elle a  été
# enregistrée
setopt HIST_FIND_NO_DUPS

# Permet d'utiliser des variables en prompt
setopt PROMPT_SUBST

# Gestion des raccourcis (emacs ou vi)
# les deux formes fonctionnent
#set -o emacs
#bindkey -v

# Améliore les messages d'auto-complètement
zstyle :compinstall filename '${HOME}/.zshrc'
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BDésolé, rien de trouvé pour: %d%b'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=31"

# Modifie la forme des infos de CVS
zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:*' formats '%F{5}(%f%s:%b%F{5})%F{3}-%F{5}[%F{2}%r/%S%F{5}]%f '
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

#########################
## Définition du prompt #
#########################
export RPROMPT="[%{$fg[green]%}%*%{$reset_color%}]"
export PS2='>'

precmd() {
  vcs_info
  if [[ -z "${vcs_info_msg_0_}" ]]; then
    PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%B%{$fg[blue]%}%~%b%{$reset_color%} ${vcs_info_msg_0_}%f%(?.. [%?])%# '
  else
    PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%{$reset_color%}${vcs_info_msg_0_}%f%(?.. [%?])%# '
  fi
}
vcs_info
if [[ -z "${vcs_info_msg_0_}" ]]; then
  PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%B%{$fg[blue]%}%~%b%{$reset_color%} ${vcs_info_msg_0_}%f%(?.. [%?])%# '
else
  PROMPT='%{$fg[red]%}%n%{$reset_color%}@%M:%{$reset_color%}${vcs_info_msg_0_}%f%(?.. [%?])%# '
fi

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

################################
# Initialisation des variables #
################################

# Gestion de lhistorique
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=${HISTSIZE}

function addPath () {
  [[ -d "$1" ]] && PATH="${PATH}:$1"
}

function addPathPrim () {
  [[ -d "$1" ]] && PATH="$1:${PATH}"
}

function setIfDirExist () {
  [[ -d "$2" ]] && export "$1"="$2"
}

function setDirAliasIfExist() {
    [[ -d "$2" ]] && hash -d "$1"="$2"
}

#########################
# Configuration de less #
#########################

# Permettre à less di lire plusieurs formats
#export LESSCHARSET=latin9
eval $(lesspipe)

export LESS="-FSRX" # voir man
# Permet d'avoir les man en couleur
export LESS_TERMCAP_mb=$'\E[01;31m'    # début de blink
export LESS_TERMCAP_md=$'\E[01;31m'    # début de gras
export LESS_TERMCAP_me=$'\E[0m'        # fin
export LESS_TERMCAP_so=$'\E[01;44;33m' # début de la ligne d`état
export LESS_TERMCAP_se=$'\E[0m'        # fin
export LESS_TERMCAP_us=$'\E[01;32m'    # début de souligné
export LESS_TERMCAP_ue=$'\E[0m'        # fin

export GREP_OPTIONS="--color=auto"

export LANG="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"

XZ_OPT=-e9

export EDITOR=vim

## Require zsh-syntax-highlighting
if [[ -f "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
  source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

## Require NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Load Angular CLI autocompletion.
source <(ng completion script)
