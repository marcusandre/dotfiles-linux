# .zshrc.sensible

bindkey -e
setopt NO_BEEP
setopt PRINT_EIGHT_BIT
setopt NO_FLOW_CONTROL
setopt LIST_PACKED
REPORTTIME=60
WORDCHARS="*?_-.[]~&;$%^+"

[[ -n $terminfo[khome] ]] && bindkey $terminfo[khome] beginning-of-line
[[ -n $terminfo[kend]  ]] && bindkey $terminfo[kend]  end-of-line
[[ -n $terminfo[kdch1] ]] && bindkey $terminfo[kdch1] delete-char

# path
[ -d ~/bin ] && export PATH=$PATH:~/bin
[ -d ~/go/bin ] && export PATH=$PATH:~/go/bin
[ -d ~/.yarn/bin ] && export PATH=$PATH:~/.yarn/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.cargo/env ] && source ~/.cargo/env

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# paste urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

# globs
setopt EXTENDED_GLOB
disable -p '^'

# dir stack
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_MINUS

# continue disowned jobs
setopt AUTO_CONTINUE

# history
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
SAVEHIST=9000
HISTSIZE=9000
HISTFILE=~/.zsh_history

# completion
zmodload zsh/complist
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select=2

eval $(dircolors)
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

export EDITOR=vim
export VISUAL=$EDITOR

# prompt
# setopt PROMPT_SUBST
# PS1='%B%m%(?.. %??)%(1j. %j&.)%b %~%B%(!.%F{red}.%F{yellow})%#${SSH_CONNECTION:+%#} %b%f'
# PS2='%_%B%(!.%F{red}.%F{yellow})> %b%f'

NDIRS=2
gitpwd() {
  local -a segs splitprefix; local gitprefix branch
  segs=("${(Oas:/:)${(D)PWD}}")
  segs=("${(@)segs/(#b)(?(#c10))??*(?(#c5))/${(j:\u2026:)match}}")

  if gitprefix=$(git rev-parse --show-prefix 2>/dev/null); then
    splitprefix=("${(s:/:)gitprefix}")
    if ! branch=$(git symbolic-ref -q --short HEAD); then
      branch=$(git name-rev --name-only HEAD 2>/dev/null)
      [[ $branch = *\~* ]] || branch+="~0"    # distinguish detached HEAD
    fi
    if (( $#splitprefix > NDIRS )); then
      print -n "${segs[$#splitprefix]}@$branch "
    else
      segs[$#splitprefix]+=@$branch
    fi
  fi

  (( $#segs == NDIRS+1 )) && [[ $segs[-1] == "" ]] && print -n /
  print "${(j:/:)${(@Oa)segs[1,NDIRS]}}"
}

nbsp=$'\u00A0'
cnprompt6() {
  case "$TERM" in
    xterm*|rxvt*)
      precmd() { [[ -t 1 ]] && print -Pn "\e]0;%m: %~\a" }
      preexec() { [[ -t 1 ]] && print -n "\e]0;$HOST: ${(q)2//[$'\t\n\r']/ }\a" }
  esac
  setopt PROMPT_SUBST
  PS1='%B%m${TENV:+ [$TENV]}%(?.. %??)%(1j. %j&.)%b $(gitpwd)%B%(!.%F{red}.%F{yellow})%#${SSH_CONNECTION:+%#}$nbsp%b%f'
  RPROMPT=''
}

cnprompt6

# aliases
alias ..="cd .."
alias gb="git branch -a --color -v"
alias gd="git diff --color"
alias gl='git l'
alias gll='git ll'
alias gp="git push"
alias gr='cd "$(git root)"'
alias ll="exa -lFa --git --git-ignore -I '.git$'"
alias ns="cat package.json | jq '.scripts'"
alias rf="rm -fr"
alias s="git status -sb"
alias t="tree -a -I '.git|node_modules'"
alias lip="ip a | grep 192 | awk '{print \$2}' | cut -d '/' -f 1"
alias wttr='curl https://de.wttr.in/Gruenstadt'
alias rate='curl eur.rate.sx'
alias latencies='curl cheat.sh/latencies'

md () {
  mkdir -p "$1"
  cd "$1"
}

# opam configuration
test -r /home/m/.opam/opam-init/init.zsh && . /home/m/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
