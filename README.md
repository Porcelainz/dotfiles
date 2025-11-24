# Porcelain's Dotfiles

My personal configuration files for macOS development environment.
Focuses on a light-themed workflow (Catppuccin Latte) for optimal eye comfort against astigmatism.

## 📂 Contents
- **Shell**: Zsh + Powerlevel10k
- **Editor**: Neovim & Antigravity (VS Code Fork)
- **Social**: Discord (Vencord) CSS
- **Music**: Spotify (Spicetify) Theme

---

## 🚀 Installation Guide

### 1. Pre-requisites
Install Homebrew first:
```bash
/bin/bash -c "$(curl -fsSL [https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh](https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh))"

### 2. Setup Zsh
# Backup
mv ~/.zshrc ~/.zshrc.backup

# Symlink (Recommended)
ln -sf ~/dotfiles/.zshrc ~/.zshrc

### 3. Setup Neovim
ln -sf ~/dotfiles/.config/nvim ~/.config/nvim
### 4. Setup Antigravity (VS Code Mod)
cp ~/dotfiles/antigravity/settings.json ~/Library/Application\ Support/Antigravity/User/
cp ~/dotfiles/antigravity/keybindings.json ~/Library/Application\ Support/Antigravity/User/

### 4. Restore Themes (Manual Steps)
Discord (Vencord)
1.Install Vencord.

2.Open Discord Settings -> Vencord -> Edit QuickCSS.

3.Copy content from vencord_custom.css in this repo and paste it there.

4.Reload Discord.

Spotify (Spicetify)
1.Install Spicetify CLI.

2.Run:
spicetify config custom_apps marketplace
spicetify backup apply