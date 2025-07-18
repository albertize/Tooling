# Current git branch
git_branch() {
    local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ -n "$branch" ]; then
        echo "[git:$branch] "
    fi
}

# Prompt
PS1='\[\033[0;32m\]$(git_branch)\[\033[0m\]\[\033[0;36m\]\u\[\033[0m\]:\[\033[0;33m\]\W\[\033[0m\]> '

# Custom aliases
alias cls='clear'
