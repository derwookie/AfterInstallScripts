#!/usr/bin/env bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
PKG_LIST=$RES_DIR/yay-list.txt
RES_DIR=$SCRIPT_DIR/Resources

#1.: Sudoers editieren
read -p "Aktuellem user das Passwort ersparen? (j/N): " SU
if [$SU=="j"]; then
    echo "$USER ALL=(ALL) NOPASSWD: ALL"
else:
    echo "$USER ALL=(ALL:ALL) ALL" | sudo tee -a /root/sudoer.tester
fi

#2.: python installieren
sudo pacman -Sy python --needed --noconfirm

#3.: yay-Abhängigkeiten installieren
sudo pacman -S base-devel git

#4.: yay installieren
mkdir $HOME/.AfterInstallScript
cd $HOME/.AfterInstallScript
git clone http://aur.archlinux.org/yay-bin.git
cd ./yay-bin
makepkg -si --noconfirm
cd $SCRIPT_DIR

#5.: Paketliste installieren
yay -S --needed --noconfirm - < $PKG_LIST

#6.: libvirtd aktivieren
sudo systemctl enable --now libvirtd

#7.: SMB-Shares integrieren
python $RES_DIR/SMB-Creds.py
python $RES_DIR/SMB.py
