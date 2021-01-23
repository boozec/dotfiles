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
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gem/ruby/2.7.0/bin:$PATH"
alias mutt=neomutt
export TERM=xterm-256color

rga() {
    RG_PREFIX="rg --files-with-matches"
    local file

    file="$(
        FZF_DEFAULT_COMMAND="$RG_PREFIX '$*'" \
            fzf --sort --preview="[[ ! -z {} ]] && rg --pretty --context 5 {q}" \
                --phony -q "$*"  \
                --bind "change:reload:$RG_PREFIX {q}" \
                --preview-window="70%:wrap"
    )" &&
    xdg-open "$file"
}
