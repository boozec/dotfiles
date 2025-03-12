autoload -Uz colors && colors

# Git status symbols
ZSH_THEME_GIT_PROMPT_CONFLICTED='⚠'
ZSH_THEME_GIT_PROMPT_AHEAD='⇡'
ZSH_THEME_GIT_PROMPT_BEHIND='⇣'
ZSH_THEME_GIT_PROMPT_DIVERGED='⇕'
# ZSH_THEME_GIT_PROMPT_UP_TO_DATE='✓'
ZSH_THEME_GIT_PROMPT_UNTRACKED='?'
ZSH_THEME_GIT_PROMPT_STASHED='$'
ZSH_THEME_GIT_PROMPT_MODIFIED='!'
ZSH_THEME_GIT_PROMPT_STAGED='+'
# ZSH_THEME_GIT_PROMPT_RENAMED='»'
# ZSH_THEME_GIT_PROMPT_DELETED='✘'
ZSH_THEME_GIT_PROMPT_TYPECHANGED='~'

# Function to get git branch name
git_branch_name() {
    local branch=$(git symbolic-ref HEAD 2> /dev/null)
    if [[ -n "$branch" ]]; then
        echo "${branch#refs/heads/}"
    else
        # If not on a branch, get the hash
        echo "$(git rev-parse --short HEAD 2> /dev/null)"
    fi
}

# Function to get git status symbols
git_prompt_status() {
    local git_status=""
    
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        if [[ -n $(git ls-files --other --exclude-standard 2>/dev/null) ]]; then
            git_status+="${ZSH_THEME_GIT_PROMPT_UNTRACKED}"
        fi
        if $(git rev-parse --verify refs/stash >/dev/null 2>&1); then
            git_status+="${ZSH_THEME_GIT_PROMPT_STASHED}"
        fi
        if $(git diff --name-status 2>/dev/null | grep -q "M"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_MODIFIED}"
        fi
        if $(git diff --staged --name-status 2>/dev/null | grep -q "M"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_STAGED}"
        fi
        # if $(git diff --name-status 2>/dev/null | grep -q "R"); then
        #     git_status+="${ZSH_THEME_GIT_PROMPT_RENAMED}"
        # fi
        # if $(git diff --name-status 2>/dev/null | grep -q "D"); then
        #     git_status+="${ZSH_THEME_GIT_PROMPT_DELETED}"
        # fi
        if $(git diff --name-status 2>/dev/null | grep -q "T"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_TYPECHANGED}"
        fi
        if $(git status 2>/dev/null | grep -q "Unmerged"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_CONFLICTED}"
        fi
        if $(git status 2>/dev/null | grep -q "Your branch is ahead"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_AHEAD}"
        fi
        if $(git status 2>/dev/null | grep -q "Your branch is behind"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_BEHIND}"
        fi
        if $(git status 2>/dev/null | grep -q "have diverged"); then
            git_status+="${ZSH_THEME_GIT_PROMPT_DIVERGED}"
        fi
        # if [[ -z "$git_status" && -z $(git status --porcelain 2>/dev/null) ]]; then
        #     git_status+="${ZSH_THEME_GIT_PROMPT_UP_TO_DATE}"
        # fi
    fi
    echo "$git_status"
}

# Function to get git info with symbols
git_prompt_info() {
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        local branch=$(git_branch_name)
        local git_status_symbols=$(git_prompt_status)
        echo "[${branch}${git_status_symbols}]"
    fi
}

# Function to get path (full path or truncated if in git repo)
get_path_info() {
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        # In git repo - show repo name + path within repo
        local git_root=$(git rev-parse --show-toplevel)
        local git_dirname=$(basename "$git_root")
        local path_within_repo="${PWD#$git_root}"
        
        if [[ -z "$path_within_repo" ]]; then
            # We're in the git root directory
            echo "$git_dirname"
        else
            # We're in a subdirectory of the git repo
            echo "$git_dirname$path_within_repo"
        fi
    else
        # Not in git repo - show full path relative to $HOME
        echo "%~"
    fi
}

# Basic prompt
PROMPT='%{$fg_bold[black]%}[%*] '  # Show current time in HH:MM
PROMPT+='%{$fg[yellow]%}%n%{$reset_color%}@%F{#D7005F}%m'
if [[ "$PWD" != "$HOME" ]]; then
    PROMPT+='%{$fg_bold[black]%}:%{$fg[yellow]%}$(get_path_info) '  # Dynamic path display
fi

# Add git info to prompt
PROMPT+='%F{#D7005F}$(git_prompt_info) '  # Git prompt with symbols
PROMPT+='%{$fg[red]%}| '  # Pipe separator
PROMPT+='%{$reset_color%}'  # Reset color
