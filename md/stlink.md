# Instalacija stlink alata

stlink alat se razvija na githubu, odakle je moguće preuzeti najnoviju verziju,
obično se preuzme u neki generički folder, npr ~/gitstuff, odakle ćemo je instalirati
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

Nakon instalacije potrebno je ponovo učitati dijeljene biblioteke,
osvježiti udev pravila, koja definiraju kako računar prepoznaje i komunicira sa 
vanjskim uređajima, te na kraju dodati svog korisnika u grupu korisnika stlink
kako bi imali privilegije komunikacije sa pločom.

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

Ukoliko je sve instalirano kako treba, nakon učitavanja okruženja u terminal 
sesiju moguće je pokrenuti gcc i stlink.
Pokušati sljedeće komande:

``` bash
source ~/armtools/arm_setup.sh
```

Ukoliko je gcc pravilno instaliran, moguće ga je pokrenuti u terminalu sljedećom
komandom:
``` bash
$ arm-none-eabi-gcc --version                                                                                 projects/STMenv master
arm-none-eabi-gcc (GNU Tools for ARM Embedded Processors 6-2017-q1-update) 6.3.1 20170215 (release) [ARM/embedded-6-branch revision 2455
12]
Copyright (C) 2016 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
```

Nakon spajanja ploče USB kablom, uspješno konektovanje će rezultovati 
ispisom komande st-util 
``` bash
$ st-util                                                    projects/STMenv
st-util 1.3.1-17-g5c10d4b
2017-05-17T22:51:44 INFO src/common.c: Loading device parameters....
2017-05-17T22:51:44 INFO src/common.c: Device connected is: F4 device (Dynamic E
fficency), id 0x10006433
2017-05-17T22:51:44 INFO src/common.c: SRAM size: 0x18000 bytes (96 KiB), Flash:
 0x80000 bytes (512 KiB) in pages of 16384 bytes
2017-05-17T22:51:44 INFO src/gdbserver/gdb-server.c: Chip ID is 00000433, Core I
D is  2ba01477.
2017-05-17T22:51:44 INFO src/gdbserver/gdb-server.c: Listening at *:4242...
```


