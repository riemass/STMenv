# Posupak debugiranja aplikacije

U jednom terminalu pokrenuti st-util
```
$ st-util
```
a u drugom cross degugger verziju koja dode sa kompajlerom
```
$ arm-none-eaby-gdb
```
rucno target remote i symbol

stavit neki term screen iz paketa
nakon toga bolje komande: 
st-util -p 1324 -m
arm-none-eaby-gdb --execute-command='target remote localhost:1234' buld/blinky.elf

navest neke gdb komande i stavit term screen debug sesije,
objasnit korak po korak prolazak, do paljenja lampice 

