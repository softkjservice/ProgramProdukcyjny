local t[18],g[4],dk[3],wd[2]
local lms:=month(daf)         &&numer miesiaca do wydruku
local lmiesiac:=space(12)
local ls:=1                   &&numer pozycji menu wyboru okresu raportu
local ld1:=daf                &&raport za dzien lub poczatek przedzialu czasowego
local ld2:=daf                &&koniec przedzialu czasowego
local lzakup:=.t.           &&wydruk faktur
local lsprzedaz:=.t.          &&wydruk rachunkow 
local lrazem:=.t.          &&wydruk paragonow
local lzbiorczy:=.t.          &&wydruk raportu zbiorczego      
local ek:=savescreen(0,0,24,79)
local lfiltr:=""
local ldruk:=.t.
local ekran
private fnum1:=space(15),fnum2:=space(15),fd1:=date(),fd2:=date()
private rnum1:=space(15),rnum2:=space(15),rd1:=date(),rd2:=date()
private pnum1:=space(15),pnum2:=space(15),pd1:=date(),pd2:=date()
private dokument:=0,text1:=space(80),text2:=space(80),text3:=space(80)
public fdat1:=date()
public fdat2:=date()
public fmies:=month(date())
drukar=.f.
hzakup=.f.       && rozgraniczenie wydruku dla zakupu i sprzedazy
w=0
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°                  L I S T A   P L A C                     °"
t[3]:= "°==========================================================°"
t[4]:= "°   PARAMETRY   ²    OKRES :                               °"
t[5]:= "°²²²²²²²²²²²²²²²²                                          °"
t[6]:= "° ZATWIERDZENIE ²                                          °"
t[7]:= "° 1. OKRES      ²                                          °"
t[8]:= "° 2. WYDRUK     ²                                          °"
t[9]:= "°               ²                                          °"
t[10]:="°²²²²²²²²²²²²²²²²                                          °"
t[11]:="°               ²                       WYDRUK :           °"
t[12]:="°               ²                                          °"
t[13]:="°               ²                                          °"
t[14]:="°               ²                                          °"
t[15]:="°               ²                                          °"
t[16]:="°               ²                                          °"
t[17]:="°               ²                                          °"
t[18]:="°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
g[1]:=" ZATWIERDZENIE "
g[2]:=" 1. OKRES      "
g[3]:=" 2. WYDRUK     "
g[4]:="               "
DK[1]:="ûÞ ZAKUP      "
DK[2]:="ûÞ SPRZEDAZ   "
DK[3]:="ûÞ RAZEM      "
WD[2]:="ûÞ EKRAN     "
WD[1]:=" Þ DRUKARKA  "
text2=space(70)
text3=space(70)
save screen to ek
*tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
@ 0,0,24,79 box tlo
set color to n/w,w/n
@ 0,0 say " P A R A M E T R Y     R A P O R T U                                            "
for i=1 to 18
  @ i+2,10 say t[i]
next
do skom with "STRZALKI - przemieszczanie kursora   ENTER -  zatwierdzenie    ESC - rezygnacja"
set color to (coldef)
*@ 3,10,20,69 box chr(205)
@ 3,10 to 20,69 double
@ 14,51 to 17,65 double  
@ 15,52 say wd[1]
@ 16,52 say wd[2]
do anokres with 7,32,ls,lms,ld1,ld2,.t.
do while .t.
  setprc(0,0)
  w=prow()
  s=achoice(8,11,12,25,g)
  keyboard chr(205)
  do case
    case s=1
      save screen to ekran
	  fdat1=ld1          &&przygotowanie zmiennych typu public do filtru
      fdat2=ld2
      fmies=lms
      clear typeahead	
      @ 16,11 say "   Czekaj !    "
************definiowanie filtra czasowego
      do case
        case ls=1                       &&raport za dzien
	      lfiltr="tdat=fdat1"
		  text2="ZA DZIEN  :                                                                                  "          
          text2=stuff(text2,15,8,dtoc(ld1))          		  
	    case ls=2                       &&raport  za miesiac
	      lfiltr="month(tdat)=fmies"
          do miesiac with lms,lmiesiac
		  text2="ZA MIESIAC :                                                                                 "          
          text2=stuff(text2,15,12,lmiesiac)          		
        case ls=3                       &&za okres od do
	      lfiltr="max(fdat1,tdat)=tdat.and.min(fdat2,tdat)=tdat"
		  text2="ZA OKRES OD DNIA :                                                                           "          
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase
*************

      text1="LISTA PLAC               "  
      do sumplac with lfiltr
      restore screen from ekran
      @ 16,11 say "Koniec raportu!"
      @ 17,11 say "Esc->rezygnacja" 

    case s=2
      do anokres with 7,32,ls,lms,ld1,ld2,.F.
    case s=3
      ws=achoice(15,52,16,64,wd)
      do case
	    case ws=1
		  drukar=.t.
		  wd[1]=stuff(wd[1],1,1,"û")
		  wd[2]=stuff(wd[2],1,1," ")
	    case ws=2
		  drukar=.f.
		  wd[1]=stuff(wd[1],1,1," ")		  
		  wd[2]=stuff(wd[2],1,1,"û")
	  endcase
      @ 15,52 say wd[1]
      @ 16,52 say wd[2]	  
	case s=0
	  exit  
  endcase
enddo
restore screen from ek
return


PROCEDURE SUMPLAC
parameters pfiltr
local t[5],q[5]
local lfiltr:=.t.,lplaca:=0
t[1]:="nazwisko"
t[2]:="imie1"
t[3]:="imie2"
t[4]:="placa"
t[5]:="urlop"      &&numer magazynu
q[1]:="NAZWISKO"
q[2]:="IMIE 1"
q[3]:="IMIE 2"
q[4]:="WYNAGRODZENIE"
q[5]:="MAGAZYN"
do pracdefault
select 1
use pracow index prac_naz
do dokdefault
select 2
use mmdok 
select 1
do while.not.eof()
  lplaca=0
  rindex=index 
  select 2
  set filter to tnkon=rindex
  go top
  lfiltr=pfiltr+""+".and."+dbfilter()
  set filter to &lfiltr
  go top
  do while.not.eof()
    lplaca=lplaca+round(til*tcen,2)
    skip
  enddo
  select 1
  replace placa with lplaca
  skip
enddo
select 2
close
select 1
*browse()
go top
do plactlo
if drukar
  keyboard chr(82)
endif
@ 23,1 say space(78)
dbedit(1,1,22,78,t,"UPL","",q,,,chr(205))
close
do dokdefault
RETURN

FUNCTION UPL(tryb,numer)
local last:=lastkey(),ldruk:=.t.,ek
save screen to ek
do case
  case last=85.or.last=117
    do psum
  case last=82.or.last=114
    do startrap with 1,ldruk
    if.not.ldruk
      restore screen from ek
      return 0
    endif
    do skom with "Czekaj !  Trwa drukowanie."     
    drukar=.t.
    set device to printer
    @ prow(),pcol() say &zdr_kond
    do placdruk
	keyboard chr(205)
	drukar=.f.
    set device to screen
    restore screen from ek
  case last=27
    return 0
endcase
RETURN 1

PROCEDURE PLACTLO
for i=1 to 23
  @ i,0 say chr(176)
  @ i,79 say chr(176)  
next
set color to n/w
@ 0,0 say "                         L I S T A      P L A C                                 "
do skom with "dRukuj     sUma      Esc - rezygnacja"
RETURN


PROCEDURE PLACDRUK
local lp:=0
local lt1:="|   |                      | ............... | ............... |                 |.................|.................................|"
local lt2:="|   |                      |                 |                 |                 |                 |                                 |"
local lt3:="--------------------------------------------------------------------------------------------------------------------------------------"
local lnaz:=space(30),limie1:=space(15),limie2:=space(15),ltxplaca:=space(15),lsumplac:=0
setprc(0,0)
w=prow()
do placglow
do plactyt
go top
do while.not.eof()
  lp=lp+1
  lnaz=nazwisko
  limie1=imie1
  limie2=imie2
  ltxplaca=str(placa,12,2)
  lsumplac=lsumplac+placa
	
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,7,20,lnaz)
	if limie1#space(15)
	  lt1=stuff(lt1,30,15,limie1)
	endif
	if limie2#space(15)  
  	  lt1=stuff(lt1,48,15,limie2)
	endif  
	lt1=stuff(lt1,66,12,ltxplaca)
    if substr(uwagi,1,17)#space(17)
	  lt1=stuff(lt1,83,17,substr(uwagi,1,17))
	endif
    @ w,0 say lt1
    w=w+1
	@ w,0 say lt2
    w=w+1
    lt1:="|   |                      | ............... | ............... |                 |.................|.................................|"
  skip
  if w>dlugosc-4.and..not.eof()
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
    do plactyt
  endif
enddo
do placstopa with lsumplac
eject
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE PLACGLOW
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  @ w,0 say text1
  w=w+1
  @ w,0 say "==============================================================================="
  w=w+1
  @ w,0 say text2
  w=w+1
  @ w,0 say text3
    if grafik
      @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
    else
      @ prow(),pcol() say &zdr_kond
    endif  
  w=w+1
RETURN




PROCEDUR PLACTYT
local lt1:="======================================================================================================================================"
local lt2:="|Lp.|   N A Z W I S K O    |   I M I E  1    |   I M I E  2    |  WYNAGRODZENIE  |     UWAGI       |          P O D P I S            |"
local lt3:="|   |                      |                 |                 |                 |                 |                                 |"
local lt4:="|===|======================|=================|=================|=================|=================|=================================|"
local lt5:="|   |                      |                 |                 |                 |                 |                                 |"
@ prow(),pcol() say &zdr_kond
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
@ w,0 say lt5
w=w+1
RETURN


PROCEDURE PLACSTOPA
PARAMETERS psumplac
local lt1:="|   |                      |                 |                 |                 |                 |                                 |"
local lt2:="=============================================|=================|=================|===================================================|"
local lt3:="                                             |  R A Z E M  :   |                 |                                                   "
local lt4:="                                             -------------------------------------                                                   "
local lwartosc:=space(10)
local lzysk:=space(10)


lt3=stuff(lt3,66,12,STR(psumplac,12,2))

@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
RETURN


PROCEDURE PSUM
local recno:=recno(),lsum:=0,ek
save screen to ek
go top
do while.not.eof()
  lsum=lsum+placa
  skip
enddo
@ 23,46 say "Razem do wyplaty: "
@ 23,64 say lsum picture "999999999.99"
do tkom with "Nacisnij dowolny klawisz !"
go recno
restore screen from ek
RETURN