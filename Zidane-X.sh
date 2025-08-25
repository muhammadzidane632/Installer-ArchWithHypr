#!/bin/bash
# ========================================================
#    🚀 Zidane-X Arch Linux Minimal Auto Installer 🚀
# ========================================================
# Author : Zidane-X
# Tujuan : Install Arch Linux minimal (tanpa DE/WM) 
#          + dev tools penting + git clone Hyprland
# Catatan: Sesuaikan USERNAME, PASSWORD, DISK sebelum jalan
# ========================================================

# --- KONFIGURASI USER ---
DISK="/dev/sda"          # Ganti sesuai disk target (contoh: /dev/nvme0n1)
HOSTNAME="zidane-arch"   # Nama host
USERNAME="zidane"        # Nama user
PASSWORD="zidane123"     # Password user & root

# --- Animasi Loading ---
loading() {
    local msg=$1
    echo -ne "\n[ Zidane-X ] $msg..."
    for i in {1..5}; do
        echo -ne "▓"
        sleep 0.2
    done
    echo " ✅"
}


clear
echo "========================================"
echo "   🚀  Zidane-X Arch Linux Installer 🚀"
echo "========================================"


loading "Mengatur jam sistem"
timedatectl set-ntp true

# --- Tahap 2: Partisi Disk dengan konfirmasi ---
loading "Cek partisi pada $DISK"
lsblk $DISK

echo -ne "\n[ Zidane-X ] ⚠️ PERINGATAN: Semua data pada $DISK akan HILANG (termasuk Windows & lainnya)!"
read -p " Apakah kamu yakin ingin menghapus semua partisi? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo "[ Zidane-X ] Proses dibatalkan ❌"
    exit 1
fi

loading "Menghapus partisi lama & membuat tabel baru"
sgdisk -Z $DISK
sgdisk -n1:0:+512M -t1:ef00 $DISK
sgdisk -n2:0:+8G   -t2:8200 $DISK
sgdisk -n3:0:0     -t3:8300 $DISK

# --- Tahap 3: Format Partisi ---
loading "Format partisi"
mkfs.fat -F32 ${DISK}1
mkswap ${DISK}2
swapon ${DISK}2
mkfs.ext4 ${DISK}3

# --- Tahap 4: Mount Partisi ---
loading "Mount partisi"
mount ${DISK}3 /mnt
mkdir /mnt/boot
mount ${DISK}1 /mnt/boot

# --- Tahap 5: Install Sistem Dasar ---
loading "Instalasi paket dasar"
pacstrap /mnt base linux linux-firmware nano networkmanager git

# --- Tahap 6: Generate fstab ---
loading "Membuat fstab"
genfstab -U /mnt >> /mnt/etc/fstab

# --- Tahap 7: Konfigurasi dalam chroot ---
loading "Masuk chroot dan konfigurasi"
arch-chroot /mnt /bin/bash <<EOF
ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
hwclock --systohc

echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
echo "id_ID.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo "$HOSTNAME" > /etc/hostname
cat <<HOSTS > /etc/hosts
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain   $HOSTNAME
HOSTS

# Buat root & user
echo "root:$PASSWORD" | chpasswd
useradd -m -G wheel $USERNAME
echo "$USERNAME:$PASSWORD" | chpasswd

# Install bootloader
pacman -S --noconfirm sudo grub efibootmgr
echo "%wheel ALL=(ALL:ALL) ALL" >> /etc/sudoers
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=ARCH
grub-mkconfig -o /boot/grub/grub.cfg

# Enable NetworkManager
systemctl enable NetworkManager

# Install dev tools tambahan
pacman -S --noconfirm nano git curl wget cmake make gcc clang base-devel imagemagick go

# Git clone Arch-Hyprland ke home user (~)
sudo -u $USERNAME git clone --depth 1 https://github.com/JaKooLit/Arch-Hyprland ~/
EOF

# --- Tahap 8: Selesai ---
loading "Proses selesai, unmount partisi"
umount -R /mnt

echo -e "\n🎉 Instalasi Arch Linux minimal + tools + clone Hyprland by Zidane-X selesai!"
echo -e "👉 Reboot sekarang dengan perintah: reboot"
