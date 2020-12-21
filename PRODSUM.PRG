*******************************************************************************
* ANALIZA OBROTU TOWAROWEGO - HISTORIA TOWAROW                                *
*******************************************************************************
PROCEDURE HTMENU
parameters pmenu
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
drukar=.t.
hzakup=.f.       && rozgraniczenie wydruku dla zakupu i sprzedazy
w=0
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°       R A P O R T :  TOWAR - ZAKUP, SPRZEDAZ, ZYSK       °"
t[3]:= "°==========================================================°"
t[4]:= "°   PARAMETRY   ²    OKRES :                               °"
t[5]:= "°²²²²²²²²²²²²²²²²                                          °"
t[6]:= "° ZATWIERDZENIE ²                                          °"
t[7]:= "° 1. OKRES      ²                                          °"
t[8]:= "° 2. DOKUMENTY  ²                                          °"
t[9]:= "° 3. WYDRUK     ²                                          °"
t[10]:="°²²²²²²²²²²²²²²²²                                          °"
t[11]:="°               ²    DOKUMENTY :        WYDRUK :           °"
t[12]:="°               ²                                          °"
t[13]:="°               ²                                          °"
t[14]:="°               ²                                          °"
t[15]:="°               ²                                          °"
t[16]:="°               ²                                          °"
t[17]:="°               ²                                          °"
t[18]:="°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
g[1]:=" ZATWIERDZENIE "
g[2]:=" 1. OKRES      "
g[3]:=" 2. DOKUMENTY  "
g[4]:=" 3. WYDRUK     "
DK[1]:="ûÞ ZAKUP      "
DK[2]:="ûÞ SPRZEDAZ   "
DK[3]:="ûÞ RAZEM      "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
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
@ 14,32 to 18,47 double  
@ 14,51 to 17,65 double  
@ 15,33 say dk[1]
@ 16,33 say dk[2]
@ 17,33 say dk[3]
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
      if drukar
        @ 17,11 say "Trwa drukowanne" 
      else
        @ 17,11 say " Trwa analiza. " 
      endif	
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
	      lfiltr="max(fdat1-1,tdat)=tdat.and.min(fdat2,tdat)=tdat"
		  text2="ZA OKRES OD DNIA :                                                                           "          
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase
*************
      if.not.drukar
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say " Trwa analiza. " 
        delete file "\kj.txt"
        set printer to "\kj.txt"
      else
        do startrap with 1,ldruk
	    if.not.ldruk
          restore screen from ek
	      return
	    endif
        @ 16,11 say "   Czekaj !    "
        @ 17,11 say "Trwa drukowanne"   
      endif  
  
      set device to printer
      if drukar
        @ prow(),pcol() say &zdr_kond
      else
	    clear typeahead 
      endif	
      text1="* ANALIZA ZBIORCZA ZAKUPU I SPRZEDAZY TOWAROW *                                 "  
*       select 11
*	   close
*       use towbuf index towbuf
*       delete all
*       pack

      select 1
      if lsprzedaz
       *text1=" *_WYKAZ_TOWAROW_SPRZEDANYCH_*  "  
	    text1=" WYKAZ TOWAROW SPRZEDANYCH"  
        use sprzedaz
		index on tnaz to sp_naz
		use sprzedaz index sp_naz
		set filter to &lfiltr
	    go top
        do towdruk1
        close
      endif
  

      if lzakup	  
        *text1=" *_WYKAZ_TOWAROW_ZAKUPIONYCH *  "  
		text1=" WYKAZ TOWAROW ZAKUPIONYCH"  
		use zakup 
		index on tnaz to za_naz
		use zakup index za_naz
		set filter to &lfiltr
	    go top
        hzakup=.t.
		do towdruk1
		hzakup=.f.		
        close
      endif
  
      if lrazem
        *text1=" *_WYKAZ_TOWAROW_ZAKUPIONYCH_I_SPRZEDANYCH_*  "  
		text1=" WYKAZ TOWAROW ZAKUPIONYCH I SPRZEDANYCH "  
        copy file sprzedaz.dbf to razem.dbf
		select 51
		use zakup
		select 52
		use razem
		do rekplus
		select 51
		close
		select 52
		index on tnaz to zem_naz
		use razem index zem_naz
		set filter to &lfiltr
	    go top		
        do towdruk2
		close
        
	  endif    
  
      set printer to

      if.not.drukar
	    naz:="\kj.txt"
        do medit with naz
      endif  
      set device to screen	  
      restore screen from ekran
      @ 16,11 say "Koniec raportu!"
      @ 17,11 say "Esc->rezygnacja" 

    case s=2
      do anokres with 7,32,ls,lms,ld1,ld2,.F.
    case s=3
	  set cursor on
      d=1
      do while.t.
        d=achoice(15,33,17,46,dk,,,d)
		do case
		  case d=1
		    @ row(),46 get lzakup
			read
			if lzakup
			  dk[1]=stuff(dk[1],1,1,"û")
			else
			  dk[1]=stuff(dk[1],1,1," ")			  
			endif
		  case d=2
		    @ row(),46 get lsprzedaz
			read
			if lsprzedaz
			  dk[2]=stuff(dk[2],1,1,"û")
			else
			  dk[2]=stuff(dk[2],1,1," ")			  
			endif
		  case d=3
		    @ row(),46 get lrazem
			read
			if lrazem
			  dk[3]=stuff(dk[3],1,1,"û")
			else
			  dk[3]=stuff(dk[3],1,1," ")			  
			endif			
		  case d=0
		    exit
		endcase
	  enddo	
	  set cursor off
    case s=4
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
RETURN


PROCEDURE TOWDRUK1
local lp:=1
local lt1:="|...|................................|.......|..........|..........|..........|..........|..........|..........|..........|..........|"
local lt2:="|   |                                |       |          |          |          |          |          |          |          |          |"
local lt3:="--------------------------------------------------------------------------------------------------------------------------------------"
local lnazwa:=space(32)
local lkod:=space(12)
local lfaktury:=space(10)
local lrachunki:=space(10)
local lparagony:=space(10)
local lrazem:=space(10)
local lwartosc:=space(10)
local lcena:=space(10)
local lmarza:=space(10)
local lzysk:=space(10)
local lfak:=0
local lrach:=0
local lpar:=0
local lraz:=0
local lwar:=0
local lcen:=0
local lzys:=0
local lmar:=0
local lwarzak:=0
local lwarsum:=0
local lzyssum:=0
setprc(0,0)
w=prow()
do towglow1
do towtyt1						
go top
do while.not.eof()
  lnazwa=tnaz
  lkod=tkod
  lfak=0
  lrach=0
  lpar=0
  lwar=0
  lwarzak=0
  do while tnaz=lnazwa.and.tkod=lkod
	do case
      case substr(tndok,12,1)$"FUfu"
	    lfak=lfak+til
      case substr(tndok,12,1)$"RNr"
	    lrach=lrach+til
      case substr(tndok,12,1)$"PT"
	    lpar=lpar+til				
    endcase     
    lraz=lfak+lrach+lpar
	lwar=lwar+til*tcen
	lwarzak=lwarzak+til*tcen_m
    skip
  enddo
  skip -1
  lcen=round(lwar/lraz,2)
  lmar=round(((lwar-lwarzak)/lwarzak)*100,2)
  lzys=lwar-lwarzak  
  lwarsum=lwarsum+lwar
  lzyssum=lzyssum+lzys
 *   ltxsn=stuff("............",13-len(alltrim(str(lsnetto,12,2))),len(alltrim(str(lsnetto,12,2))),alltrim(str(lsnetto,12,2))) 
    lfaktury=stuff("..........",11-len(alltrim(str(lfak,10,2))),len(alltrim(str(lfak,10,2))),alltrim(str(lfak,10,2))) 
	lrachunki=stuff("..........",11-len(alltrim(str(lrach,10,2))),len(alltrim(str(lrach,10,2))),alltrim(str(lrach,10,2))) 
	lparagony=stuff("..........",11-len(alltrim(str(lpar,10,2))),len(alltrim(str(lpar,10,2))),alltrim(str(lpar,10,2))) 
	lrazem=stuff("..........",11-len(alltrim(str(lraz,10,2))),len(alltrim(str(lraz,10,2))),alltrim(str(lraz,10,2))) 
	lcena=stuff("..........",11-len(alltrim(str(lcen,10,2))),len(alltrim(str(lcen,10,2))),alltrim(str(lcen,10,2))) 
    lmarza=stuff("..........",11-len(alltrim(str(lmar,10,2))),len(alltrim(str(lmar,10,2))),alltrim(str(lmar,10,2))) 
    lwartosc=stuff("..........",11-len(alltrim(str(lwar,10,2))),len(alltrim(str(lwar,10,2))),alltrim(str(lwar,10,2)))  
    lzysk=stuff("..........",11-len(alltrim(str(lzys,10,2))),len(alltrim(str(lzys,10,2))),alltrim(str(lzys,10,2))) 
	
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,6,32,lnazwa)
	lt1=stuff(lt1,39,7,lkod)
	lt1=stuff(lt1,47,10,lfaktury)
	lt1=stuff(lt1,58,10,lrachunki)
	lt1=stuff(lt1,69,10,lparagony)
	lt1=stuff(lt1,80,10,lrazem)
	lt1=stuff(lt1,91,10,lcena)
	lt1=stuff(lt1,113,10,lwartosc)	
    if magpraw.and..not.hzakup
	  lt1=stuff(lt1,102,10,lmarza)
	  lt1=stuff(lt1,124,10,lzysk)
	endif  
    @ w,0 say lt1
    w=w+1
    lt1:="|...|................................|.......|..........|..........|..........|..........|..........|..........|..........|..........|"
  skip
  if w>dlugosc-4.and..not.eof().and.drukar
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
    do dzysktyt						
  endif
  lp=lp+1
enddo
  do towstopa1 with lwarsum,lzyssum
  if drukar
    eject
  else 
    w=0
    clear typeahead  
  endif  
RETURN


*******************************************************************************
* DRUKUJE NAGLOWEK RAPORTU : rodz dokumentu, okres ,od numeru do numeru       *
*******************************************************************************
PROCEDURE TOWGLOW1
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say replicate(chr(205),79)
  w=w+1
  @ w,0 say text2
  w=w+1
  @ w,0 say text3
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
    else
      @ prow(),pcol() say &zdr_kond
    endif  
  endif
  w=w+1
RETURN




PROCEDUR TOWTYT1
local lt1:="======================================================================================================================================"
local lt2:="|Lp.|   N A Z W A   T O W A R U      | K O D |             I   L   O   S   C             | SREDNIA  | SREDNIA  | WARTOSC  |   ZYSK   |"
local lt3:="|   |                                |       | FAKTURY  | RACHUNKI | PARAGONY |   RAZEM  |  CENA    |  MARZA   |  NETTO   |   NETTO  |"
local lt4:="|===|================================|=======|==========|==========|==========|==========|==========|==========|==========|==========|"
local lt5:="|   |                                |       |          |          |          |          |          |          |          |          |"
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


PROCEDURE TOWSTOPA1
PARAMETERS pwartosc,pzysk
local lt1:="|   |                                |       |          |          |          |          |          |          |          |          |"
local lt2:="=========================================================================================|=====================|==========|==========|"
local lt3:="                                                                                         |    R A Z E M  :     |          |          |"
local lt4:="                                                                                         ---------------------------------------------"
local lwartosc:=space(10)
local lzysk:=space(10)

lwartosc=stuff("..........",11-len(alltrim(str(pwartosc,10,2))),len(alltrim(str(pwartosc,10,2))),alltrim(str(pwartosc,10,2))) 
lzysk=stuff("..........",11-len(alltrim(str(pzysk,10,2))),len(alltrim(str(pzysk,10,2))),alltrim(str(pzysk,10,2))) 

lt3=stuff(lt3,113,10,lwartosc)
lt3=stuff(lt3,124,10,lzysk)

@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
if.not.drukar
  w=w+5
  @ w,0 say replicate(chr(42),138)
endif
RETURN




PROCEDURE TOWDRUK2
local lp:=1
local lt1:="|...|................................|.......|..........|..........|..........|..........|..........|..........|..........|..........|"
local lt2:="|   |                                |       |          |          |          |          |          |          |          |          |"
local lt3:="--------------------------------------------------------------------------------------------------------------------------------------"
local lnazwa:=space(32)
local lkod:=space(12)
local lzakup:=space(10)
local lsprzedaz:=space(10)
local lzcena:=space(10)
local lscena:=space(10)
local lzwartosc:=space(10)
local lswartosc:=space(10)
local lrilosc:=space(10)
local lrwartosc:=space(10)
local lzil:=0
local lsil:=0
local lzcen:=0
local lscen:=0
local lzwar:=0
local lswar:=0
local lril:=0
local lrwar:=0
local lzsum:=0
local lssum:=0
setprc(0,0)
w=prow()
do towglow1
do towtyt2						
go top
do while.not.eof()
  lnazwa=tnaz
  lkod=tkod
  lzil=0
  lsil=0
  lzwar=0
  lswar=0
  do while tnaz=lnazwa.and.tkod=lkod
	do case
      case substr(tndok,12,1)$"fr"
	    lzil=lzil+til
        lzwar=lzwar+til*tcen
      case substr(tndok,12,1)$"FURNPT"
	    lsil=lsil+til
		lswar=lswar+til*tcen
    endcase     
    skip
  enddo
  skip -1
  lzcen=round(lzwar/lzil,2)
  lscen=round(lswar/lsil,2)  
  lril=lzil-lsil
  lrwar=round(lzwar-lswar,2)
  lzsum=lzsum+lzwar
  lssum=lssum+lswar
 *   ltxsn=stuff("............",13-len(alltrim(str(lsnetto,12,2))),len(alltrim(str(lsnetto,12,2))),alltrim(str(lsnetto,12,2))) 
    lzakup=stuff("..........",11-len(alltrim(str(lzil,10,2))),len(alltrim(str(lzil,10,2))),alltrim(str(lzil,10,2))) 
	lsprzedaz=stuff("..........",11-len(alltrim(str(lsil,10,2))),len(alltrim(str(lsil,10,2))),alltrim(str(lsil,10,2))) 
	lzcena=stuff("..........",11-len(alltrim(str(lzcen,10,2))),len(alltrim(str(lzcen,10,2))),alltrim(str(lzcen,10,2))) 
	lscena=stuff("..........",11-len(alltrim(str(lscen,10,2))),len(alltrim(str(lscen,10,2))),alltrim(str(lscen,10,2))) 
	lzwartosc=stuff("..........",11-len(alltrim(str(lzwar,10,2))),len(alltrim(str(lzwar,10,2))),alltrim(str(lzwar,10,2))) 
    lswartosc=stuff("..........",11-len(alltrim(str(lswar,10,2))),len(alltrim(str(lswar,10,2))),alltrim(str(lswar,10,2))) 
    lrilosc=stuff("..........",11-len(alltrim(str(lril,10,2))),len(alltrim(str(lril,10,2))),alltrim(str(lril,10,2)))  
    lrwartosc=stuff("..........",11-len(alltrim(str(lrwar,10,2))),len(alltrim(str(lrwar,10,2))),alltrim(str(lrwar,10,2))) 
	
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,6,32,lnazwa)
	lt1=stuff(lt1,39,7,lkod)
	lt1=stuff(lt1,47,10,lzakup)
	lt1=stuff(lt1,58,10,lzcena)
	lt1=stuff(lt1,69,10,lzwartosc)
	lt1=stuff(lt1,80,10,lsprzedaz)
	lt1=stuff(lt1,91,10,lscena)
    lt1=stuff(lt1,102,10,lswartosc)
	lt1=stuff(lt1,113,10,lrilosc)	
    lt1=stuff(lt1,124,10,lrwartosc)
    @ w,0 say lt1
    w=w+1
    lt1:="|...|................................|.......|..........|..........|..........|..........|..........|..........|..........|..........|"
  skip
  if w>dlugosc-4.and..not.eof().and.drukar
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
      do towglow1
      do towtyt2						
  endif
  lp=lp+1
enddo
  do towstopa2 with lzsum,lssum
  if drukar
    eject
  else 
    w=0
    clear typeahead  
  endif  
RETURN


PROCEDUR TOWTYT2
local lt1:="======================================================================================================================================"
local lt2:="|Lp.|   N A Z W A   T O W A R U      | K O D |         Z  A  K  U  P          |      S  P  R  Z  E  D  A  Z    |   (ZAKUP-SPRZEDAZ)  |"
local lt3:="|   |                                |       |  ILOSC   | CENA SR. | WARTOSC  |  ILOSC   | CENA SR. | WARTOSC  |  ILOSC   |  WARTOSC |"
local lt4:="|===|================================|=======|==========|==========|==========|==========|==========|==========|==========|==========|"
local lt5:="|   |                                |       |          |          |          |          |          |          |          |          |"
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


PROCEDURE TOWSTOPA2
PARAMETERS pzakup,psprzedaz
local lt1:="|   |                                |       |          |          |          |          |          |          |          |          |"
local lt2:="===================================================================|==========|==========|==========|==========|==========|==========|"
local lt3:="                                             |    R A Z E M  :     |          |                     |          |          |          |"
local lt4:="                                             -----------------------------------------------------------------------------------------"
local lzakup:=space(10)
local lsprzedaz:=space(10)
local lroznica:=space(10)
local lroz:=pzakup-psprzedaz

lzakup=stuff("..........",11-len(alltrim(str(pzakup,10,2))),len(alltrim(str(pzakup,10,2))),alltrim(str(pzakup,10,2))) 
lsprzedaz=stuff("..........",11-len(alltrim(str(psprzedaz,10,2))),len(alltrim(str(psprzedaz,10,2))),alltrim(str(psprzedaz,10,2))) 
lroznica=stuff("..........",11-len(alltrim(str(lroz,10,2))),len(alltrim(str(lroz,10,2))),alltrim(str(lroz,10,2))) 

lt3=stuff(lt3,69,10,lzakup)
lt3=stuff(lt3,102,10,lsprzedaz)
lt3=stuff(lt3,124,10,lroznica)

@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
w=w+1
@ w,0 say lt4
w=w+1
if.not.drukar
  w=w+5
  @ w,0 say replicate(chr(42),138)
endif
RETURN
