# now use Starship instead of oh-my-zsh theme
export ZSH="/home/dcariotti/.oh-my-zsh"
#ZSH_THEME="essembeh"
ZSH_THEME="lukerandall"
plugins=(
 git
 zsh-autosuggestions
 zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

#eval "$(starship init zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$PATH:/usr/local/go/bin

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export WORKON_HOME=$HOME/.virtualenvs
source /usr/share/virtualenvwrapper/virtualenvwrapper.sh

eval "$(direnv hook zsh)"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
alias mutt=neomutt
export TERM=xterm-256color

fpath+=${ZDOTDIR:-~}/.zsh_functions

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
