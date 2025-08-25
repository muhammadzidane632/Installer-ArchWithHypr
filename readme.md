# Zidane-X Arch Installer ⚡  

A minimal Arch Linux auto installer by **Zidane-X** – fast, clean, and ready for customization.  
This script formats your disk, installs Arch Linux with essential packages, and sets up a ready-to-use environment.  

---

## 🚀 Features
- Automatic disk partitioning and formatting (**⚠ wipes existing data**).  
- Installs Arch Linux base system with essential firmware and tools.  
- Creates a user account.  
- Clones necessary repositories into `~`.  
- Easy to extend with your own `.sh` customization.  

---

## 📥 Installation  

### 1. From an existing Linux system  

git clone https://github.com/USERNAME/ZidaneX-ArchInstaller.git
cd ZidaneX-ArchInstaller
chmod +x Zidane-X.sh
./Zidane-X.sh

# Install git inside archiso
```bash bashpacman -Sy git```

# Clone this repository
```git clone https://github.com/USERNAME/ZidaneX-ArchInstaller.git```
```cd ZidaneX-ArchInstaller```

# Run the installer
```chmod +x Zidane-X.sh```
```./Zidane-X.sh```

# Optional Install Hyprland (After Install Base System Arch)
```cd ~/Arch-Hyprland```
```chmod +x install.sh```
```./install.sh```
