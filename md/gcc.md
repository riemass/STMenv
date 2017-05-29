# Postupak instalacije

Postupak instalacije cemo demonstrirati u proizvoljnom direktoriju, kako bi 
lakse imali uvid u snimljene komponente, lakse ih nadogradili, a pri tome ostavili
sistemske direktorije cistim.

Odabrani direktorij ce biti u home folderu, nazvan armtools. 

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

U folderu instalacije(~/armtools) kreirati skriptu sa sledecim sadrzajem:

``` bash
PREFIX=~/armtools

PATH=$PATH:$PREFIX/bin
LD_LIBRARY_PATH=$PREFIX/lib
PKG_CONFIG_PATH=$PREFIX/lib/pkgconfig
```

Nakon toga, ukoliko skriptu nazovemo arm_tools.sh, sve aplikacije i biblioteke
moguce je ukljuciti u trenutnu terminal sesiju komandom:

``` bash
source ~/armtools/arm_tools.sh
```
