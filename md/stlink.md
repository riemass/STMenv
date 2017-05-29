# Instalacija stlink alata

stlink alat se razvija na githubu, odakle je moguce preuzeti najnoviju verziju,
obicno se preuzme u neki genericki folder, npr ~/gitstuff, odakle cemo je instalirati
u ranije kreirani ~/armtools folder.

``` bash
cd ~/gitstuff
git clone https://github.com/texane/stlink.git
cd stlink
```

Ovaj projekat koristi cmake za kompajliranje i instalaciju.

``` bash
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX=~/armtools -DCMAKE_BUILD_TYPE=Release ..
make
sudo make install
```

Nakon instalacije potrebno je ponovo ucitati dijeljene biblioteke,
osvjeziti udev pravila, koja definiraju kako racunar prepoznaje i komunicira sa 
vanjskim uredajime, te na kraju dodati svog korisnika u grupu koristnika stlink
kako bi imali privilegije komunikacije sa plocom.

``` bash
source ~/armtools/arm_setup.sh

sudo ldconfig 

sudo udevadm control --reload-rules
sudo udevadm trigger

sudo groupadd stlink
sudo usermod -aG stlink $USER
```

Nakon toga, potrebno se izlogovati i ponovo ulogovati.

# Testiranje okruženja

Ukoliko je sve instalirano kako treba, nakon ucitavanja okruženja u terminal 
sesiju moguce je pokrenuti gcc i stlink.
Pokušati sledeće komande:
``` bash
source ~/armtools/arm_setup.sh
```





