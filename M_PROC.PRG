*******************************************************************************
* Procedury  zawarte pierwotnie w module m.prg                                *
*******************************************************************************
PROCEDURE TL
tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
@ 0,0 clear to 4,79

*  set color to w/W+,W+/w
set color to
@ 5,0 clear
set color to (coldef)
@ 7,0,19,79 box tlo
set color to
@ 0,0 to 24,79 double
@ 20,0 to 24,79 double
@ 4,0 to 6,79 double
@ 20,0 say chr(204)
@ 20,79 say chr(182)
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(182)
@ 6,79 say chr(182) 
@ 4,16 say chr(216)
@ 6,16 say chr(207)
@ 4,32 say chr(209)
@ 6,32 say chr(207)
@ 4,48 say chr(209)
@ 6,48 say chr(207)
@ 4,64 say chr(209)
@ 6,64 say chr(207)
@ 0,16 say chr(209)
@ 0,63 say chr(209)
@ 1,63 say chr(179)
@ 2,63 say chr(179)
@ 3,63 say chr(179)
@ 4,63 say chr(207)
@ 1,16 say chr(179)
@ 2,16say chr(179)
@ 3,16 say chr(179)
do tx with 0,22,"Wpisz haslo i zatwierdz klawiszem <Enter>"

set color to (coldef)
@ 1,1 say " M A G A Z Y N "    
@ 2,1 say NM[NumStan]
@ 1,66 say "Wersja   "
@ 1,73 say wersjatxt
if sklep
  @ 2,66 say "S K L E P"
else
  @ 2,66 say "HURTOWNIA"
endif
@ 3,64 say "Data:"
@ 3,70 say date()
if kolor=0
  set color to W/N+
endif  
@ 1,17 say "             *  F  I  R  M  A  *              "
set color to (coldef)
@ 2,17 say "        OPERACJE HANDLOWE I MAGAZYNOWE        "
@ 3,24 say fwl
*@ 20,1 say replicate(chr(205),78)
@ 24,1 say replicate(chr(205),78)
RETURN


PROCEDURE TXT
PARAMETERS W,T
@ 21,1 clear to 23,78
@ W,(80-LEN(T))/2 SAY T
@ 23,4 say "  F1 - HELP              Enter-Zatwierdzenie           Esc-Rezygnacja "  
RETURN

PROCEDURE TXT213
PARAMETERS W,T
@ W,(80-LEN(T))/2 SAY T
RETURN

PROCEDURE TX
PARAMETERS C,W,T
if c=0
@ 21,1 clear to 23,78
@ 24,0 say chr(200)
set color to (coldef)
@ 24,1 say replicate(chr(205),78)
set color to
@ 24,79 say chr(188)
endif
@ W,(80-LEN(T))/2 SAY T
RETURN






PROCEDURE ROZ
for i=8 to 15
  @ i,21 say replicate(chr(178),35)
next
@ 9,23 say "                               "
@ 10,23 SAY "        OPCJA DOSTEPNA         "
@ 11,23 say " W ROZSZERZONEJ WERSJI SYSTEMU "
@ 12,23 say "                               "
@ 13,23 say "   Nacisnij dowolny klawisz    "
@ 14,23 say "                               "
inkey(0)
for i=9 to 14
  @ i,23 say replicate(chr(176),40)
next  
RETURN




PROCEDURE GKOM
parameters ptxt,pzatwierdz
local ek:=savescreen(24,0,24,79)
local kol:=0
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(78-len(ptxt))/2
kol=round(kol,0)
set color to (coldef)
set color to N/W,W/N
set cursor on
@ 24,0 say space(80)
set confirm off
@ 24,kol say ptxt get pzatwierdz
read
set confirm on
set cursor off
set color to  
restscreen(24,0,24,79,ek)
RETURN


PROCEDURE SKOM
parameters ptxt
local kol:=0
ptxt=alltrim(ptxt)
if len(ptxt)>80
  ptxt=substr(ptxt,1,80)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to N/W,W/N
@ 24,0 say space(80)
@ 24,kol say ptxt
set color to  
RETURN

PROCEDURE SKOMC
parameters ptxt
local kol:=0
ptxt=alltrim(ptxt)
if len(ptxt)>80
  ptxt=substr(ptxt,1,80)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
@ 24,0 say REPLICATE(chr(176),80)
@ 24,kol say ptxt
RETURN


PROCEDURE TKOM
parameters ptxt
local ek:=savescreen(24,0,24,79)
local kol:=0
clear typeahead
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to N/W,W/N
@ 24,0 say space(80)
@ 24,kol say ptxt 
inkey(0)
set color to  
restscreen(24,0,24,79,ek)
RETURN

PROCEDURE TKOM1
parameters ptxt
local ek:=savescreen(24,0,24,79)
local kol:=0
clear typeahead
ptxt=alltrim(ptxt)
if len(ptxt)>78
  ptxt=substr(ptxt,1,78)
endif
kol=(80-len(ptxt))/2
kol=round(kol,0)
set color to n/w*
@ 24,0 say space(80)
@ 24,kol say ptxt 
inkey(0)
set color to  
restscreen(24,0,24,79,ek)
RETURN


FUNCTION NUMER
parameters pnum,pkod
local poz:=0
local tnum:=space(15)
local em:=savescreen(0,0,24,79)
local numer:="          / /  "
pkod=substr(pkod,4,1)
if pnum>999999
  do while .t.
    pnum=pnum-1000000
	if pnum<=999999
	  exit
	endif  
  enddo	
endif  
tnum=alltrim(str(pnum))
poz=11-len(tnum)
numer=stuff(numer,poz,len(tnum),tnum)
numer=stuff(numer,12,1,pkod)
numer=stuff(numer,13,1,stanowisko)
numer=stuff(numer,14,2,SUBSTR(ALLTRIM(STR(year(date()))),3))
if wielokas
  NumKasTxt=ALLTRIM(str(NumKas))
  numer=stuff(numer,14,1,NumKasTxt)
endif
RETURN numer


PROCEDURE BLOKADA
if min(datdem,date()-demczas)=datdem.or.min(datdem-1,date())=date()
  licencja=.f.
  save to pam
endif
if.not.licencja
  do bloktxt
endif  
RETURN


PROCEDURE BLOKTXT
set color to I,
@ 8,18 say "                                           "
@ 9,18 say "                                           "
@ 10,18 say "  Przypominam, ze korzystaliscie Panstwo   "
@ 11,18 say "  z  demonstracyjnej  wersji programu.     "
@ 12,18 say "  Legalna licencjonowana wersje programu   "
@ 13,18 say "  jest do nabycia u producenta  w firmie   "
@ 14,18 say "  Soft-KJ-Service     tel: 0 90 21 26 40   "
@ 15,18 say "  ( 05-120 Legionowo  ul. Hetmanska 63 )   "
@ 16,18 say "  lub u autoryzowanych DEALEROW.           "
@ 17,18 say "                                           "
@ 18,18 say "                                           "
set color to (coldef)
@ 21,1 clear to 23,78
@ 22,28 say "Nacisnij dowolny klawisz"
inkey(0)
RETURN





PROCEDURE KRESKA
parameters pw,pk
@ pw,pk say chr(209)
@ pw+1,pk say chr(179)
@ pw+2,pk say chr(207)
RETURN


FUNCTION SKROT
parameters mia,uli
sadres=space(25)
i=1
do while .t.
  if substr(mia,i,1)=" ".or.i>len(mia)
    exit
  else
    i=i+1 	
  endif
enddo  
sadres=stuff(sadres,1,i,substr(mia,1,i))
J=25-I
K=I+1
sadres=stuff(sadres,K,J,substr(uli,1,J))
RETURN sadres


*******************************************************************************
*Przepisanie pliku magdef.dbf do tablicy zapamietanej mastepnie w pliku pam.mem
*******************************************************************************
PROCEDURE MDEF
if.not.file("magdef.dbf")
  return
endif
select 22
use magdef
for i=1 to wmagil
  locate for mag_nr=i
  nm[i]=mag_nazwa          &&nazwa magazynu
  mm[i]=mag_miasto         &&adres-miasto
  um[i]=mag_ulica          &&adres-ulica
next
use
RETURN


*******************************************************************************
*Procedura powraca do katalogu zawierajcego dokumenty kasy okreslonej numerem
*instalacyjnym  NumKas
*******************************************************************************
PROCEDURE DOKDEFAULT
if.not.rekon
  set default to curdir()
  do case
    case NumKas=1
      set default to 1DOK
    case NumKas=2
      set default to 2DOK
    case NumKas=3
      set default to 3DOK
    case NumKas=4
      set default to 4DOK
    case NumKas=5
      set default to 5DOK				
    case NumKas=6
      set default to 6DOK				
    case NumKas=7
      set default to 7DOK				
    case NumKas=8
      set default to 8DOK					  	  	  
  endcase
endif  
RETURN


*******************************************************************************
*Procedura kiruje do katalogu zawierajacego magazyn przyporzadkowany jako
*glowny dla zainstalowanego stanowiska - decyduje zmienna NumStan
*******************************************************************************
PROCEDURE MAGDEFAULT
set default to curdir()
	do case
	  case NumStan=1
	    set default to 1MAG
	  case NumStan=2
	    set default to AMAG
	  case NumStan=3
	    set default to BMAG
	  case NumStan=4
	    set default to CMAG	
	  case NumStan=5
	    set default to DMAG	
	  case NumStan=6
	    set default to EMAG	
	  case NumStan=7
	    set default to FMAG	
	  case NumStan=8
	    set default to GMAG								  		
	  case NumStan=9
	    set default to HMAG	
	  case NumStan=10
	    set default to 10MAG								  				
	  case NumStan=11
	    set default to 11MAG								  				
	  case NumStan=12
	    set default to 12MAG								  				
	  case NumStan=13
	    set default to 13MAG								  				
	  case NumStan=14
	    set default to 14MAG								  				
	  case NumStan=15
	    set default to 15MAG								  				
	  case NumStan=16
	    set default to 16MAG								  				
	  case NumStan=17
	    set default to 17MAG								  				
	  case NumStan=18
	    set default to 18MAG								  				
	  case NumStan=19
	    set default to 19MAG								  				
	  case NumStan=20
	    set default to 20MAG								  																								
	  case NumStan=21
	    set default to 21MAG								  				
	  case NumStan=22
	    set default to 22MAG								  				
	  case NumStan=23
	    set default to 23MAG								  				
	  case NumStan=24
	    set default to 24MAG								  				
	  case NumStan=25
	    set default to 25MAG								  				
	  case NumStan=26
	    set default to 26MAG								  				
	  case NumStan=27
	    set default to 27MAG								  				
	  case NumStan=28
	    set default to 28MAG								  				
	  case NumStan=29
	    set default to 29MAG								  				
	  case NumStan=30
	    set default to 30MAG	
	  case NumStan=31
	    set default to 31MAG								  				
	  case NumStan=32
	    set default to 32MAG								  				
	  case NumStan=33
	    set default to 33MAG								  				
	  case NumStan=34
	    set default to 34MAG								  				
	  case NumStan=35
	    set default to 35MAG								  				
	  case NumStan=36
	    set default to 36MAG								  				
	  case NumStan=37
	    set default to 37MAG								  				
	  case NumStan=38
	    set default to 38MAG								  				
	  case NumStan=39
	    set default to 39MAG								  				
	  case NumStan=40
	    set default to 40MAG
	  case NumStan=41
	    set default to 41MAG								  				
	  case NumStan=42
	    set default to 42MAG								  				
	  case NumStan=43
	    set default to 43MAG								  				
	  case NumStan=44
	    set default to 44MAG								  				
	  case NumStan=45
	    set default to 45MAG								  				
	  case NumStan=46
	    set default to 46MAG								  				
	  case NumStan=47
	    set default to 47MAG								  				
	  case NumStan=48
	    set default to 48MAG								  				
	  case NumStan=49
	    set default to 49MAG								  				
	  case NumStan=50
	    set default to 50MAG
	  case NumStan=51
	    set default to 51MAG								  				
	  case NumStan=52
	    set default to 52MAG								  				
	  case NumStan=53
	    set default to 53MAG								  				
	  case NumStan=54
	    set default to 54MAG								  				
	  case NumStan=55
	    set default to 55MAG								  				
	  case NumStan=56
	    set default to 56MAG								  				
	  case NumStan=57
	    set default to 57MAG								  				
	  case NumStan=58
	    set default to 58MAG								  				
	  case NumStan=59
	    set default to 59MAG								  				
	  case NumStan=60
	    set default to 60MAG
	  case NumStan=61
	    set default to 61MAG								  				
	  case NumStan=62
	    set default to 62MAG								  				
	  case NumStan=63
	    set default to 63MAG								  				
	  case NumStan=64
	    set default to 64MAG								  				
	  case NumStan=65
	    set default to 65MAG								  				
	  case NumStan=66
	    set default to 66MAG								  				
	  case NumStan=67
	    set default to 67MAG								  				
	  case NumStan=68
	    set default to 68MAG								  				
	  case NumStan=69
	    set default to 69MAG								  				
	  case NumStan=70
	    set default to 70MAG
	  case NumStan=71
	    set default to 71MAG								  				
	  case NumStan=72
	    set default to 72MAG								  				
	  case NumStan=73
	    set default to 73MAG								  				
	  case NumStan=74
	    set default to 74MAG								  				
	  case NumStan=75
	    set default to 75MAG								  				
	  case NumStan=76
	    set default to 76MAG								  				
	  case NumStan=77
	    set default to 77MAG								  				
	  case NumStan=78
	    set default to 78MAG								  				
	  case NumStan=79
	    set default to 79MAG								  				
	  case NumStan=80
	    set default to 80MAG
	  case NumStan=81
	    set default to 81MAG								  				
	  case NumStan=82
	    set default to 82MAG								  				
	  case NumStan=83
	    set default to 83MAG								  				
	  case NumStan=84
	    set default to 84MAG								  				
	  case NumStan=85
	    set default to 85MAG								  				
	  case NumStan=86
	    set default to 86MAG								  				
	  case NumStan=87
	    set default to 87MAG								  				
	  case NumStan=88
	    set default to 88MAG								  				
	  case NumStan=89
	    set default to 89MAG								  				
	  case NumStan=90
	    set default to 90MAG
	  case NumStan=91
	    set default to 91MAG								  				
	  case NumStan=92
	    set default to 92MAG								  				
	  case NumStan=93
	    set default to 93MAG								  				
	  case NumStan=94
	    set default to 94MAG								  				
	  case NumStan=95
	    set default to 95MAG								  				
	  case NumStan=96
	    set default to 96MAG								  				
	  case NumStan=97
	    set default to 97MAG								  				
	  case NumStan=98
	    set default to 98MAG								  				
	  case NumStan=99
	    set default to 99MAG								  				
	  case NumStan=100
	    set default to 100MAG
	endcase
RETURN

*******************************************************************************
*Procedura kiruje do katalogu zawierajacego magazyn.                      
*Decyduje parametr okreslajacy numer przyporzadkowany magazynowi
*******************************************************************************
PROCEDURE PMAGDEFAULT
parameters pmag
set default to curdir()
	do case
	  case pmag=1
	    set default to 1MAG
	  case pmag=2
	    set default to AMAG
	  case pmag=3
	    set default to BMAG
	  case pmag=4
	    set default to CMAG						
	  case pmag=5
	    set default to DMAG
	  case pmag=6
	    set default to EMAG
	  case pmag=7
	    set default to FMAG
	  case pmag=8
	    set default to GMAG								
	  case pmag=9
	    set default to HMAG								
	  case pmag=10
	    set default to 10MAG
	  case pmag=11
	    set default to 11MAG
	  case pmag=12
	    set default to 12MAG
	  case pmag=13
	    set default to 13MAG
	  case pmag=14
	    set default to 14MAG
	  case pmag=15
	    set default to 15MAG
	  case pmag=16
	    set default to 16MAG
	  case pmag=17
	    set default to 17MAG
	  case pmag=18
	    set default to 18MAG
	  case pmag=19
	    set default to 19MAG
	  case pmag=20
	    set default to 20MAG
	  case pmag=21
	    set default to 21MAG
	  case pmag=22
	    set default to 22MAG
	  case pmag=23
	    set default to 23MAG
	  case pmag=24
	    set default to 24MAG
	  case pmag=25
	    set default to 25MAG
	  case pmag=26
	    set default to 26MAG
	  case pmag=27
	    set default to 27MAG
	  case pmag=28
	    set default to 28MAG
	  case pmag=29
	    set default to 29MAG
	  case pmag=30
	    set default to 30MAG
	  case pmag=31
	    set default to 31MAG
	  case pmag=32
	    set default to 32MAG
	  case pmag=33
	    set default to 33MAG
	  case pmag=34
	    set default to 34MAG
	  case pmag=35
	    set default to 35MAG
	  case pmag=36
	    set default to 36MAG
	  case pmag=37
	    set default to 37MAG
	  case pmag=38
	    set default to 38MAG
	  case pmag=39
	    set default to 39MAG
	  case pmag=40
	    set default to 40MAG
	  case pmag=41
	    set default to 41MAG
	  case pmag=42
	    set default to 42MAG
	  case pmag=43
	    set default to 43MAG
	  case pmag=44
	    set default to 44MAG
	  case pmag=45
	    set default to 45MAG
	  case pmag=46
	    set default to 46MAG
	  case pmag=47
	    set default to 47MAG
	  case pmag=48
	    set default to 48MAG
	  case pmag=49
	    set default to 49MAG
	  case pmag=50
	    set default to 50MAG
	  case pmag=51
	    set default to 51MAG
	  case pmag=52
	    set default to 52MAG
	  case pmag=53
	    set default to 53MAG
	  case pmag=54
	    set default to 54MAG
	  case pmag=55
	    set default to 55MAG
	  case pmag=56
	    set default to 56MAG
	  case pmag=57
	    set default to 57MAG
	  case pmag=58
	    set default to 58MAG
	  case pmag=59
	    set default to 59MAG
	  case pmag=60
	    set default to 60MAG
	  case pmag=61
	    set default to 61MAG
	  case pmag=62
	    set default to 62MAG
	  case pmag=63
	    set default to 63MAG
	  case pmag=64
	    set default to 64MAG
	  case pmag=65
	    set default to 65MAG
	  case pmag=66
	    set default to 66MAG
	  case pmag=67
	    set default to 67MAG
	  case pmag=68
	    set default to 68MAG
	  case pmag=69
	    set default to 69MAG
	  case pmag=70
	    set default to 70MAG
	  case pmag=71
	    set default to 71MAG
	  case pmag=72
	    set default to 72MAG
	  case pmag=73
	    set default to 73MAG
	  case pmag=74
	    set default to 74MAG
	  case pmag=75
	    set default to 75MAG
	  case pmag=76
	    set default to 76MAG
	  case pmag=77
	    set default to 77MAG
	  case pmag=78
	    set default to 78MAG
	  case pmag=79
	    set default to 79MAG
	  case pmag=80
	    set default to 80MAG
	  case pmag=81
	    set default to 81MAG
	  case pmag=82
	    set default to 82MAG
	  case pmag=83
	    set default to 83MAG
	  case pmag=84
	    set default to 84MAG
	  case pmag=85
	    set default to 85MAG
	  case pmag=86
	    set default to 86MAG
	  case pmag=87
	    set default to 87MAG
	  case pmag=88
	    set default to 88MAG
	  case pmag=89
	    set default to 89MAG
	  case pmag=90
	    set default to 90MAG
	  case pmag=91
	    set default to 91MAG
	  case pmag=92
	    set default to 92MAG
	  case pmag=93
	    set default to 93MAG
	  case pmag=94
	    set default to 94MAG
	  case pmag=95
	    set default to 95MAG
	  case pmag=96
	    set default to 96MAG
	  case pmag=97
	    set default to 97MAG
	  case pmag=98
	    set default to 98MAG
	  case pmag=99
	    set default to 99MAG
	  case pmag=100
	    set default to 100MAG
	endcase
RETURN


PROCEDURE PRACDEFAULT
if.not.rekon
  set default to curdir()
  set default to pracow
endif
RETURN

PROCEDURE ROBAK
local ek:=savescreen(0,0,24,79)
local last:=inkey()
local w:=0
local k:=0
cls
do while last=0
  clear
  k=k+1
  @ w,k+1 say replicate(chr(176),25)
  @ w+1,k say replicate(chr(176),28)
  @ w+2,k+1 say replicate(chr(176),29)
  @ w+3,k say replicate(chr(176),28)
  @ w+4,k+1 say replicate(chr(176),25)
  @ w+2,k+5 say " * Soft-KJ-Service * "
  @ w+1,k+2 say "Data:        "
  @ w+1,k+8 say date()
  @ w+3,k+2 say "Godz.        "
  @ w+3,k+8 say time()
  last=inkey(1)
  if k>48
    k=0
	w=w+3
  endif
  if w>19
    w=0
  endif
enddo
*inkey(0)
restore screen from ek 
RETURN


*PROCEDURE HELP
PROCEDURE HELPik
parameters program
local ek:=savescreen(0,0,24,79)
local sel:=select()
if program="HELP"
  return
endif
if.not.file("help.dbf")
  do tkom with "Plik <HELP.DBF> nie odnaleziony !  Pomoc nie jest mozliwa. OK!"
  return
endif
save screen to ek
@ 3,5,21,74 box chr(176)
@ 3,33 say " * H E L P * "

select 27
use help
locate for hel=HELP
if found()
  do while.t.
    keyboard chr(27)
    memoedit(opis,4,6,20,73)
    do skom with "ENTER - edycja   SPACJA - koniec"
    inkey(0)
	  do case
	    case lastkey()=13
		  set cursor on
          replace opis with memoedit(opis,4,6,20,73)
		  exit
        case lastkey()#27
    	  exit
	  endcase	  
  enddo		
endif  
use 
if sel#0
  select &sel
endif  
restore screen from ek
RETURN


PROCEDURE NSTAN
do case
  case stanowisko="/"
    NumStan=1
  case stanowisko="A"
    NumStan=2
  case stanowisko="B"
    NumStan=3
  case stanowisko="C"
    NumStan=4			
  case stanowisko="D"
    NumStan=5
  case stanowisko="E"
    NumStan=6
  case stanowisko="F"
    NumStan=7
  case stanowisko="G"
    NumStan=8				
endcase
RETURN

PROCEDURE KODSTAN
do case
  case NumStan=1
    stanowisko="/"
  case NumStan=2
    stanowisko="A"
  case NumStan=3
    stanowisko="B"
  case NumStan=4
    stanowisko="C"
  case NumStan=5
    stanowisko="D"
  case NumStan=6
    stanowisko="E"
  case NumStan=7
    stanowisko="F"
  case NumStan=8
    stanowisko="G"							
endcase
RETURN


*******************************************************************************
* WYBOR MAGAZYNU GLOWNEGO                                                     *
*******************************************************************************
PROCEDURE GMAG
local ek,t[100]
local lmag:=1
save screen to ek
do skom with "PgUp - Spis magazynow     ENTER - zatwierdzenie"
set cursor on
@ 18,20 say "  Zatwierdz numer magazynu glownego       "
@ 18,57 get lmag picture "999" range 1,wmagil
read
if lastkey()=18
  @ 6,15 TO 7+wmagil,31 double   
  lmag=achoice(7,16,6+wmagil,30,nm,,,lmag)
endif
set cursor off
restore screen from ek
*do kodstan
NumKas=lmag
do dokdefault
restore from pam additive

if.not.vvt
  fakturtyp=2
  rachuntyp=2
  paragtyp=2
endif
pksiega=.f.
set color to (coldef)
help="menu"
do nstan

*do mdef
*do defkonto

if.not.mag_lic
  do blokada
  if.not.licencja
    return
  endif  
endif
set color to
*do haslo with 10,25 
*if.not.dostep
*  clear
*  return
*endif  
keyboard chr(205)
daf:=date()  && data obowiazujaca
fwar=".t."
rekon=.f.
save to pam

**do nstan
@ 2,1 say NM[NumStan]
@ 3,24 say fwl
RETURN

***************************wywolanie z sel. 2 !
PROCEDURE KSDEFAULT
local numtxt:=alltrim(str(ksfirnum))
local dattxt:=alltrim(str(month(daf)))
do firdefault
if file("firmem.dbf")
  select 7
  use firmem
  zremzer=remzer
  zremakt=remakt
  zvatzer=vatzer
  zvatzap=vatzap
  zvat=vat
  zryczalt=ryczalt
  use
endif    
  select 2
  kssciezka="F00\M00"
  if ksfirnum <10
    kssciezka=stuff(kssciezka,3,1,numtxt)
  else
    kssciezka=stuff(kssciezka,2,2,numtxt)
  endif
  if month(daf)<10
    kssciezka=stuff(kssciezka,7,1,dattxt)  
  else
    kssciezka=stuff(kssciezka,6,2,dattxt)  
  endif
  set default to 
  set default to &kssciezka
RETURN

**************************wywolanie z selectu 2 !
PROCEDURE PKSDEFAULT
parameters pmiesiac
local numtxt:=alltrim(str(ksfirnum))
local dattxt:=alltrim(str(pmiesiac))
do firdefault
select 7
use firmem
zremzer=remzer
zremakt=remakt
zvatzer=vatzer
zvatzap=vatzap
zvat=vat
zryczalt=ryczalt
use
select 2
kssciezka="F00\M00"
if ksfirnum <10
  kssciezka=stuff(kssciezka,3,1,numtxt)
else
  kssciezka=stuff(kssciezka,2,2,numtxt)
endif
if pmiesiac<10
  kssciezka=stuff(kssciezka,7,1,dattxt)  
else
  kssciezka=stuff(kssciezka,6,2,dattxt)  
endif
  set default to 
  set default to &kssciezka
RETURN


PROCEDURE FIRDEFAULT
local numtxt:=alltrim(str(ksfirnum))
kssciezka="F00"
if ksfirnum <10
  kssciezka=stuff(kssciezka,3,1,numtxt)
else
  kssciezka=stuff(kssciezka,2,2,numtxt)
endif
  set default to 
  set default to &kssciezka
RETURN
