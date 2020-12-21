*KONTRAHENCI
*PROCEDURE KONTRAH       &&Kartoteka kontrahentow
parameters pnaz1
local t[27],q[27]
local ep:=savescreen(0,0,24,79)
biezaca:=.t.
t[1]:="nazwisko"
t[2]:="imie1"
t[3]:="stanowisko"
t[4]:="etat"
t[5]:="plec"
t[6]:="imie2"
t[7]:="naz_panna"
t[8]:="miasto"
t[9]:="ulica"
t[10]:="kod"
t[11]:="telefon"
t[12]:="data_ur"
t[13]:="miej_ur"
t[14]:="stan_cywil"
t[15]:="dowod_osob"
t[16]:="wydany"
t[17]:="dowod_data"
t[18]:="wyksztal"
t[19]:="szkola"
t[20]:="zaw_wyucz"
t[21]:="zaw_wykon"
t[22]:="dat_zatrud"
t[23]:="urlop"
t[24]:="dni_wolne"
t[25]:="haslo"
t[26]:="index"
t[27]:="placa"
q[1]:="NAZWISKO PRACOWNIKA"
q[2]:="IMIE"
q[3]:="ZAJMOWANE STANOWISKO"
q[4]:="ETAT"
q[5]:="PLEC"
q[6]:="DRUGIE IMIE"
q[7]:="NAZWISKO PANIENSKIE"
q[8]:="ADRES - MIASTO"
q[9]:="ULICA / NUMER_DOMU" 
q[10]:="KOD"
q[11]:="TELEFON"
q[12]:="DATA UR."
q[13]:="MIEJSCE URODZENIA"
q[14]:="STAN CYWILNY"
q[15]:="NR.DOW.OSOB."
q[16]:="WYDANY PRZEZ"
q[17]:="DNIA"
q[18]:="WYKSZTALCENIE"
q[19]:="UKONCZONA SZKOLA"
q[20]:="ZAWOD WYUCZONY"
q[21]:="ZAWOD WYKONYWANY"
q[22]:="DATA ZATR."
q[23]:="MAGAZYN"
q[24]:="DNI WOLNE"
q[25]:="HASLO"
q[26]:="INDEX"
q[27]:="AKORD"
*********************************** Deklaracja zmiennych (pol)
rindex=0
rnazwisko=space(20)
rimie1=space(15)
rimie2=space(15)
rplec=space(1)
rnaz_panna=space(20)
rmiasto=space(20)
rulica=space(20)
rkod=space(6)
rtelefon=space(17)
rdata_ur=ctod("        ")
rmiej_ur=space(20)
rstan_cywil=space(7)
rdowod_osob=space(10)
rwydany=space(20)
rdowod_data=ctod("        ")
rstanowisko=space(30)
retat=space(3)
rwyksztal=space(10)
rszkola=space(30)
rzaw_wyucz=space(20)
rzaw_wykon=space(20)
rurlop=1
rdni_wolne=0
rdat_zatrud=ctod("        ")
rhaslo=space(10)
ruwagi=space(42)
rplaca=0
*******************************************************************************

keyboard chr(205)
save screen to ep
set color to
do pracdefault
do while .t.
  do practlo
  select 5
  if biezaca
	use pracow 
    set index to  prac_naz,prac_num
  else  
	use wnik 
    set index to  wnik_naz,wnik_num
  endif  
  
if pnaz1#space(30)  
  set softseek on
  pnaz1=alltrim(pnaz1)
  seek pnaz1
  if found()=.f.
    go bottom
    do tkom with "PRACOWNIK nie odnaleziony.    Nacisnij dowolny klawisz !"
    keyboard chr(205)
  endif
  set order to 1
  set softseek off  
endif  
  
  dbedit(1,1,19,78,t,"UPR","",q,"ß")
  if lastkey()=27.or.lastkey()=13
    exit
  endif
  use
enddo  
close
do dokdefault
restore scree from ep
RETURN


FUNCTION UPR(tryb,numer)
local zatwierdz:=.t.
local zapisz:=.t.
local e5:=savescreen(0,0,24,79)
local s:=1
local z[5],t[3],q[5]
local last:=lastkey()
@ 21,18 say kod
@ 22,18 say miasto
@ 23,18 say ulica
@ 21,56 say telefon
@ 22,56 say urlop
@ 23,56 say dni_wolne
do case

   case (last=68.or.last=100).and.biezaca    && Dopisz
       do praczer
	   do pnumplus
      * rindex=numprac+1
       set cursor on
	   do practlo1
     do while .t.	  
       zatwierdz=.T.	  
       @ 22,26 say "   Enter - Zatwierdzenie      Esc - Rezygnacja     "
       do sayprac
       do getprac
       if lastkey()=27
         exit
       endif
       @ 22,26 say "  Czy dane PRACOWNIKA sa poprawne ?   [T/N]       "
       @ 22,73 get zatwierdz
       read
       if lastkey()=27
         exit
       endif
       if zatwierdz
         @ 22,26 say "   Czy  zapamietac   PRACOWNIKA  ?    [T/N]       "
         @ 22,73 get zapisz   
         read	   
         set color to 	   
         exit
       endif  
enddo
set cursor off
if lastkey()=27
  restscreen(0,0,24,79,e5)
  keyboard chr(205)
  return 2 
endif
found=.f.  
do foundtest    &&Jesli prac. juz istnieje to fuond =.t. 
if found        &&jesli znalazl w sel. 5 lub 6
  select 6
  use
  select 5
  restscreen(0,0,24,79,e5)
  keyboard chr(205)
  return 2
else
  if.not.zapisz         && zapamieta kontrahenta w bazie anulowanych
        append blank
        do replacprac
        numprac=numprac+1
	    save to pam
	    use
		select 5
   else                 && zapamieta kontrahenta w bazie aktualnej
        use
		select 5
        append blank
		do replacprac
        numprac=numprac+1
	    save to pam
   endif		
endif
restscreen(0,0,24,79,e5)
keyboard chr(205)
return 2 

case (last=80.or.last=112).and.biezaca    && Popraw
    do praclad
    do practlo1
  do while .t.	
    zatwierdz=.T.  
    @ 22,26 say "   Enter - Zatwierdzenie      Esc - Rezygnacja     "
    do sayprac
    do getprac
    if lastkey()=27
      exit
    endif
    @ 22,26 say "  Czy dane KONTRAHENTA sa poprawne ?   [T/N]       "
    @ 22,73 get zatwierdz
    read
    set color to 
    if zatwierdz
      exit
    endif  
  enddo
set cursor off
if lastkey()#27
    do replacprac
endif
restscreen(0,0,24,79,e5)
keyboard chr(205)
return 2 

case last=83.or.last=115      && Szukaj po Nazwisku
set order to 1
set softseek on
set cursor on
for i=21 to 23
  @ i,1 say space(79)
next
@ 22,12 say "Podaj nazwisko PRACOWNIKA:  "get rnazwisko picture "@!"
read
set cursor off
rnazwisko1=alltrim(rnazwisko)
seek rnazwisko1
if found()=.f.
  go bottom
  do tkom with "PRACOWNIK nie odnaleziony.    Nacisnij dowolny klawisz !"
endif
set softseek off
keyboard chr(205)
restscreen(0,0,24,79,e5)


case (last=85.or.last=117).and.biezaca       && Usun z aktualnej bazy
    do praclad
    zatwierdz=.T.
    set cursor on
	do practlo1
    do sayprac
    @ 22,26 say "    Usunac z aktualnej kartoteki  ?    [T/N]       "
    @ 22,73 get zatwierdz
    read
    set color to 
    if zatwierdz.and.lastkey()#27 
      delete 
	  pack
	  select 6
      use wnik 
      set index to  wnik_naz,wnik_num
	  append blank
      do replacprac
      use
	  select 5
	  commit
    endif  
set cursor off
restscreen(0,0,24,79,e5)
keyboard chr(205)
return 2 


case (last=69.or.last=101).and.biezaca=.f.       && Export do aktualnej bkartoteki
  do praclad
    zatwierdz=.T.
	do practlo1
    do sayprac
    @ 22,26 say " Wpisac do  aktualnej  kartoteki  ?    [T/N]       "
    @ 22,73 get zatwierdz
    read
    set color to 
    if zatwierdz.and.lastkey()#27 
      delete 
	  pack
	  select 6
      use pracow
      set index to prac_naz,prac_num
	  append blank
	  do replacprac
      use
	  select 5
	  commit
    endif  
set cursor off
restscreen(0,0,24,79,e5)
keyboard chr(205)
return 2 


case last=65.or.last=97    && Archiwum
if biezaca
  biezaca=.f.
  keyboard chr(205)  
  return 0
else
  biezaca=.t.  
  keyboard chr(205)  
  return 0  
endif

case (last=75.or.last=107).and.biezaca=.f.    && Kasuj
  do praclad
    zatwierdz=.T.
	do practlo1
    do sayprac 
    @ 22,26 say " Wykasowac informacje o KONTRAHENCIE ? [T/N]       "
    @ 22,73 get zatwierdz
    read
	set cursor off
    set color to 
	if zatwierdz.and.lastkey()#27 
      dok=1
	  ildok=1
      if file ("dokument.dbf")
    do while dok<=ildok
      select 1
      use przerob  		  		  		  
	  locate for nplat=rindex
	  if found()
		  do tkom with "Pracownik zwiazany z dokumentami - nie moze byc usuniety !  Nacisnij klawisz"
          restscreen(0,0,24,79,e5)
          keyboard chr(205)
		  use
		  select 5
          return 2 		
	  endif  
	  use
	  select 5	  
      dok=dok+1
    enddo 	   			  	  
	  endif
	  delete
      pack
	  commit
	endif  
restscreen(0,0,24,79,e5)
keyboard chr(205)
return 2 

case last=27
  return 0

 case last=13
 do praclad
 return 0
endcase	
RETURN 1



PROCEDURE PRACTLO
clear
@ 0,0 say replicate(chr(176),80)
for i=1 to 23
  @ i,0 say chr(176)
  @ i,79 say chr(176)
next
set color to n/w

if biezaca
  @ 24,0 say "F1-HELP   Dopisz   Popraw   Szukaj   Usun   Archiw.  ENTER-ZATW. ESC-REZYG."   
  @ 0,21 say " *  KARTOTEKA    P R A C O W N I K O W  *"
else
  @ 24,0 say "F1-HELP   Aktualna_kartot.   Szukaj  Export  Kasuj   ENTER-ZATW. ESC-REZYG."   
  @ 0,14 say " *  KARTOTEKA    P R A C O W N I K O W  -  ARCHIWUM  * "  
endif
set color to
@ 20,1 say replicate(chr(196),78)
@ 20,22 say chr(193)
@ 20,40 say chr(193)
@ 20,73 say chr(193)
@ 21,1 say " Kod pocztowy...."
@ 22,1 say " Adres: Miasto..." 
@ 23,1 say "        Ulica...."
@ 21,44 say "Tel........"
@ 22,44 say "Magazyn...."
@ 23,44 say "Dni wolne.."
RETURN

PROCEDURE PRACTLO1
       set color to n/w
       for i=1 to 23
         @ i,23 say replicate(chr(178),57)
       next
       set color to 
       @ 2,26 say " _________________________________________________ "
       @ 3,26 say "     D A N E     P R A C O W N I K A     nr        "
       @ 4,26 say " ------------------------------------------------- "
       set color to n/w
       @ 24,0 say space(80)
       @ 5,26 say " NAZWISKO..                     NUMER MAGAZYNU     "
       @ 6,26 say " IMIE_1..               . IMIE_2..               . "
       @ 7,26 say " ADRES:  MIASTO..                    . KOD..      ."
       @ 8,26 say "   UL..                    . TEL.                 ."
       @ 9,26 say " DATA UR..        .  MIEJSCE..                    ."	   
       @ 10,26 say " PLEC.. . NAZWISKO PANIENSKIE..                    "
       @ 11,26 say " STAN CYWILNY..       .   NR.DOW.OSOB..          . "      
       @ 12,26 say " WYDANY PRZEZ..                    . DNIA..        "
       @ 13,26 say" UKONCZONA SZKOLA..                              . "
       @ 14,26 say" ZAWOD WYUCZONY....                    .           "
       @ 15,26 say" ZAWOD WYKONYWANY..                    .           "
       @ 16,26 say" STANOWISKO..                              .       "
       @ 17,26 say" WYKSZTALCENIE..          . ETAT..   .             "
       @ 18,26 say" DATA ZATRUDNIENIA..        .                      "
       @ 19,26 say" DNI WOLNE..   .                                   "	  
       @ 20,26 say" UWAGI..                                          ."	   	    	   	   
       set color to
RETURN	   


PROCEDURE PRACZER
rindex=0
rnazwisko=space(20)
rimie1=space(15)
rimie2=space(15)
rplec=space(1)
rnaz_panna=space(20)
rmiasto=space(20)
rulica=space(20)
rkod=space(6)
rtelefon=space(17)
rdata_ur=ctod("        ")
rmiej_ur=space(20)
rstan_cywil=space(7)
rdowod_osob=space(10)
rwydany=space(20)
rdowod_data=ctod("        ")
rstanowisko=space(30)
retat=space(3)
rwyksztal=space(10)
rszkola=space(30)
rzaw_wyucz=space(20)
rzaw_wykon=space(20)
rurlop=1
rdni_wolne=0
rdat_zatrud=ctod("        ")
rhaslo=space(10)
ruwagi=space(42)
rplaca=1
RETURN

PROCEDURE PRACLAD
rindex=index
rnazwisko=nazwisko
rimie1=imie1
rimie2=imie2
rplec=plec
rnaz_panna=naz_panna
rmiasto=miasto
rulica=ulica
rkod=kod
rtelefon=telefon
rdata_ur=data_ur
rmiej_ur=miej_ur
rstan_cywil=stan_cywil
rdowod_osob=dowod_osob
rwydany=wydany
rdowod_data=dowod_data
rstanowisko=stanowisko
retat=etat
rwyksztal=wyksztal
rszkola=szkola
rzaw_wyucz=zaw_wyucz
rzaw_wykon=zaw_wykon
rurlop=urlop
rdni_wolne=dni_wolne
rdat_zatrud=dat_zatrud
rhaslo=haslo
ruwagi=uwagi
rplaca=placa
RETURN

PROCEDURE SAYPRAC
set color to n/w
@ 3,70 say rindex picture "9,999"
@ 5,37 say rnazwisko
@ 6,35 say rimie1
@ 6,60 say rimie2
@ 7,43 say rmiasto
@ 7,70 say rkod
@ 8,33 say rulica
@ 8,59 say rtelefon
@ 9,36 say rdata_ur
@ 9,56 say rmiej_ur
@10,33 say rplec
@10,57 say rnaz_panna
@11,41 say rstan_cywil
@11,65 say rdowod_osob
@12,41 say rwydany
@12,69 say rdowod_data
@13,45 say rszkola
@14,45 say rzaw_wyucz
@15,45 say rzaw_wykon
@16,39 say rstanowisko
@17,42 say rwyksztal
@17,60 say retat
@18,46 say rdat_zatrud
@19,38 say rdni_wolne picture "999"
*@19,63 say rhaslo
@20,34 say ruwagi
@ 5,73 say rurlop picture "999"
set color to
RETURN


PROCEDURE GETPRAC
set cursor on
@ 5,37 get rnazwisko picture "@!"
@ 5,73 get rurlop picture "999" range 1,wmagil
@ 6,35 get rimie1 picture "@!"
@ 6,60 get rimie2 picture "@!"
@ 7,43 get rmiasto picture "@!"
@ 7,70 get rkod picture "@!"
@ 8,33 get rulica picture "@!"
@ 8,59 get rtelefon picture "@!"
@ 9,36 get rdata_ur
@ 9,56 get rmiej_ur
@10,33 get rplec picture "@!"
@10,57 get rnaz_panna picture "@!"
@11,41 get rstan_cywil picture "@!"
@11,65 get rdowod_osob picture "@!"
@12,41 get rwydany picture "@!"
@12,69 get rdowod_data picture "@!"
@13,45 get rszkola picture "@!"
@14,45 get rzaw_wyucz picture "@!"
@15,45 get rzaw_wykon picture "@!"
@16,39 get rstanowisko picture "@!"
@17,42 get rwyksztal picture "@!"
@17,60 get retat picture "@!"
@18,46 get rdat_zatrud
@19,38 get rdni_wolne picture "999"
*@19,63 get rhaslo picture "@!"
@20,34 get ruwagi picture "@!"
read
set cursor off
RETURN

PROCEDURE REPLACPRAC
replace index with rindex,nazwisko with rnazwisko,imie1 with rimie1
replace imie2 with rimie2,plec with rplec,naz_panna with rnaz_panna
replace miasto with rmiasto,ulica with rulica,kod with rkod
replace telefon with rtelefon,data_ur with rdata_ur,miej_ur with rmiej_ur
replace stan_cywil with rstan_cywil,dowod_osob with rdowod_osob
replace wydany with rwydany,dowod_data with rdowod_data,stanowisko with rstanowisko
replace etat with retat,wyksztal with rwyksztal,szkola with rszkola
replace zaw_wyucz with rzaw_wyucz,zaw_wykon with rzaw_wykon,urlop with rurlop
replace dni_wolne with rdni_wolne,dat_zatrud with rdat_zatrud
replace haslo with rhaslo,uwagi with ruwagi,placa with rplaca
commit
RETURN


PROCEDURE FOUNDTEST

seek rnazwisko
if found()
  do while nazwisko=rnazwisko.and..not.eof()
    if imie1=rimie1.and.imie2=rimie2.and.miasto=rmiasto.and.ulica=rulica.and.dowod_osob=rdowod_osob
      found=.t.
      do tkom with "Pracownik o podanym nazwisku i adresie juz istnieje !   Nacisnij klawisz."
      exit
    endif
    skip
  enddo
endif  
if.not.found
  select 6
  use wnik index wnik_naz,wnik_num
  seek rnazwisko
  if found()
    do while nazwisko=rnazwisko.and..not.eof()
    if miasto=rmiasto.and.ulica=rulica.and.dowod_osob=rdowod_osob
	    found=.t.
	    do tkom with "Pracownik juz istnieje w bazie anulowanych!  Przenies!  Nacisnij klawisz."
        exit
	  endif
      skip
    enddo  
  endif
endif
RETURN


PROCEDURE PNUMPLUS
set order to 2
go bottom
rindex=index+1
set order to 1
RETURN
