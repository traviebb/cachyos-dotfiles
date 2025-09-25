# Fish Shell Configuration

# Environment Variables
set -gx EDITOR micro
set -gx BROWSER firefox
set -gx PAGER less
set -gx MANPAGER "less -X"

# Add local bin to PATH
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_add_path ~/.cargo/bin

# Aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias cls='clear'
alias h='history'
alias j='jobs'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Git aliases
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit -a'
alias gcam='git commit -am'
alias gco='git checkout'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log --oneline --graph --decorate'
alias gla='git log --oneline --graph --decorate --all'
alias gp='git push'
alias gpl='git pull'
alias gs='git status'
alias gst='git stash'
alias gstp='git stash pop'

# System aliases
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -R'
alias autoremove='sudo pacman -Rns'
alias yayu='yay -Syu'
alias yayi='yay -S'
alias yays='yay -Ss'

# Docker aliases (if docker is installed)
if command -v docker > /dev/null
    alias d='docker'
    alias dc='docker-compose'
    alias dps='docker ps'
    alias di='docker images'
    alias drm='docker rm'
    alias drmi='docker rmi'
    alias dprune='docker system prune -af'
end

# Kubernetes aliases (if kubectl is installed)
if command -v kubectl > /dev/null
    alias k='kubectl'
    alias kgp='kubectl get pods'
    alias kgs='kubectl get services'
    alias kgd='kubectl get deployments'
    alias kdp='kubectl describe pod'
    alias kds='kubectl describe service'
    alias kdd='kubectl describe deployment'
end

# Functions
function mkcd
    mkdir -p $argv[1] && cd $argv[1]
end

function extract
    if test -f $argv[1]
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar x $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z x $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via extract()"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function weather
    if test (count $argv) -eq 0
        curl "wttr.in"
    else
        curl "wttr.in/$argv[1]"
    end
end

function ports
    netstat -tulanp
end

function myip
    curl -s http://ipecho.net/plain; echo
end

function cl
    cd $argv[1] && ls
end

function backup
    if test (count $argv) -eq 1
        cp "$argv[1]" "$argv[1].backup"
        echo "Backed up $argv[1] to $argv[1].backup"
    else
        echo "Usage: backup <file>"
    end
end

function find_largest
    find . -type f -exec du -h {} + | sort -rh | head -20
end

# Git functions
function git_branch_cleanup
    git branch --merged | grep -v '\*\|master\|main\|develop' | xargs -n 1 git branch -d
end

function git_undo_commit
    git reset --soft HEAD~1
end

# Starship prompt initialization
if command -v starship > /dev/null
    starship init fish | source
end

# Enable vi mode
fish_vi_key_bindings

# Disable greeting
set fish_greeting

# Custom completions
complete -c extract -a "(__fish_complete_suffix .tar.bz2 .tar.gz .bz2 .rar .gz .tar .tbz2 .tgz .zip .Z .7z)"
# Source additional aliases
if test -f ~/.config/fish/aliases.fish
    source ~/.config/fish/aliases.fish
end
