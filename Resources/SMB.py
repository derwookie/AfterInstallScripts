from pathlib import Path
import sys
home = str(Path.home())
with open("eintraege.txt", "a+") as file:
    zeilen=[]
    while True:
        weitereEintraege = input("Gibt es einen (weiteren) Eintrag? (j/N): ")
        if weitereEintraege == "j" or weitereEintraege == "J":
            IP = input("Wie lautet die IP des Shares?: ")
            AnzahlShares = int(input("Wie viele Shares gibt es unter dieser IP?: "))
            sharenamen=[]
            for i in range(0, AnzahlShares):
                sharenamen.append(input("Wie lautet der Name vom Share?: "))

            for i in range(0, AnzahlShares):
                zeilen.append(f"# {sharenamen[i]}\n//{IP}/{sharenamen[i]}\t\t\t{home}/NAS/{sharenamen[i]}\t\t\tcifs\t\t\tcredentials={home}/.smb-creds.txt,_netdev,file_mode=0777,dir_mode=0777,vers=3.0\t\t\t0 0\n")
        else:
            for i in range(0, len(zeilen)):
                file.write(zeilen[i])
            sys.exit()
