HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:$HOME/.tmuxifier/bin"

export EDITOR="/opt/nvim-linux64/bin/nvim"
export PATH="$PATH:$HOME/.tmuxifier/bin"
eval "$(tmuxifier init -)"
export EDITOR="/opt/nvim-linux64/bin/nvim"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
cd /local/repos
cd $(find * -type d | fzf)
tmuxifier s mfs-project


# Set up the prompt
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{cyan}%n%F{reset_color%}@%F{green}%m%f %F{yellow}%~%f %F{red}${vcs_info_msg_0_}%f$ '


setopt histignorealldups sharehistory


# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY
# Use modern completion system
autoload -Uz compinit
compinit


export fpath=(/home/ekomman/.zsh/gradle-completion $fpath)

export fpath=(/home/ekomman/.zsh/_helm $fpath)

export fpath=(/home/ekomman/.zsh $fpath)
source <(kubectl completion zsh)


zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    eval "$(dircolors ~/.dir_colors)" 
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias k='kubectl'
alias kc='kubectl config'

function nd() {
  cd "$@"
  local toGoDir=$(fd -t d ".*" | fzf)
  if [ -n "$toGoDir" ]; then
    cd "$toGoDir"
  fi
  nvim
}


function cf() {
  cd "$@"
  local toGoDir=$(fd -t d ".*" | fzf)
  if [ -n "$toGoDir" ]; then
    cd "$toGoDir"
  fi
}
# Custom completion for cf command

_cf_completion() {
    _directories
}

compdef _cf_completion cf
compdef _cf_completion nd





autoload -U +X bashcompinit && bashcompinit


