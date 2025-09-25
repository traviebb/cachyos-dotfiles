# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Development Commands

### Installation and Setup
```bash
# Install dotfiles and create symlinks
./install.sh

# Check installation status
ls -la ~/.config/fish/config.fish ~/.zshrc ~/.gitconfig ~/.config/starship.toml
```

### Dotfiles Management
```bash
# Quick sync dotfiles to git (from anywhere)
dots-sync

# Pull latest changes
dots-pull

# Check dotfiles status
dots-status

# Manual git operations
cd ~/.dotfiles && git status
cd ~/.dotfiles && git add . && git commit -m "Update configs" && git push
```

### Testing and Validation
```bash
# Test fish configuration syntax
fish -n ~/.dotfiles/fish/config.fish

# Test zsh configuration syntax
zsh -n ~/.dotfiles/zsh/zshrc

# Test shell functions (fish)
fish -c "extract --help"
fish -c "weather"
fish -c "myip"

# Test shell functions (zsh)
zsh -c "weather"
zsh -c "myip"

# Test starship configuration
starship config

# Validate git configuration
git config --list --global
```

## Architecture and Structure

### Core Components

**Installation System (`install.sh`)**
- Automated backup and symlink creation system
- Supports fish, git, and starship configurations  
- Creates backups in `~/.dotfiles_backup/` before overwriting
- Handles prerequisite checking and provides installation guidance

**Fish Shell Configuration (`fish/`)**
- Main config in `config.fish` with environment variables, aliases, and functions
- Modular alias system in `aliases.fish` for dotfiles management
- Custom functions for common tasks: `mkcd`, `extract`, `weather`, `backup`
- Git workflow functions: `git_branch_cleanup`, `git_undo_commit`
- Conditional loading of docker/kubernetes aliases based on tool availability

**Zsh Shell Configuration (`zsh/`)**
- Main config in `zshrc` with Oh My Zsh integration and Spaceship prompt
- Same aliases and functions as fish shell for consistency
- System-wide plugin loading for autosuggestions and syntax highlighting
- Conditional plugin loading to avoid conflicts and recursion issues

**Git Configuration (`git/`)**
- Comprehensive alias system in `gitconfig` for streamlined workflows
- Global gitignore in `gitignore_global` for common ignore patterns
- Custom log formatting and color schemes
- GitHub CLI credential helper integration

**Starship Prompt (`starship/starship.toml`)**
- Custom powerline-style prompt with emoji and Unicode symbols
- Git integration showing branch, status, and repository state
- Directory path truncation and substitution for common folders
- Command duration tracking and user/hostname display

### Key Patterns

**Symlink-based Configuration Management**
- All configurations are symlinked from the dotfiles repo to their target locations
- Original files are backed up before symlinking
- This allows version control of all configurations while maintaining system compatibility

**Conditional Feature Loading**
- Fish config conditionally loads docker/kubernetes aliases only when tools are available
- Starship initialization only occurs if starship is installed
- This pattern allows the configs to work across different development environments

**Comprehensive Alias System**
- Three-tier alias system: basic shell operations, git workflows, system package management
- Follows naming conventions: short form (`g` for git), logical grouping (`ga`, `gb`, `gc`)
- System-specific aliases for CachyOS (pacman/yay integration)

### Development Workflow Integration

The dotfiles are designed for a CachyOS Linux development environment with:
- Fish shell or Zsh shell (with Oh My Zsh) as the primary shell
- Starship (fish) or Spaceship (zsh) for enhanced prompting
- Micro as the default editor
- Git with GitHub CLI integration
- Docker and Kubernetes development support
- Consistent aliases and functions across both shells

The installation script checks for required tools and provides guidance for missing dependencies, making the setup process self-documenting.