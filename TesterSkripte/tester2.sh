#! /usr/bin/env bash
read -p "Aktuellem user das Passwort ersparen? (j/N): " SU
if [ $(SU)=="j" ]; then
    echo "$USER ALL=(ALL) NOPASSWD: ALL"
else
    echo "$USER ALL=(ALL:ALL) ALL"
fi
