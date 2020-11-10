# now use Starship instead of oh-my-zsh theme
export ZSH="/home/dcariotti/.oh-my-zsh"
plugins=(git)

source $ZSH/oh-my-zsh.sh

[[ $TERM != "screen" ]] && exec tmux
eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export WORKON_HOME=$HOME/.virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

eval "$(direnv hook zsh)"
