#!/usr/bin/env bash

# Dotfiles installation script
# This script backs up existing dotfiles and creates symlinks to the new ones

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directories
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to backup a file if it exists
backup_file() {
    local file="$1"
    local backup_path="$BACKUP_DIR/$(basename "$file")"
    
    if [ -e "$file" ]; then
        if [ ! -L "$file" ]; then  # Only backup if it's not already a symlink
            print_status "Backing up $file to $backup_path"
            cp "$file" "$backup_path"
        else
            print_status "Removing existing symlink $file"
            rm "$file"
        fi
    fi
}

# Function to create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    print_status "Creating symlink $target -> $source"
    ln -sf "$source" "$target"
}

# Function to create directory if it doesn't exist
ensure_dir() {
    local dir="$1"
    if [ ! -d "$dir" ]; then
        print_status "Creating directory $dir"
        mkdir -p "$dir"
    fi
}

main() {
    print_status "Starting dotfiles installation..."
    print_status "Dotfiles directory: $DOTFILES_DIR"
    
    # Create backup directory
    ensure_dir "$BACKUP_DIR"
    
    # Fish configuration
    if [ -d "$DOTFILES_DIR/fish" ]; then
        print_status "Installing Fish configuration..."
        ensure_dir "$HOME/.config/fish"
        backup_file "$HOME/.config/fish/config.fish"
        create_symlink "$DOTFILES_DIR/fish/config.fish" "$HOME/.config/fish/config.fish"
    fi
    
    # Git configuration
    if [ -d "$DOTFILES_DIR/git" ]; then
        print_status "Installing Git configuration..."
        backup_file "$HOME/.gitconfig"
        backup_file "$HOME/.gitignore_global"
        create_symlink "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
        create_symlink "$DOTFILES_DIR/git/gitignore_global" "$HOME/.gitignore_global"
        
        print_warning "Please update your name and email in ~/.gitconfig"
        print_warning "Run: git config --global user.name 'Your Name'"
        print_warning "Run: git config --global user.email 'your.email@example.com'"
    fi
    
    # Starship configuration
    if [ -f "$DOTFILES_DIR/starship/starship.toml" ]; then
        print_status "Installing Starship configuration..."
        ensure_dir "$HOME/.config"
        backup_file "$HOME/.config/starship.toml"
        create_symlink "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
    fi
    
    # Hyprland configuration (if exists)
    if [ -d "$DOTFILES_DIR/hypr" ] && [ -d "$HOME/.config/hypr" ]; then
        print_status "Found Hyprland configuration directory..."
        print_warning "Hyprland config symlinking skipped - please review manually"
        print_warning "Your existing Hyprland config is preserved"
    fi
    
    # Make scripts executable
    if [ -d "$DOTFILES_DIR/scripts" ]; then
        print_status "Making scripts executable..."
        find "$DOTFILES_DIR/scripts" -type f -name "*.sh" -exec chmod +x {} \;
    fi
    
    print_success "Dotfiles installation completed!"
    print_status "Backup files are stored in $BACKUP_DIR"
    print_status "Please restart your shell or run: source ~/.config/fish/config.fish"
    
    # Check if we need to install fish
    if ! command -v fish >/dev/null 2>&1; then
        print_warning "Fish shell is not installed. Install it with:"
        print_warning "sudo pacman -S fish"
        print_warning "Then set it as default: chsh -s /usr/bin/fish"
    fi
    
    # Check if we need to install starship
    if ! command -v starship >/dev/null 2>&1; then
        print_warning "Starship prompt is not installed. Install it with:"
        print_warning "sudo pacman -S starship"
    fi
}

# Run the main function
main "$@"