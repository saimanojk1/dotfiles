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
