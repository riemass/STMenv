
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
