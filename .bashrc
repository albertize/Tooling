# Git branch
git_branch() {
    local branch
    branch=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')

    if [ -n "$branch" ]; then
        echo "  $branch"
    fi
}

# Prompt
PS1='\[\033[1;34m\]\u\[\033[0m\]@\[\033[1;34m\]\h\[\033[0m\] \[\033[0;37m\]\W\[\033[0m\]\[\033[0;34m\]$(git_branch)\[\033[0m\] \[\033[1;34m\]❯\[\033[0m\] '
