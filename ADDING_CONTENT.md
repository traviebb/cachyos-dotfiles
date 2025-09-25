# Adding Content to Your Dotfiles

This guide explains how to add different types of content to your dotfiles repository.

## 📁 Configuration Folders

### Adding New Config Directories
```bash
# Example: Adding VS Code settings
mkdir -p ~/.dotfiles/vscode
cp -r ~/.config/Code/User/settings.json ~/.dotfiles/vscode/
cp -r ~/.config/Code/User/keybindings.json ~/.dotfiles/vscode/

# Example: Adding Neovim config
mkdir -p ~/.dotfiles/nvim
cp -r ~/.config/nvim/* ~/.dotfiles/nvim/

# Example: Adding Alacritty terminal config
mkdir -p ~/.dotfiles/alacritty
cp -r ~/.config/alacritty/* ~/.dotfiles/alacritty/
```

### Update install.sh
After adding new configs, update your install script:
```bash
# Add to install.sh in the main() function:
if [ -d "$DOTFILES_DIR/vscode" ]; then
    print_status "Installing VS Code configuration..."
    ensure_dir "$HOME/.config/Code/User"
    backup_file "$HOME/.config/Code/User/settings.json"
    create_symlink "$DOTFILES_DIR/vscode/settings.json" "$HOME/.config/Code/User/settings.json"
fi
```

## 🖼️ Images and Media Files

### Wallpapers
```bash
mkdir -p ~/.dotfiles/wallpapers
cp ~/Pictures/wallpaper.jpg ~/.dotfiles/wallpapers/
```

### Icons and Themes
```bash
mkdir -p ~/.dotfiles/icons
mkdir -p ~/.dotfiles/themes
cp -r ~/.local/share/icons/custom-icon-theme ~/.dotfiles/icons/
cp -r ~/.themes/custom-theme ~/.dotfiles/themes/
```

### Screenshots for Documentation
```bash
mkdir -p ~/.dotfiles/screenshots
# Add screenshots of your setup
cp ~/Pictures/desktop-screenshot.png ~/.dotfiles/screenshots/
```

## 📄 Documents and Scripts

### Custom Scripts
```bash
mkdir -p ~/.dotfiles/scripts/system
mkdir -p ~/.dotfiles/scripts/development

# Add your custom scripts
echo '#!/bin/bash
# System update script
sudo pacman -Syu && yay -Syu' > ~/.dotfiles/scripts/system/update-system.sh

chmod +x ~/.dotfiles/scripts/system/update-system.sh
```

### Configuration Templates
```bash
mkdir -p ~/.dotfiles/templates
# Add template files for new projects
```

### Documentation
```bash
mkdir -p ~/.dotfiles/docs
# Add setup guides, notes, etc.
```

## ⚙️ System Configurations

### Systemd Services
```bash
mkdir -p ~/.dotfiles/systemd
cp ~/.config/systemd/user/my-service.service ~/.dotfiles/systemd/
```

### Fonts
```bash
mkdir -p ~/.dotfiles/fonts
cp -r ~/.local/share/fonts/CustomFont ~/.dotfiles/fonts/
```

## 🔄 Adding to Git

### Basic Workflow
```bash
# 1. Add new content
git add .

# 2. Commit with descriptive message
git commit -m "Add VS Code configuration and custom scripts"

# 3. Push to GitHub
git push
```

### For Large Files
For large media files, consider:
```bash
# Use Git LFS for large files (install git-lfs first)
sudo pacman -S git-lfs
git lfs track "*.png" "*.jpg" "*.mp4"
git add .gitattributes
```

## 📝 Best Practices

### File Organization
```
~/.dotfiles/
├── fish/           # Shell config
├── git/            # Git config
├── starship/       # Prompt config
├── vscode/         # Editor config
├── alacritty/      # Terminal config
├── hypr/           # Window manager
├── wallpapers/     # Desktop backgrounds
├── scripts/        # Custom scripts
│   ├── system/
│   └── development/
├── themes/         # Custom themes
├── fonts/          # Custom fonts
├── docs/           # Documentation
└── screenshots/    # Setup screenshots
```

### What NOT to Include
- Personal API keys or passwords
- Large binary files (unless using Git LFS)
- Temporary files or caches
- Browser data or personal files
- Private keys or certificates

### .gitignore Additions
Add to your .gitignore:
```
# Personal data
*.key
*.pem
*password*
*secret*

# Large files
*.iso
*.vmdk

# Temporary files
*.tmp
*.swp
.DS_Store
```

## 🔄 Keeping Things Synced

### Regular Updates
```bash
# Create an alias for easy updates
alias dots-update='cd ~/.dotfiles && git add . && git commit -m "Update configs" && git push'
```

### Pulling Updates
```bash
cd ~/.dotfiles
git pull
./install.sh  # Re-run installation if needed
```