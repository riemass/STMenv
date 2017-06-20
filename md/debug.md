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
