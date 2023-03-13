#! /usr/bin/env bash

#get absolute path from this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
RES_DIR=$SCRIPT_DIR/Resources
PKG_LIST=$RES_DIR/yay-list.lst
FSTAB_ADD=$RES_DIR/samba-shares-list.lst
CREDS=$HOME/.smb-creds.txt

#install yay from aur
cd $HOME
sudo pacman -Syu --noconfirm
sudo pacman -S git base-devel
git clone http://aur.archlinux.org/yay-bin.git
cd ./yay-bin
makepkg -si --needed
cd $SCRIPT_DIR
rm -r $HOME/yay-bin

#install all packages from list
yay -S --needed --noconfirm - < $PKG_LIST

#enable libvirtd
sudo systemctl enable --now libvirtd

# create smb-additions
read -p "IP-Adresse des Shares: " IP
read -p "Wie viele Shares gibt es hier?: " NUMOSHARES
SHARES=()
for i in {0..$NOMUSHARES}
do
    read -p "Name des shares: " TEMP
    SHARES+=($TEMP)

# smb-shares into fstab
un='username='
pw='password='
read -p "Username: " USERNAME
echo das Passwort wird nicht angezeigt!
read -s -p "Password: " PASSWORD
echo "$un$USERNAME" > $CREDS
echo "$pw$PASSWORD" >> $CREDS
echo "Bitte überprüfe die Datei samba-shares-list.txt auf Fehler, diese werden sonst in die fstab geschrieben!"
read -p "Bitte mit ENTER bestätigen"
fstab=$(cat $SCRIPT_DIR'/samba-shares-list.txt')
echo "$fstab" | sudo tee -a /etc/fstab > /dev/null

# Insert something into .bashrc by default
echo "Bitte überprüfe die Datei bashrc-additions.txt auf Fehler, diese werden sonst in die .bashrc geschrieben!"
read -p "Bitte mit ENTER bestätigen"
bashrc=$(cat $SCRIPT_DIR'/bashrc-additions.txt')
echo "$bashrc" | tee -a $HOME/.bashrc > /dev/null

# Configure autostart
cp org.kde.yakuake.desktop $HOME/.config/autostart
