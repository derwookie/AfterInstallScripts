#!/usr/bin/env bash

echo started

for i in {1..3}
do
    echo $i
done


read -p "IP-Adresse des Shares: " IP
read -p "Wie viele Shares gibt es hier?: " NUMOSHARES
SHARES=()
for i in {0..$NOMUSHARES}
do
    read -p "Name des shares: " TEMP
    SHARES+=($TEMP)
done

echo $SHARES
echo $IP
