TODO neki titile page

# Uvod

TODO kukat kako su IDE-ovi inertni, kako su open kompajleri svjetlosne godine
ispred zatvorenih, i napravit neki los vic o emacsu

Platforma za razvoj aplikacija za ove mikrokontrolere ce biti izgradena
modularno sa obajsnjenjem svake komponente. Postupak instalacije je isproban na Ubuntu i 
Arch linux distribucijama, a koristeni mikrokontroler je STM32F401RE.

Osnovne komponente:
- kompajlerski lanac
- program za flashovanje objektnog koda na mikrokontorler

Sasvim moguce napisati program, prenijeti ga na mikrokontroler i pokrenuti.
Za kvalitetijij razvoj potrebne su dodatke komponente:

- Platformski specifican kod i biblioteke
- Build skripta za automatsko kreiranje projekta
- software za komunikaciju sa "on-chip-debuggerom"

# Kompajlerski lanac

Kompajlerski lanac koji dolazi sa opertivnim sistemom predviden je da ce se 
kao program izvrsavati na arhitekturi racunara, tzv. HOST arhitekturi, i 
kreirati programe za arhitekturu tog racunara, tzv. TARGET arhitekturu.
Dodatno ovaj lanac automatski uvezuje standardne biblioteke i linka sve sekcije
objektog filea prema link skripti predvidenoj za rad na HOST-u.

Cross-compiler - kompajler kao program ce se izvrsavati na HOST arhitekturi vaseg
racunara ali ce prevoditi programe za TARGET arhitekturu - u ovom slucaju ARM.
ARM isporucuje besplatan port gcc kompajerskog lanca - arm-none-eabi-gcc.

https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads


# Software za prenos 

STM cipovi se flashuju posebnim JTAG komandama. STM kontroleri posjeduju
poseban cip, nazvan st-link, koji pretvara komande iz USB protokola u JTAG komande.
Komunikaciju sa st-link cipom mozemo ostvariti istomenim softwareom st-link. 
Iako sam STM pruza verziju ovakvog softwarea, mi cemo koristi mnogo bolju 
opensource verziju.
Debugiranje mikrokontrolera se takoder vrsi komunicirajuci sa ovim cipom, ovim 
alatom. TODO sastavit ovu recenicu malo bolje
TODO u instalaciji nakon podesavanja alata pokusat spojit plocu i
reci st-util
TODO ubacit terminal recording

# Biblioteke
TODO rec nesto o link skriptama i CubeMX-u
napravit projekat u cubeu i kreirat ga za SW4ST** target
pogledat Damirov pdf

# Automatizacija kompajliranja

TODO
reci nesto o GNU Make-u
U postupku instalacija preuzeti git repo https://github.com/baoshi/CubeMX2Makefile
simlink do skripte u armtools/bin
TODO kasnije 
Makefile nece kompajlirati (bar ne na zsh i bashu) projekat jer
se u definiciji weak macroa escape backshashom escapeaju
karakteri koji po pravilu ne moraju biti escapani
projemnit jednu liniju koda tako da nema backslasha
eventualno pull request baoshiju dat

TODO pomjerit ovo negdje drugo
komanda za prenos programa na plocu:
st-flash write build/blinky.bin 0x8000000 

# Postupak instalacije

Instalaciju vršimo u proizvoljni direktorij.
Preuzeti kompajlerski lanac sa ARM stranice 

``` bash
mkdir ~/armtools
tar xf arm-none-eaby-gcc-CXXXXXXXX
cp arm-none-eaby-XXXXX/* ~/armtools
```

u folderu instalacije(~/armtools) kreirati skriptu sa sledecim sadrzajem:


``` bash
source ~/armtools/arm_tools

```

TODO objasnit sta skripta radi i zasto
