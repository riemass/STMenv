# Postupak instalacije

Postupak instalacije ćemo demonstrirati u proizvoljnom direktoriju, kako bi 
lakše imali uvid u snimljene komponente, lakše ih nadogradili, a pri tome ostavili
sistemske direktorije čistim.

Odabrani direktorij će biti u home folderu, nazvan armtools. 

Preuzeti kompajlerski lanac sa ARM-ove stranice:
[https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads]
Otvoriti terminal u direktoriju gdje je datoteka preuzeta i otpakovati je u 
novokreirani direktorij armtools:
``` bash
mkdir ~/armtools
tar xf arm-none-eaby-gcc-XXXXXX
cp arm-none-eaby-XXXXXX/* ~/armtools
```
Napomena: XXXXXX zamijeniti imenom preuzetog filea, predstavlja broj verzije.

U folderu instalacije(~/armtools) kreirati skriptu sa sljedećim sadržajem:

``` bash
PREFIX=~/armtools

PATH=$PATH:$PREFIX/bin
LD_LIBRARY_PATH=$PREFIX/lib
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
```

Nakon toga, ukoliko skriptu nazovemo arm_tools.sh, sve aplikacije i biblioteke
moguće je uključiti u trenutnu terminal sesiju komandom:

``` bash
source ~/armtools/arm_tools.sh
```
