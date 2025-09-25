# Quick dotfiles update aliases (zsh)
alias dots-sync='cd ~/.dotfiles && git add . && git commit -m "Update: $(date)" && git push'
alias dots-pull='cd ~/.dotfiles && git pull'
alias dots-status='cd ~/.dotfiles && git status'

# Additional zsh-specific aliases
alias reload-zsh='source ~/.zshrc'
alias edit-zsh='$EDITOR ~/.zshrc'