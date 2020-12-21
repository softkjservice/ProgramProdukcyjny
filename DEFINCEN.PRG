******************************************************************************
* Procedura definiuje wyrob gotowy 
*******************************************************************************
local q[5],w[5]
local lilepoz:=0,ljest:=.f.
local lmnaz:=mnaz,lmkod:=mkod
if.not.file("defin.dbf")
  do tkom with "Definiowanie wyrobow mozliwe tylko w magazynie glownym !  OK!"
  return
endif
drecno=recno()
q[1]:="snazwa"
q[2]:="skod"
q[3]:="silosc"
q[4]:="sjm"
q[5]:="scena"
w[1]:="Nazwa wyrobu"
w[2]:="Kod"
w[3]:="Ilosc"
w[4]:="Jm."
w[5]:="Cena mag."
public zgnazwa:=mnaz
public zgkod:=mkod
*public zgnumer:=nmag
zdmcen_p=mcen_p
zdmnaz=mnaz
zdmkod=mkod
wiersz=3
zlpoz=wiersz+1

select 20
use defin index def_gnaz
seek lmnaz
if found()
  do while gnazwa=lmnaz
    if gkod=lmkod
	  ljest=.t.
	  exit
	endif
    skip
  enddo
endif
close
select 10
if ljest
  zz=.t.
  do gkom with "Aktualizowac koszt produkcji wyrobu ?  [T/F] ",zz
  if zz.and.lastkey()#27
    do wyrkoszt with lmnaz,lmkod
  endif  
  keyboard chr(205)
endif
do tlomfa
@ 1,2 say "Nazwa wyrobu....                                    Kod..." 
@ 1,18 say mnaz
@ 1,60 say mkod
close
do skom with "ENTER - zatwierdzenie wartosci wyrobu     ESC - rezygnacja"
set color to n/w,w/n
@ 0,18 say " *  DEFINIOWANIE ZALEZNOSCI MAGAZYNOWYCH  * "
select 11
use defin index def_snaz,def_gnaz
*set filter to gnumer=zgnumer
set filter to gnazwa=zgnazwa.and.gkod=zgkod
go top
do while.not.eof()
  lilepoz=lilepoz+1
  skip
enddo
go top
zlpoz=zlpoz+lilepoz
if zlpoz>17
  zlpoz=17
endif
if lilepoz=0
  do skom with "ENTER lub PgUp - wybor pozycji z magazynu    ESC - rezygnacja"
  set color to n/w,w/n
  keyboard chr(100)     &&Dopisz automatycznie
endif
dbedit(wiersz,1,18,78,q,"UD0","",w,,,chr(205))
close
select 10
use magazyn index mag_naz,mag_kod,mag_num
go drecno
RETURN

PROCEDURE UD0(tryb,numer)
local last:=lastkey(),lrazem:=0
local pole:=field(numer)
local pol:=&pole

do case
  case last=13
    do arazem
	return 0
    
  case last=75.or.last=107         &&Kasuj
   zz=.t.
   do gkom with "Usunac pozycje ??",zz
   if zz.and.lastkey()#27
     delete
	 pack
   endif
   keyboard chr(205)
   return 2   	
  case last=82.or.last=114         &&dRukuj
	do magazdruk with 9	
	keyboard chr(205)
	return 2	

	
  case last=68.or.last=100         &&Dopisz
    do skom with "ENTER lub PgUp - wybor pozycji z magazynu    ESC - rezygnacja"
    go bottom
    if zlpoz<wiersz+1
      zlpoz=wiersz+ztlp
    endif	
    set color to 
    do defwyp
    if lastkey()#27
      keyboard chr(100)
    else
      keyboard chr(205)
    endif	
    return 2

************
  case last=80.or.last=112                         &&Popraw  
  row=row()
  col=col()
  do mig with row,0,79
  set cursor on
  do case
    case numer=1
	  row=row()
	  save screen to ep
	  ltnaz=snazwa
      cena="M"
	  do mag with ltnaz,space(7),.t.
	  do magdefault
	  restore screen from ep
      select 11
	  if lastkey()=13		
	    zsnazwa=ztnaz
	    zskod=ztkod
	    zsilosc=silosc
	    zsjm=ztjm
	    zscena=ztcen
        set color to n/w,w/n	
	    @ row,2 say zsnazwa
	    @ row,37 say zskod
	    @ row,60 say zsjm
	    @ row,66 say zscena
        set color to
        do defreplac
      endif



  case numer=1.and.pierkod.and..not.ztmagazyn
    ztkod=tkod
	@ row,col get ztkod
    read
    if lastkey()#27
      replace tkod with ztkod
    endif		  	
	
  case numer=2.and.pierkod.and..not.ztmagazyn	 
	ztnaz=tnaz
	@row,col get ztnaz picture "@!@S28"
	read
    if lastkey()#27
      replace tnaz with ztnaz
    endif		  		
	


  case numer=5
     if cenbrut
	   ztcen=ROUND(ztcen*(1+ztstawka/100),2)
	 else
	   ztcen=ROUND(ztcen,2)
	 endif  
	 @ row,col get ztcen
	 read
	 if cenbrut
       ztcen=ROUND(ztcen/(1+ztstawka/100),4)
	 endif  
    if lastkey()#27
      replace tcen with ztcen
    endif		  
  case numer=6.and..not.substr(ztyp,4,1)$"A"
    @ row,col get ztstawka
	read
	if ztstawka=0
	  zz=.t.
      do gkom with "N - zerowa stawka VAT    T - towar zwolniony     ZWOLNIONY ?  [T/N] ",zz
      if lastkey()#27
	    if zz
	      replace tster with stuff(tster,1,1,"z")
		else
		  replace tster with stuff(tster,1,1," ")  
	    endif
	  endif	
	endif
	replace tstawka with ztstawka
	  
  otherwise
    @ row,col get pol
    read
    if lastkey()#27
      replace &pole with pol
    endif	
endcase

set cursor off 
do nmig with row,0,79
*do razem with 0
keyboard chr(205)
return 2


***********
  case last=27
    do arazem
    return 0
endcase
do arazem
do skom with "Dopisz   Popraw   Kasuj   dRukuj    ENTER - zatwierdz "
RETURN 1

PROCEDURE DEFWYP
local lmnaz:=space(32)
local ee:=savescreen(wiersz+3,0,17,79)
local ep,lnaz1
if zlpoz<17
  zlpoz=zlpoz+1
else
  restscreen(wiersz+2,0,16,79,ee)
endif
do while .t.
  do skom with "ENTER lub PgUp - wybor pozycji z magazynu      Esc-rezygnacja"
  set cursor on
  set color to n/w,w/n
  @ zlpoz,2 get lmnaz picture "@!"
  read
  set cursor off
  lnaz1=lmnaz
  do case
    case lastkey()=13.or.lastkey()=18
      save screen to ep
	  cena="M"
      do mag with lmnaz,space(7),.t.
      do magdefault
	  restore screen from ep
      select 11
	  if lastkey()=13		
	    do skom with "ENTER - zawierdzenie       ESC - rezygnacja"
	    zsnazwa=ztnaz
	    zskod=ztkod
	    zsilosc=1
	    zsjm=ztjm
	    zscena=ztcen
        set color to n/w,w/n	
	    @ zlpoz,2 say zsnazwa
	    @ zlpoz,37 say zskod
	    @ zlpoz,60 say zsjm
	    @ zlpoz,66 say zscena
		set cursor on
	    @ zlpoz,47 get zsilosc picture "9999999.99"
	    read
	    set cursor off
        if lastkey()=27
          zlpoz=zlpoz-1
          koniec=.t.
          restscreen(wiersz+3,0,17,79,ee)
          do askok
	      return
        endif
		set color to
		exit

	  else
	    lmnaz=lnaz1
	  endif  
	case lastkey()=27
      zlpoz=zlpoz-1
      koniec=.t.
      restscreen(wiersz+3,0,17,79,ee)
      do askok
	  return
  endcase
enddo  
append blank
do defreplac	  
do askok
*do arazem
RETURN

PROCEDURE DEFREPLAC
replace snazwa with ztnaz,skod with ztkod,silosc with zsilosc,sjm with ztjm
replace scena with ztcen,gnazwa with zgnazwa,gkod with zgkod
RETURN

PROCEDURE ASKOK
skok=14
ztlp=zlpoz-3
if ztlp>skok
  skip -(skok-1)
else
  skip -(ztlp-1)
endif   
RETURN

PROCEDURE ARAZEM
local lrazem:=0
local recno:=recno()
go top
do while.not.eof()
  lrazem=lrazem+silosc*scena
  skip
enddo  
go recno
set color to (coldef)
@ 19,53 say "RAZEM :"
@ 19,63 say lrazem picture " 999 999 999.99"
@ 21,2 say "Laczna wartosc czesci skladowych ......."
@ 22,2 say "Wynagrodzenie .........................."
@ 23,2 say "Wartosc magazynowa wyrobu gotowego ....."
@ 21,42 say lrazem picture "99 999 999.99"
if zmcen_p=0
  @ 22,42 say lrazem*zmrez/100 picture "99 999 999.99"
  @ 23,42 say lrazem*(1+zmrez/100) picture "99 999 999.99"
else
  @ 22,42 say zdmcen_p picture "99 999 999.99"
  @ 23,42 say lrazem+zdmcen_p picture "99 999 999.99"
endif
set color to n/w,w/n
    select 10
    use magazyn index mag_naz,mag_kod,mag_num
    go drecno    
	replace mcen_m with lrazem+mcen_p
	close
	select 11
RETURN


*******************************************************************************
* Procedura aktualizuje koszt produkcji wyrobu                                *
* Przcuje w selekcie 10 (otwarta baza magazynowa)                             *
*******************************************************************************
PROCEDURE WYRKOSZT
parameters pgnazwa,pgkod
local recno:=recno(),lkoszt:=0
local lsnazwa,lskod,lscena
select 20
use defin index def_gnaz
seek pgnazwa
if found()
  set filter to gnazwa=pgnazwa.and.gkod=pgkod
  go top
  do while.not.eof()
    lsnazwa=snazwa
	lskod=skod
	select 10
	seek lsnazwa
	if found()
	  do while mnaz=lsnazwa
	    if mkod=lskod
		  lscena=mcen_m
		  select 20
		  replace scena with lscena
		  exit
		endif
	    skip
	  enddo
	endif
	select 20
    skip
  enddo  
  go top
  do while.not.eof()
    lkoszt=lkoszt+silosc*scena
    skip
  enddo
  select 10
  go recno
  replace mcen_m with lkoszt+mcen_p
endif
select 20
close
select 10
go recno
RETURN  