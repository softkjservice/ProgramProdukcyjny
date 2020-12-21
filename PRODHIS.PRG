*******************************************************************************
* ANALIZA PRZEROBU                                                            *
*******************************************************************************
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
public zmagazyn:=0
drukar=.t.
hzakup=.f.       && rozgraniczenie wydruku dla zakupu i sprzedazy
w=0
t[1]:= "°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
t[2]:= "°            R A P O R T   P R O D U K C Y J N Y           °"
t[3]:= "°==========================================================°"
t[4]:= "°   PARAMETRY   ²    OKRES :                               °"
t[5]:= "°²²²²²²²²²²²²²²²²                                          °"
t[6]:= "° ZATWIERDZENIE ²                                          °"
t[7]:= "° 1. OKRES      ²                                          °"
t[8]:= "° 2. MAGAZYN    ²                                          °"
t[9]:= "° 3. WYDRUK     ²                                          °"
t[10]:="°²²²²²²²²²²²²²²²²                                          °"
t[11]:="°               ²    NR MAGAZYNU        WYDRUK :           °"
t[12]:="°               ²         0                                °"
t[13]:="°               ²                                          °"
t[14]:="°               ²                                          °"
t[15]:="°               ²                                          °"
t[16]:="°               ²                                          °"
t[17]:="°               ²                                          °"
t[18]:="°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°"
g[1]:=" ZATWIERDZENIE "
g[2]:=" 1. OKRES      "
g[3]:=" 2. MAGAZYN    "
g[4]:=" 3. WYDRUK     "

DK[1]:=" NR MAGAZYNU  "
DK[2]:="       0      "
DK[3]:="0 = WSZYSTKIE "
WD[1]:="ûÞ DRUKARKA  "
WD[2]:=" Þ EKRAN     "
text2=space(70)
text3=space(70)
save screen to ek
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
    if zmagazyn=0
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
	else
      do case
        case ls=1                       &&raport za dzien
	      lfiltr="tdat=fdat1.and.tntrah=zmagazyn"
		  text2="ZA DZIEN  :                            MAGAZYN :                                             "          
          text2=stuff(text2,50,3,str(zmagazyn,3))
          text2=stuff(text2,15,8,dtoc(ld1))          		  
	    case ls=2                       &&raport  za miesiac
	      lfiltr="month(tdat)=fmies.and.tntrah=zmagazyn"
          do miesiac with lms,lmiesiac
		  text2="ZA MIESIAC :                           MAGAZYN :                                             "          
          text2=stuff(text2,50,3,str(zmagazyn,3))
          text2=stuff(text2,15,12,lmiesiac)          		
        case ls=3                       &&za okres od do
	      lfiltr="max(fdat1-1,tdat)=tdat.and.min(fdat2,tdat)=tdat.and.tntrah=zmagazyn"
		  text2="ZA OKRES OD DNIA :                     MAGAZYN :                                             "          
          text2=stuff(text2,50,3,str(zmagazyn,3))
		  text3="         DO DNIA :                                                                           "          		  
          text2=stuff(text2,19,8,dtoc(ld1))          		  
          text3=stuff(text3,19,8,dtoc(ld2))          		  		  
      endcase	
	endif  
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
      text1="ANALIZA PRODUKCJI                                                               "  

      select 1
        use mmdok
		index on tnaz + tkod to sp_naz
		use mmdok index sp_naz
		set filter to &lfiltr
	    go top
        do proddruk
        close
  
  
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
      @ 16,38 get zmagazyn PICTURE "999"
      read
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


PROCEDURE PRODDRUK
local lp:=1
local lt1:="|   |                                |       |               |               |"
local lt2:="|   |                                |       |               |               |"
local lt3:="------------------------------------------------------------------------------"
local lnazwa:=space(32)
local lkod:=space(12)
local lcen_m:=0,lilosc:=0,lwartosc:=0,lwarsum:=0
setprc(0,0)
w=prow()
do prodglow
do prodtyt		
do while.not.eof()
  lnazwa=tnaz
  lkod=tkod
  lilosc=0
  lwartosc=0
  do while tnaz=lnazwa.and.tkod=lkod
    lilosc=lilosc+til
	lwartosc=lwartosc+round(til*tcen_m,2)
    skip
  enddo
  skip -1
  lwarsum=lwarsum+lwartosc
    lt1=stuff(lt1,2,3,str(lp,3))
    lt1=stuff(lt1,6,32,lnazwa)
	lt1=stuff(lt1,39,7,lkod)
	lt1=stuff(lt1,47,15,str(lilosc,15,2))
	lt1=stuff(lt1,63,15,str(lwartosc,15,2))
    @ w,0 say lt1
    w=w+1
    lt1:="|   |                                |       |               |               |"
  skip
  if w>dlugosc-4.and..not.eof().and.drukar
    stro=.t.
    @ w,0 say lt3
	strona=strona+1
	  @ w+3,7 say "Ciag dalszy dokumentu - PATRZ STRONA :"
      @ w+3,pcol() say strona picture "999"
      eject
	  w=prow()
    do prodtyt						
  endif
  lp=lp+1
enddo
  do prodstopa with lwarsum
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
PROCEDURE PRODGLOW
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say "======================="
  w=w+1
  @ w,0 say text2
  w=w+1
  @ w,0 say text3
  if drukar
    if grafik
      @ prow(),pcol() say &zdr_kgrubo	
*      @ prow(),pcol() say &zdr_kgrubo+&zdr_kond
*    else
*      @ prow(),pcol() say &zdr_kond
    endif  
  endif
  w=w+1
RETURN




PROCEDUR PRODTYT
local lt1:="=============================================================================="
local lt2:="|Lp.|   N A Z W A   W Y R O B U      | K O D |     ILOSC     |     LACZNA    |"
local lt3:="|   |                                |       | WYPRODUKOWANA | W A R T O S C |"
local lt4:="|===|================================|=======|===============|===============|"
local lt5:="|   |                                |       |               |               |"
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


PROCEDURE PRODSTOPA
PARAMETERS pwartosc
local lt1:="|   |                                |       |               |               |"
local lt2:="=============================================|===============|===============|"
local lt3:="                                             |  R A Z E M  : |               |"
local lt4:="                                             ---------------------------------"
lt3=stuff(lt3,63,15,str(pwartosc,15,2))
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