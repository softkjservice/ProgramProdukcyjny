PROCEDURE ADRUK
local lp1:= "PRACOWNIK :                                                                     "
local lp2:= "| Magazyn przyjmujacy towar : ....                   | Adres :  Miasto ...                    Ulica ...                   "     
local lwartosc:=zwar
local ld1:=space(80)
local ld2:=space(132)
local ld3:=space(132)
local ld4:=space(132)
local ld5:=space(132)
local ld6:=space(132)
local ld7:=space(132)
local ld8:=space(132)
local ld9:=space(132)
local pnm:=nm[NumStan]
local pmm:=mm[NumStan]
local pum:=um[NumStan]
local len1:=len(alltrim(rnazwisko))
local len2:=len(alltrim(rimie1))
local len3:=len(alltrim(rimie2))

*@ prow(),pcol() say &wektor+&zdr_kond
if papfir
  w=prow()+12
else
  w=prow()
endif  
do doktyt

select 11
use towbuf index towbuf

lp1=stuff(lp1,13,len1,ALLTRIM(rnazwisko))
lp1=stuff(lp1,15+len1,len2,ALLTRIM(rimie1))
lp1=stuff(lp1,17+len1+len2,len3,ALLTRIM(rimie2))

  w=w+1
  @ w,0 say lp1
* w=w+1
  do druktow with .t.
  return



w=w+1
if substr(ztyp,4,1)$"PT".and..not.gonful
  ld1="S P R Z E D A W C A  :                                                          "                
  ld2= "| Nazwisko i imie ...                               |                                                                   "
  ld3= "| lub nazwa firmy ...                               |                                                                   "
  ld4= "| Adres: Miasto .....                               |                                                                   "
  ld5= "| Kod:        Ulica..                               |                                                                   "
  ld6= "| Nr.identyfikacyjny                                |                                                                   "
  ld7= "| Konto .............                               |                                                                   "
  ld8= "| Cd konta...........                               |                                                                   "
else
  ld1="S P R Z E D A W C A  :                 N A B Y W C A  :                         "
  ld2= "| Nazwisko i imie ...                               |              | Nazwisko i imie ...                               |"
  ld3= "| lub nazwa firmy ...                               |              | lub nazwa firmy ...                               |"
  ld4= "| Adres: Miasto .....                               |              | Adres: Miasto......                               |"
  ld5= "| Kod:        Ulica..                               |              | Kod:        Ulica..                               |"
  ld6= "| Nr.identyfikacyjny                                |              | Nr.identyfikacyjny                                |"
  ld7= "| Konto .............                               |              | Konto .............                               |"
  ld8= "| Cd konta...........                               |              | Cd konta ..........                               |"     
endif

flic1=stuff(space(30),1,len(flic1),flic1)
flic2=stuff(space(30),1,len(flic2),flic2)
flic3=stuff(space(30),1,len(flic3),flic3)
flic4=stuff(space(30),1,len(flic4),flic4)
flic5=stuff(space(30),1,len(flic5),flic5)
flic6=stuff(space(30),1,len(flic6),flic6)


ld2=stuff(ld2,22,30,flic1)
ld3=stuff(ld3,22,30,flic2)
ld4=stuff(ld4,22,30,flic3)
ld5=stuff(ld5,22,30,flic4)
ld5=stuff(ld5,7,6,substr(flic6,1,6))
ld6=stuff(ld6,22,30,flic5)
ld7=stuff(ld7,22,30,substr(zkon,1,30))
ld8=stuff(ld8,22,30,substr(zkon,31,30))

if.not.substr(ztyp,4,1)$"PT".or.substr(ztyp,4,1)$"PT".and.gonful
  ld2=stuff(ld2,89,30,znaz1)
  ld3=stuff(ld3,89,30,znaz2)
  ld4=stuff(ld4,89,30,zmiasto)
  ld5=stuff(ld5,89,30,zulica)
  ld5=stuff(ld5,74,6,zkod)
  ld6=stuff(ld6,89,13,znip)
  ld7=stuff(ld7,89,30,substr(zkontrahkonto,1,30))
  ld8=stuff(ld8,89,30,substr(zkontrahkonto,31,30))
endif


if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else  
  @ prow(),pcol() say &zdr_kkond
endif  
@ w,0 say ld1
w=w+1

if grafik
  @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
else
  @ prow(),pcol() say &zdr_kond
endif  
@ w,0 say ld2
w=w+1
@ w,0 say ld3
w=w+1
@ w,0 say ld4
w=w+1
@ w,0 say ld5
w=w+1
@ w,0 say ld6
w=w+1
@ w,0 say ld7
w=w+1
@ w,0 say ld8
if substr(flic6,10,24)#space(15)
  w=w+1
  @ w,3 say "Telefon :"
  @ w,13 say substr(flic6,10,24)
  w=w-1
endif

if substr(zndok,14,1)="K"
  select 31
  use korbuf index korbuf
  zap
  select 21
  do while tndok=zndok.and..not.eof()
    do ztlad
	select 31
	append blank
	do treplac
	select 21
    skip
  enddo
  close
  select 31
  w=w+3
  @ w,0 say "PRZED KOREKTA:"
  do druktow with .f.
  close
  select 11
  @ w,0 say replicate(chr(45),120)
  w=w+2
  @ w,0 say "KOREKTA:"
endif
do druktow with .t.

RETURN



PROCEDURE STAWKI      &&na wzor oferty
local t[60]
local lp:=1
local lt1:="|.... ................................ ............... .. .|    |.... ................................ ............... .. .|"
local lt2:="|                                                          |    |                                                          |"  
local lt3:="------------------------------------------------------------    ------------------------------------------------------------"
local lpiec:=0
local lcendn:=0
local lcendb:=0
local lcenhn:=0
local lcenhb:=0
local cenadn:=space(15)
local cenadb:=space(15)
local cenahn:=space(15)
local cenahb:=space(15)
local cena:=space(15)
local lkod:=space(7)
local lstaw:=space(2)
local luwag:=space(5)
local lil:=0
local lznak:=space(1)
for i=1 to 60
  t[i]:=space(124)
next
w=prow()
do stawglow
do stawtyt						
go top
i=1
lewa=.t.
do while.not.eof()
 if mcen_p#0
  lil=mil
  lcendn=round(mcen_p,2)
  cenadn=stuff(".............  ",14-len(alltrim(strj(lcendn))),len(alltrim(strj(lcendn))),alltrim(strj(lcendn))) 
  cena=cenadn
  lstaw="zl"
  do kodil with lil,lznak

  if lewa
	  lt1="|.... ................................ ............... .. .|    |.... ................................ ............... .. .|"
	lt1=stuff(lt1,2,4,str(lp,4))
    lt1=stuff(lt1,7,len(alltrim(mnaz)),alltrim(mnaz))
      lt1=stuff(lt1,40,15,cena)	
      lt1=stuff(lt1,56,2,lstaw)  
      lt1=stuff(lt1,59,1,lznak)  
  else
    lt1=t[i]
    lt1=stuff(lt1,66,4,str(lp,4))
    lt1=stuff(lt1,71,len(alltrim(mnaz)),alltrim(mnaz))
      lt1=stuff(lt1,104,15,cena)		
	  lt1=stuff(lt1,120,2,lstaw)  
      lt1=stuff(lt1,123,1,lznak)    	
  endif
  
  t[i]=lt1
  
  i=i+1
  
  do case
    case i>(dlugosc-11).and.lewa
	  lewa=.f.
	  i=1
    case i>(dlugosc-11).and..not.lewa
      for i=1 to dlugosc-11
	    @ w,0 say t[i]
	    w=w+1
	  next
      for i=1 to 60
	    t[i]=space(124)
	  next
      lewa=.t.
	  i=1 	
  endcase
  
 endif                  &&koniec warunku : placa#0  
  skip
  if w>dlugosc.and..not.eof()
    stro=.t.
    @ w,0 say lt3
	lpiec=0
	strona=strona+1
    eject
	w=prow()
    do stawglow
	do stawtyt
  endif
  lp=lp+1
enddo
      for i=1 to dlugosc-11
	    if t[i]#space(124)
		  @ w,0 say t[i]
	      w=w+1
		endif  
	  next
@ w,0 say lt3+&zdr_kond
eject
RETURN




PROCEDUR STAWTYT
local lt1:="============================================================    ============================================================"
local lt2:="|L.p.|          N A Z W A             | WYNAGRODZENIE |  | |    |L.p.|          N A Z W A             | WYNAGRODZENIE |  | |" 
local lt3:="|    |  wyrobu  towaru  lub  uslugi   |  JEDNOSTKOWE  |  | |    |    |  wyrobu  towaru  lub  uslugi   |  JEDNOSTKOWE  |  | |"
local lt4:="|====|================================|===============|==|=|    |====|================================|===============|==|=|"
local lt5:="|                                                          |    |                                                          |"
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



PROCEDURE STAWGLOW
local ld1:="                     AKORDOWE STAWKI WYNAGRODZENIA                     "
local ld2:="         -----------------------------------------------------         "
local ld3:="Data :                                                      Strona :   "

ld3=stuff(ld3,8,8,dtoc(daf))
ld3=stuff(ld3,70,3,str(strona,3))

if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else
  @ prow(),pcol() say &zdr_kkond
endif
@ w,0 say ld1
w=w+1
@ w,0 say ld2

if grafik
  @ prow(),pcol() say &zdr_kgrubo
endif  
w=w+1
@ w,0 say ld3+&zdr_kond
w=w+2
RETURN



********


PROCEDURE WYRDEF      &&NA WZOR SPDRUK1
local lp:=1
local lt1:="|... ................................ ....... ............... ............  ...|"
local lt2:="|                                                                              |"   
local lt3:="--------------------------------------------------------------------------------"
local lsum:=0
local lpiec:=0
local ltcen:=0
local cenatxt:=space(15)
local liltxt:=space(10)

w=prow()
do wyrglow1
do wyrtyt1						
go top
do while.not.eof()

  ltcen=scena
  lsum=lsum+ltcen*silosc
  
  cenatxt=stuff("...............",16-len(alltrim(strj(ltcen))),len(alltrim(strj(ltcen))),alltrim(strj(ltcen))) 
  liltxt=stuff("..........",11-len(alltrim(str(silosc,10,2))),len(alltrim(str(silosc,10,2))),alltrim(str(silosc,10,2))) 
   
  lt1=stuff(lt1,2,3,str(lp,3))
  lt1=stuff(lt1,6,len(alltrim(snazwa)),alltrim(snazwa))
  lt1=stuff(lt1,39,len(alltrim(skod)),alltrim(skod))
  lt1=stuff(lt1,47,15,cenatxt)  
  lt1=stuff(lt1,64,10,liltxt)
  lt1=stuff(lt1,76,3,sjm)

  @ w,0 say lt1
  w=w+1
  lt1="|... ................................ ....... ............... ............  ...|"
  skip
  if w>dlugosc-6.and..not.eof()
    stro=.t.
    @ w,0 say lt3
	lpiec=0
	strona=strona+1
    eject
	w=prow()
    do wyrglow1
	do wyrtyt1
  endif
  lp=lp+1
enddo
@ w,0 say lt3+&zdr_kond
w=w+2
@ w,0 say "WARTOSC CZESCI SKLADOWYCH :"
@ w,28 say lsum picture "9 999 999.99"
@ w,41 say "ZL"
@ w,50 say "STAWKA AKORDOWA :"
@ w,67 say zdmcen_p picture "9 999 999.99"
@ w,80 say "ZL"
@ w,89 say "RAZEM WARTOSC :"
@ w,104 say lsum+zdmcen_p picture "9 999 999.99"
@ w,117 say "ZL"
eject
RETURN



PROCEDUR WYRTYT1

local lt1:="================================================================================"
local lt2:="|Lp.|          N A Z W A             |  KOD  |Cena magazynowa|    ILOSC   |    |"
local lt3:="|   |      CZESCI SKLADOWEJ          |       | NETTO  [zl]   | W  WYROBIE |J.m.|"
local lt4:="|===|================================|=======|===============|============|====|"
local lt5:="|                                                                              |"
*@ prow(),pcol() say &zdr_kond
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



PROCEDURE WYRGLOW1
local ld1:="WYKAZ CZESCI SKLADOWYCH    "
local ld2:="--------------------------------------------------------------------------------"
local ld3:="Data spisu :                                                         Strona :   "
ld3=stuff(ld3,14,8,dtoc(daf))
ld3=stuff(ld3,78,3,str(strona,3))

if grafik
  @ prow(),pcol() say &zdr_grubo+&zdr_kkond
else
  @ prow(),pcol() say &zdr_kkond
endif
@ w,0 say alltrim(zdmnaz)
@ w,pcol()+5 say zdmkod
@ w,54 say ld1
w=w+1
@ w,0 say ld2

if grafik
  @ prow(),pcol() say &zdr_kgrubo
endif  
w=w+1
@ w,0 say ld3
w=w+2
RETURN

