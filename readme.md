# ⚡ Zidane-X Arch Linux Minimal Auto Installer

![Arch Linux Logo](https://upload.wikimedia.org/wikipedia/commons/a/a5/Archlinux-icon-crystal-64.svg)

## 📌 Description
**Zidane-X Arch Linux Minimal Auto Installer** is a shell script that automates the installation of Arch Linux with minimal manual steps.  

It is designed for users who want a **fast, clean, and ready-to-customize Arch setup**, without going through the hassle of manual partitioning, base system installation, and initial configuration.

---

## ✨ Features
- 🚀 Automated disk partitioning and formatting (with confirmation).  
- 📦 Base system installation with essential development tools.  
- 🖥️ Hostname, timezone, locale, and user creation pre-configured.  
- 🔗 [Arch-Hyprland](https://github.com/JaKooLit/Arch-Hyprland) automatically cloned into the user’s home directory.  
- 🔒 Sudo enabled for the wheel group.  
- 🌐 NetworkManager enabled by default.  

---

## 🛠️ Installation

1. Boot into an **Arch Linux live environment**.  
2. Connect to the internet:
   ```bash
   iwctl    # or use nmcli
   
3. In the last If You Want To install Hyprland Tooo...

## Move To Arch-Hyprland Directory
cd ~/Arch-Hyprland

## add Permission :
chmod +x ./install.sh

## Run It.. Automaticly Install (U can Customize It)
./install.sh
