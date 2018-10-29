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

# prompt
setopt PROMPT_SUBST
PS1='%B%m%(?.. %??)%(1j. %j&.)%b %~%B%(!.%F{red}.%F{yellow})%#${SSH_CONNECTION:+%#} %b%f'
PS2='%_%B%(!.%F{red}.%F{yellow})> %b%f'

# aliases
alias gb="git branch -a --color -v"
alias gd="git diff --color"
alias gr="git rev-parse --show-toplevel"
alias ll="ls -lah"
alias rf="rm -fr"
alias s="git status -sb"
alias t="tree -a -I '.git|node_modules'"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
