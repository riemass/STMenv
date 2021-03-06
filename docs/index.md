# Opis problema

Izazov u razvijanju programskih rješenja za ugrađene platforme, pored dobrog 
poznavanja arhitekture i perifarala uređaja za koji razvijamo aplikaciju, 
sačinjava i sam proces prevođenja programa u mašinski kod, uvezivanje, testiranje
i prenos koda na platformu.
Često se potrebano spustiti do samog nivoa metala kako bi bili sigurni da aplikacija
zaista radi ono što želimo. Pri tome je neophodno imati pouzdane alate i 
jako dobru kontrolu nad njima i njihovim postavkama.

Na tržištu se javljaju razna rješenja za brži i olakšan razvoj ovih aplikacija
u vidu raznih IDE-ova. IDE-ovi jednostavno predstavljaju programe za razvijanje
programa. To je okruženje za pisanje izvornog koda sa dodatnim alatima koji 
pomažu programeru da piše kod efikasno. IDE obično sadrži sljedeće alate:

- **Code completion**
Glavna komponenta skoro svakog IDE-a je prepoznavanje uzoraka pisanog koda i 
predlaganje ključnih riječi kako programer ne bi morao svako malo tražiti
ključne riječi kako bi nešto odradio. IDE može iskoristiti svoje znanje programskog
jezika kako bi naglasio greške u kodu i davao upozorenja.

- **Alati za debugiranje**
Unutar IDE-a, potrebno je imati komponentu sa kojom možemo detaljno proći kroz
naš izvorni kod postavljajući break pointe na određenim lokacijama i moramo 
moći izanalizirati programsku memoriju i interne registre da bi znali šta se 
dešava, detaljnije o debuggingu u sekciji **Debugiranje asemblerskih aplikacija**.

- **Kompajler i linker**
IDE bi trebao imati komponentu koja će prevoditi ispisani kod u mašinski i 
obično svaki IDE je specijaliziran za određen programski jezik.

Sa obzirom da malte ne svaki programski jezik ima određeni IDE koji je specijaliziran
baš za njega, ukoliko znamo dosta različitih jezika, velika je vjerovatnoća da
ćemo koristiti dosta IDE-ova. Veliki problem je što svaki IDE ima svoju filozofiju,
svoju organizaciju alata i svoj način rješavanja problema. Obično se dosta vremena
potroši na savladavanje alata za razvijanje aplikacija, umjesto što bi fokus trebao
biti na rješavanje zadatog problema. Ukoliko se programer svakodnevno muči sa dosta
različitih alata, kao što se to radi generalno na univerzitetima, postaje malte ne
nemoguće zapamtiti kako koristiti sve silne IDE-ove, te će se nakon toga obično
fokusirati na par njih ili čak jedan koji će se maksimalno koristiti. 

Na univerzitetima se koriste profesionalni alati za riješavanje problema, što je
i razumljivo jer će iste alate koristiti vjerovatno u budućnosti u praksi, međutim,
sofisticirane IDE-ove nije nimalo jednostavno savladati sa svim razbacanim opcijama.
Čak i ako je filozofija, koncept kompajliranja, linkanja, debugiranja i organizacije
koda jasan, ponekad je sve to vrlo teško pronaći, tako da je proces učenja odnosno
savladavanja IDE-ova vrlo spor i zahtjeva jako puno strpljenja što za početnike
odnosno studente predstavlja zaista veliki problem.

Bilo bi puno jednostavnije, kada bi mogli savladati samo jedan alat za pisanje 
koda, a da se kompletan daljnji fokus prebaci na savladavanje problema. Postoji
način da se tako nešto izvede. Potrebno je pokazati da postoje opcije, odnosno,
postoje više načina kako određeni jezik savladati i ne forsirati uporno hrpu
različitih stvari. Jedna od opcija je **uvijek** pisanje koda u vimu ili sličnim
"lightweight" editorima. Prednosti nad klasičnim IDE-ovima su:

- **Brzina**
pisanja koda u vimu je neprikosnovena. Prečice koje se mogu customizirati u vimu 
zaista uštede jako puno vremena i moguće ih je mijenjati kako god mi želimo, što 
znači da može svako postaviti okruženje onako kako mu odgovara i koristiti ga za
**bilo šta**. 

- **Prilagodljivost**
Ova stavka je nešto što nedostaje svakom IDE-u. Svaki IDE je donekle moguće prilagoditi
sebi i reorganizovati neke stvari, ali je dosta stvari nemoguće izvesti. U editorima
kao što je vim moguće je mijenjati kolor šeme, boju teksta, boju naznaka, font, 
veličinu fonta i skoro pa bilo šta što vam padne na pamet. Vim prepoznaje hrpu
jezika, ukoliko to ipak nije slučaj ni to nije problem samo vam je potreban jedan
dodatni plugin.

- **Cross platform**
Vim je moguće pisati na bilo kojoj mašini sa operativnim sistemom na sebi, bilo
kojim operativnim sistemom. Ova konstatacija je vrlo moćna i niti jedan IDE ne
spada u ovu kategoriju.

Vim u kombinaciji sa drugim open source alatima (gcc, gdb...) daje nam full-blown
lightweight IDE sa kojim možemo uraditi sve što se programiranja tiče i dovoljno
je da ga savladamo samo jednom.

Platforma za razvoj aplikacija za ove mikrokontrolere će biti izgrađena
modularno sa objašnjenjem svake komponente. 
Postupak instalacije je isproban na Ubuntu i Arch linux distribucijama.
Za primjere je korišten mikrokontroler STM32F401RE.

Osnovne komponente:
- kompajlerski lanac,
- program za flashovanje objektnog koda na mikrokontorler

Ukoliko bi dobro poznavali platformu i pisali ručno link skripte i biblioteke,
sasvim je moguće napisati program i prenijeti ga na mikrokontroler sa ove dvije komponente.
Za kvalitetniji razvoj dodatno ćemo razmotriti:

- alat za generisanje platformski specifičnog koda,
- build skriptu za automatsko kompajliranje projekta,
- software za komunikaciju sa "on-chip-debuggerom"

# Kompajlerski lanac

Kompajlerski lanac koji dolazi sa operativnim sistemom predviđen je da će se 
kao program izvrsavati na arhitekturi racunara, tzv. HOST arhitekturi i 
kreirati programe za arhitekturu tog racunara, tzv. TARGET arhitekturu.

Dodatno takav kompajler automatski uvezuje standardne biblioteke i koristi sistemsku
link skriptu.

Za razvoj aplikacija za mikroprocesore koristi se cross-compiler - posebno podešen
kompajler koji se kao program izvršava na HOST arhitekturi računara a kreira programe
za drugu TARGET arhitekturu, u ovom slučaju ARM.

ARM isporučuje besplatan port legendarnog gcc kompajerskog lanca - arm-none-eabi-gcc.

https://developer.arm.com/open-source/gnu-toolchain/gnu-rm/downloads


# Software za komunikaciju sa mikrokontrolerom

STM čipovi se flashuju posebnim JTAG komandama. STM kontroleri posjeduju
poseban čip, nazvan st-link, koji pretvara komande iz USB protokola u JTAG komande.
Komunikaciju sa st-link čipom možemo ostvariti istoimenim softwareom *st-link*. 
Iako sam STM pruža verziju ovakvog softwarea, mi ćemo koristi mnogo bolju 
opensource verziju.
Debugiranje mikrokontrolera se vrši komunicirajući sa st-link čipom, kroz *st-link*
program. 

# Biblioteke

STM32 mikrokontroleri su organizovani u familije i svaka familija posjeduje
određene karakteristike što se tiče periferala, memorije i flash-a. Ovu činjenicu
potrebno je itekako uzeti u obzir kada se kompajlira i linka izvorni kod. Štaviše,
svaka familija posjeduje mikrokontrolere koji imaju drugačiji flash i veličine
RAM-a.

Linker skripte su posebne skripte koje se daju linkeru kako bi se specificirao
izgled memorije i da se inicijaliziraju razne memorijske sekcije koje koristi
firmware kada se izvršava. Ove skripte su krucijalne zato što specificiraju adrese
flasha i RAMa kao i njihove veličine. Svaka linker skripta može biti proslijeđena
linkeru preko GCC-a kroz komandu 
  ```
  gcc -T scriptname.ld
  ```

Link skripte znaju biti jako komplikovane, srećeom kada treba da modificiramo link 
skripte da bi se tačno kompajlirao kod za određeni model mikrokontrolera, potrebno
je da obratimo pažnju samo na inicijalni dio skripte, zato što je ovo krucijalni
dio koji specificira izgled memorije. Nakon ovog inicijalnog dijela, dolazi dio
koda koji inicijalizira razne memorijske sekcije, ovaj kod je rijetko potrebno
modificirati. Posmatrajmo sada link skriptu "stm32_flash.ld" koju pruža STM32
biblioteka (v3.2.0 i daljnje). U suštini, potrebno je posmatrati ovaj inicijalni
dio koji je predstavljen sljedećim linijama koda:
```
1 /*. Entry Point *./
2 ENTRY( Reset_Handler )
3
4 /.* Highest address of the user mode stack .*/
5 _estack = 0 x20010000; /*. end o f 64K RAM .*/
6
7 /*. Generate a link error if heap and s tack don’t fit int o RAM .*/
8 _Min_Heap_Size = 0; /.* required amount of heap .*/
9 _Min_Stack_Size = 0x200; /*. required amount of stack .*/
10
11 /*. Specify the memory areas .*/
12 MEMORY
13 {
14     FLASH ( rx ) : ORIGIN = 0x08000000 , LENGTH = 256K
15     RAM ( xrw) : ORIGIN = 0x20000000 , LENGTH = 64K
16     MEMORY_B1 ( rx ) : ORIGIN = 0x60000000 , LENGTH = 0K
17 }
```

Naravno, slijedi objašnjenje koda iznad.

- U liniji broj 2 (ENTRY) specificira ulaznu tačku programa, odnosno mjesto od
kojeg će se izvršiti prva instrukcija programa. Kao što možete vidjeti ENTRY
ne referencira na *main* simbol već na funkciju *Reset_handler* koja je prisutna
unutar startup fajla. Ovo je normalno, zato što funkcija koja inicijalizira
mikroprocesor je definirana unutar startup asembler fajla (".s" ekstenzija).
Obično ne bi trebalo da dirate entry point.

- Linija broj 5 deklariše varijablu *_estack*, čija vrijednost predstavlja početak
steka. Obično stek počinje na završnoj adresi adresnog prostora RAM-a, što ima
smisla ukoliko uzmemo u obzir da stek raste (sa kraja RAM-a, prema početku).
Morate modificirati ovu vrijednost prema početnoj adresi i količini RAM-a koju
imate na STM mikrokontroleru koji koristite.

- Linije 8 i 9 objašnjavaju same sebe i ne bi trebalo da ih dirate.

- Završne linije (14, 15 i 16) su **veoma** bitne, one specificiraju izgled memorije
koji će se koristit kad se program bude izvršavao. Najvažnije su *FLASH* i *RAM*
memorijske specifikacije. Za svaki dio memorijskog prostora potrebno je postaviti:
    * privilegije za čitanje/pisanje/izvršavanje: se nalaze unutar malih zagrada
    * početna adresa (ORIGIN): RAM i flash su fiksirani na svakom STM32 modelu,
tako da ih ne morate mijenjati osim ako vam baš nije potrebno kao na primjer za
poseban bootloader koji treba učitati u flash prije glavnog programa (ovu temu
nećemo pokriti u ovom seminarskom radu)
    * veličina (LENGTH): ovu vrijednost možete modificirati zavisno od modela 
kojeg koristite i vaših želja

- Svaku vrijednost možete pisati u decimalnom ili heksadecimalnom formatu (šta
vam je ljepše). Ukoliko nemate externi RAM, specifikaciju memorijskog prostora
*MEMORY_B1* možete izostaviti.

Ovo su sve osnovne bitne informacije koje je potrebno da bi producirali svoju 
link skriptu koja će raditi sa vašim mikrokontrolerom.

# Automatizacija kompajliranja i Makefile

Automatizacija kompajliranja je proces automatizacije kreiranja softvera i dodatnih
procesa uključujući kompajliranje izvornog koda u mašinski i linkanje izvornog
koda. Postoji dosta build jezika koji nam olakšavaju pokretanje svih potrebnih
zadataka da bi na kraju dobili izvršni file. Najkorisniji build jezik je GNU 
Makefile koji riješava sve probleme automatizacije kompajliranja, ali sposoban je
i za više od toga. Može se koristiti da se specificiraju ovisnosti između komponenti
tako da se komponente kompajliraju u određenom redoslijedu zadovoljavajući ove
ovisnosti. Veoma važna karakteristika Make-a je rekompajliranje izmjena. Make će
rekompajlirati samo one fajlove koji su izmjenjeni i sve komponente koje zavise
od komponente kojoj pripada dati fajl. Ovo zna uštediti jako puno vremena tako da
Make predstavlja esencijalni alat za veće softverske projekte.

Osim automatizacije kompajliranja, Make ima mogućnost i automatizacije svega što
treba odraditi kroz terminal, to uključuje i flash-vanje, prebacivanje programa
na razvojnu ploču, pa čak i automatizaciju testiranja. Jasno je da Make predstavlja
jedan vrlo moćan alat i samo mali djelić toga se može opisati u jednom poglavlju
seminarskog rada. Postoje kompletne knjige koje su napisane za korištenje Make-a.

Da bi pokrenuli makefile skriptu potrebno je ukucati komandu 
```
make
```
u terminal, nakon čega se pokreće Make aplikacija koja traži file pod imenom
*makefile*, *Makefile* ili *GNUMakefile* te konstruiše stablo ovisnosti na osnovu
specificiranog targeta. Ukoliko se ne specificira target Make po defaultu pokreće
prvi target iz našeg Makefile-a. Za sintaksu i detalje o Makefile-u postoji jako
puno online dokumentacije koju nije moguće nadjačati u jednom radu.
# Postupak instalacije

Postupak instalacije je isproban na Ubuntu i Arch linux distribucijama.
Za primjere je korišten mikrokontroler STM32F401RE.

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


# Debugiranje asemblerskih aplikacija

Debugger predstavlja alat bez kojeg je skoro pa nemoguće debugirati aplikacije 
pisane u bilo kojem asembleru. Puno veću ulogu ima u asemblerskom svijetu nego u
svijetu programskih jezika većeg nivoa jer ispisivanje vrijednosti na ekran u
asembleru nije nimalo trivijalan proces, tako da dodavanje novog debug koda u
asembleru može dovesti do novih bug-ova ili može čak dovesti do toga da se trenutni
bugovi drugačije ponašaju čime i ovaj način debugiranja gubi smisao. Debugiranje
asemblera zna biti poprilično mukotrpan posao jer se mora obratiti pažnja na jako
puno stvari u toku traženja greške te je vrlo lako pogriješiti kretajući se kroz kod
liniju po liniju naprijed. 

Dodatne poteškoće nastaju kada debugiramo kod koji se uopšte ne izvršava na našoj 
mašini. Očito da nam je potreban vrlo moćan alat koji je sposoban učitati program
zajedno sa njegovim simbolima i korisniku prezentovati sadržaj (tok programa), pri 
tome programer treba da se što manje vremena "pati" sa alatom zadržavajući pažnju
na tok njegovog programa koji sam po sebi može biti i previše za shvatiti. Na svu
sreću postoji alat koji se zove GNU debugger (GDB) koji može (u teoriji) olakšati
posao debugiranja aplikacija na Linux baziranim embedded sistemima. U praksi, 
postavljanje GDB-a da odradi ovaj posao je poprilično komplikovan proces sa dosta
tehničkih poteškoća koje se moraju prevazići. Međutim, nakon što savladamo ovaj 
proces dobijamo način za metodološko debugiranje programa umjesto što bi inače
morali gledati u kompletan asemblerski kod pokušavajući shvatiti zašto ne radi ono
čemu je namjenjen. Umjesto da instaliramo potpunu instancu GDB-a sa svim karakteristikama
možemo koristiti GDB server, program koji nam omogućava da pokrenemo GDB na 
totalno drugoj mašini od one na kojoj se vrti program koji treba debugirati. 
Prednost korištenja GDB servera je da mu je potreban samo djelić resursa koje 
GDB inače konzumira, zato što implementira samo low-level funkcionalnost debuggera 
(postavljanje break pointa, pristup registrima i I/O operacije nad memorijom 
aplikacije). GDB server preuzima kontrolu nad aplikacijom koja se debugira, a
onda čeka da na instrukcije od udaljene GDB instance koja kontroliše aplikaciju.

# Postupak debugiranja aplikacije

Da bi olakšali debugiranje potrebno je kompajlirati aplikaciju sa uključenim
debug simbolima koje koristi GDB da bi nam omogućio sve navedene stvari. Da bi
krenuli sa debugging-om, potrebno je u jednom terminalu pokrenuti st-util:
```
$ st-util
```

a u drugom GDB alat za ARM.
```
arm-none-eaby-gdb
```

Nakon toga potrebno je spojiti se GDB-om na remote GDB server koji se nalazi na
uređaju. Unutar pokrenutog GDB-a trebamo kucati:
```
target remote localhost:4242
```

Sada imamo pristup GDB serveru koji se nalazi na uređaju, međutim još uvijek
nemamo GDB simbole učitane, te ćemo dobiti sljedeći ispis:
```
Remote debugging using localhost:4242
warning: No executable has been specified and targed does not support determining
executable automatically. Try using the "file" command.
```

Aplikacija kompajlirana sa uključenim debug simbolima može biti prevelika da bi 
stala na uređaj za koji je predviđena, tako da kompajliranje aplikacija sa debug
simbolima predstavlja dodatni teret koji nije uvijek moguće prenijeti. A osim
toga gdb nije uvijek u mogućnosti remotely učitati simbole, tako da na našoj
lokalnoj instanci GDB moramo pozvati komandu:
```
symbol-file build/blinky.elf
```

Dalje nam ostaje da radimo debugiranje našeg programa u gdb-u. Neke osnovne GDB
komande su:
```
1. break adresa
2. si
3. ni
4. c
5. layout regs/src/asm/split
6. x/NFU adresa
7. info registers
8. print simbol
```

Komanda 1 je poprilično jasna, postavlja break point na zadatu adresu. Veoma bitna
razlika je između komandi **si** i **ni** (step instruction i next instruction
respektivno). Step instruction komanda **bezuslovno** izvršava instrukciju i
prelazi na sljedeću, dok Next instruction također izvršava trenutnu instrukciju 
i prelazi na sljedeću stim što ukoliko je trenutna instrukcija poziv nekog
podprograma, onda se kompletan podprogram izvrši i prelazi se na instrukciju ispod
poziva podprograma. Layout komanda nam koristi da bi u sklopu terminala vidjeli
i još neke informacije, moguće je i više njih istovremeno. Šesta komanda je 
vjerovatno jedna od najbitnijih komandi prilikom debugiranja. Komanda 6 koja se
još zove i *examine* daje nam prikaz stanja adresnog prostora aplikacije gdje N
predstavlja broj memorijskih jedinica za prikaz, F je format ispisa (x - 
heksadecimalni ispis, i - ispis instrukcija, s - null terminirani string...) te
U predstavlja veličinu memorijske jedinice za prikaz (b - byte, h - half word, 
w - word, g - giand word).

# Primjer debug sesije za blinky

Pretpostavimo da smo u folderu projekta. Pokrenimo u jednom terminalu
st-util alat, a u drugom gdb na način opisan iznad.

Nakon spajanja i učitavanja simbola, STM je zaleđen u init kodu reset handlera.
U većini slučajeva ovaj kod je potrebno preskočiti i doći do maina. 
To možemo uraditi na način da postavimo breakpoint na main funkciju i naredimo 
kontroleru da izvrši sve instrukcije do narednog brakepointa, komandama:
```
breakpoint main
continue
```
ili kraće
```
b main
c
```
Sada je kontoler zaleđen u prvoj instrukciji main funkcije. Bilo bi korisno da 
vidimo stanje registara i izvorni kod programa, pa ćemo izmijeniti layout sledećim
naredbama:
```
layout regs
layout src
```

Izlaz u terminalu:

TODO ubaciti sliku

Strelicama je moguće navigirati kroz kod. Instrukcija koja pali LED se nalazi
u liniji 89 koda, kako nam je ona od interesa postavićemo breakpoint na nju i 
nastaviti izvršenje koda
``` 
b 89
c
```
Sada ćemo izvrsiti tu naredbu tipkajući
``` 
n
```
LED na kontroleru bi trebala biti upaljena.
