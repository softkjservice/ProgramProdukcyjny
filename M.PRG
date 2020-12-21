*PROCEDURE : TL,TXT,TX,OK1-OK5,KONTO,ROZ,MOP1-MOP5,KONTRAH,KONTTLO,KONTTLO1
*KSEGA
local s:=1
local last:=lastkey()

*   #include "button.ch"
*   #include "inkey.ch"

*   SET( _SET_EVENTMASK, INKEY_ALL )
*   MSETCURSOR(.T.)

set century on
set procedure to firma
set procedure to kjproc
set procedure to dokum
set procedure to mag
set procedure to ksdruk
set key -9 to robak
set delete on
*set procedure to przerob
set confirm on
set date german
*set bell on 
druk_public()
public zkas_margin:=0
public sh_mini:=.f.,kr_mini:=.f.
public m_katalog:=space(30),k_katalog:=space(30),dok_archiw:=space(30)
public minus_mag:=.f.
public fis_druk:=.f.,fis_com:=1016
public par_skrocony:=.f.
public zwaluta1:="ZL.  ",zwaluta2:="GR.  "
public wlasny1:=.f.     &&parametr wlasny - jesli .t. to faktury tylko z haslem wyszym
public wlasny2:=.f.,wlasny3:=.f.,wlasny4:=.f.,wlasny5:=.f.,wlasny6:=.f.
public wlasny7:=.f.,wlasny8:=.f.,wlasny9:=.f.,wlasny10:=.f.,wlasny11:=.f.
public wlasny12:=.f.,wlasny13:=.f.,wlasny14:=.f.,wlasny15:=.f.,wlasny16:=.f.
public wlasny17:=.f.,wlasny18:=.f.,wlasny19:=.f.,wlasny20:=.f.,wlasny21:=.f.
public gonful:=.f.       &&.t.-paragon traktowany jak faktura i rachunek
public rdnum:=0         &&numer raportu dziennego
public rdsporzadzil:=space(30)     &&sporzadzil raport dzienny
public rdzatwierdzil:=space(30)    &&zatwierdzil raport dzienny
public rdmiasto:=space(20)         
public opdat:=.t.
public asmenpar:=.f.    &&.T.-wejscie do magazynu poprzez okno wyboru asortymrntu rowniez z poziomu dokumentu
public wyboras:=.f.     &&.T.-wejscie do magazynu poprzedza wybor asortymentu
public sasiad:=.f.
public korekta:=.f.
public cendet:=.t.
public zkon:=space(60)
public znkon:=1
public trah:=.t.
public dm:=1
public help:=space(12)
public coldef:="W/N,N/W,N,N,N/W)"
public kolor:=0
public kjhas:="kjhas1957"
public dokexport:=.f.
public drukarka:="LPT1"
public oferil:=.f.
public zryczalt:=.f.
public plik:="\kjdruk.prn"
public ryczalt:=.f.
public odstep:=.f.
public dlugosc:=57
public dtxt1:=space(62)
public dtxt2:=space(62)
public dtxt3:=space(72)
public dtxt4:=space(72)
public dtxt5:=space(72)
public szybki:=.f.
public mocny:=.t.
public grafik:=.t.
public swektor:="chr(27)+chr(73)+chr(0)+chr(27)+chr(77)+chr(27)+chr(67)+chr(0)+chr(12)+chr(27)+chr(67)+chr(72)+chr(18)                                                                                                                                                                                                      "
public mwektor:="chr(27)+chr(77)+chr(27)+chr(67)+chr(0)+chr(12)+chr(27)+chr(67)+chr(72)+chr(18)                                                                                                                                                                                                                             "
public wektor:=mwektor
public plikdruk:=.f.
public wzdruk:=.f.
public pzdruk:=.f.
public lpt15:=.f.
public pksiega:=.f.
public mnoz:=1.00000000
public daf:=date()  && data obowiazujaca

*********************** Zmienne instalacyjne
public fwl:=space(33)
public flic1:=space(24)
public flic2:=space(24)
public flic3:=space(24)
public flic4:=space(24)
public flic5:=space(24)
public flic6:=space(24)
public fdys1:=space(34)
public fdys2:=space(34)
public vat:=.t.
public wmag:=.f.           &&.t.-mozliwosc korzystania z wielu magazynow
public wmagil:=4
public mag_lic:=.f.
public wersja:=1
public wersjatxt:="__"
public vvt:=.t.
public datdem:=date()
public demczas:=14
public stanowisko:="A"
public NumStan:=0
public NumKas:=1
public ParamOkno:=.t.
public Sklep:=.f.             &&.t.-cena_d i _h w magazynie deklarowane brutto 
public kasa:=.f.
public pierkod:=.f.

*********************** zmienne ustalajace numeracje 
public nummag:=0
public znummag:=0
public numplat:=0
public znumplat:=0
public numfakt:=0
public numrach:=0
public numpar:=0
public numzlec:=0
public numpz:=0
public numzwrot:=0
public numrek:=0
public numprzer:=0
public numprac:=0
public num1dzy:=0
public num2dzy:=0
public znfakt:=0
public ksiegakon:=.f.
************************Zmienne - nowy dokument
public ztyp:=space(4)
public zndok:=space(15)
public zzewndok:=space(15)
public zdatdok:=daf  
public znskrot:=space(15)
public zwartosc:=0  
public zwar:=0
public znplat:=0
public znzamow:=space(15) 
public ztermin:=daf+14
public zdatzap:=daf
public zkonto:=0
public zkwota:=0
public zksiegowy:=.f.
public zsposzap:=space(1)
public zdatsp:=daf
public zdatzal:=daf
public ztransport:=space(20)
public zdster:=space(3)
public zopis:=space(16)
public zdnet_22:=0
public zdnet_07:=0
public zdnet_00:=0
public zdnet_zw:=0
public opis_dok:=space(16)
*******************Zmienne - opis kontrahentow
public znaz1:=space(30)
public znaz2:=space(30)
public zmiasto:=space(30)
public zulica:=space(30)
public zkod:=space(6)
public ztel:=space(15)
public znip:=space(13)
public zfax:=space(15)
public zpager:=space(15)
public zkkonto:=space(40)
public zkontrahkonto:=space(29)
public zgrupa:=space(5)
public znskrot:=space(15)
public zrabat:=0.0
public zdrabat:=0.0
public znr_kontr:=0

*******************Zmienne magazyn
public zmnaz:=space(32)
public zmil:=0
public zmcen_d:=0
public zmcen_h:=0
public zmcen_m:=0
public zmrez:=0
public zmkod:=space(7)
public zmjm:=space(3)
public zmdata:=date()
public zmagaz:=0
public znmag:=0
public zmstawka:=0
public zmsymbol:=space(10)
public zmmarza_d:=0
public zmmarza_h:=0
public zmwaluta:=space(1)
public zmster:=space(3)
public zmcen_p:=0
public zmdokzak:=space(15)
public zmntrah:=0
public zmilpom:=0
public zmilsum:=0
public zmindex:=0
public zmagnum:=0

******************Zmienne - nowy pracownik
public rindex:=0
public rnazwisko:=space(20)
public rimie1:=space(15)
public rimie2:=space(15)
public rplaca:=0
public rurlop:=1            &&rurlop przechowuje informacje o numerze magazynu 
******************Zmienne - nowa pozycja rejestrowana w dokumentach
public ztlp:=0
public ztnaz:=space(32)
public ztil:=1.00
public ztcen:=0.00
public ztwar:=0.00
public ztkod:=space(7)
public ztmagazyn:=.t.
public ztndok:=space(15)
public ztjm:=space(3)
public ztsymbol:=space(15)
public ztstawka:=0
public ztcen_m:=0
public ztcen_d:=0
public ztcen_h:=0
public ztcen_p:=0
public ztnkon:=0
public ztster:=space(3)
public ztdat:=daf
public ztnmag:=0
public ztmagnum:=0
public ztntrah:=0
public ztzewndok:=space(15)
*public ztwartbp:=0
*public ztvat:=0
public ztprac:=0
public ztindex:=0
public ztdokzak:=space(15)
public ztntrah:=0

********************** pozostale zienne
public zodebnaz:=space(30)
public zodebnum:=0
public zpracnaz:=space(30)
public zanuldok:=.f.
public hel:="faktura"    && okresla tekst w procedurze HELP
public fwar:=".t."      && wyk. przy ustawianiu filtru
public fwar1:=""
public cen:=1
public cena:="D"
public anul:=.f.
public licencja:=.t.
public asmenu:=.f.       &&czy utworzono menu asortymentowe
public aspoz:=.f.        &&czy istnieje podzial asortymentowy
public marza_d:=0      &&ostatnio stosowana marza detaliczna
public marza_h:=0        &&                         hurtowa
public MagPraw:=.t.
public Orginal:=0
public kont:=.f.              &&kontrahent odszukany lub zapisz nowego
public rekon:=.f.
public zmientyt:=.f.
public ms:=1                   &&miesiac do drukowania
public zpracnum:=0

*********************** zmienne parametry
public dysk:="A:\"        && stacja dyskow do archiwizacjie
public margines:=0
public haslo:=space(10)
public shaslo:=space(10)
public papfir:=.f.       &&czy drukowac na papierze firmowym
public mzao:=0
public pammiasto:=space(19)
public rachuntyp:=2
public fakturtyp:=1
public paragtyp:=2
public przestyp:=1
public wztyp:=1
public pztyp:=1
public OpoznionaPlatnosc:=14
public ktm:=.f.

****************************************ZMIENNE - WERSJA PROGRAMU
public in1:=.f.
public in2:=.f.
public in3:=.f.
public in4:=.f.
public in5:=.f.
public in6:=.f.
public in7:=.f.
public in8:=.f.
public in9:=.f.
public in10:=.f.
public in11:=.f.
public in12:=.f.
public in13:=.f.
public in14:=.f.
public in15:=.f.
public in16:=.f.
public in17:=.f.
public in18:=.f.
public in19:=.f.
public in20:=.f.
public in21:=.f.
public in22:=.f.
public in23:=.f.
public in24:=.f.
public in25:=.f.
public in26:=.f.
public in27:=.f.
public in28:=.f.
public in29:=.f.
public in30:=.f.
public in31:=.f.
public in32:=.f.
public in33:=.f.
public in34:=.f.
public in35:=.f.
public in36:=.f.
public in37:=.f.
public in38:=.f.
public in39:=.f.
public in40:=.f.
public in41:=.f.
public in42:=.f.
public in43:=.f.
public in44:=.f.
public in45:=.f.
public in46:=.f.
public in47:=.f.
public in48:=.f.
public in49:=.f.
public in50:=.f.
public in51:=.f.
public in52:=.f.
public in53:=.f.
public in54:=.f.
public in55:=.f.
public in56:=.f.
public in57:=.f.
public in58:=.f.
public in59:=.f.
public in60:=.f.
public in61:=.f.
public in62:=.f.
public in63:=.f.
public in64:=.f.
public in65:=.f.
public in66:=.f.
public in67:=.f.
public in68:=.f.
public in69:=.f.
public in70:=.f.
public in71:=.f.
public in72:=.f.
public in73:=.f.
public in74:=.f.
public in75:=.f.
public in76:=.f.
public in77:=.f.
public in78:=.f.
public in79:=.f.
public in80:=.f.

****************************************DEFINICJA NAZW MAGAZYNOW
public NM[100],MM[100],UM[100]
public znm:=space(15)
public zmm:=space(15)
public zum:=space(15)
sh_firma=.f.
m_firma=.f.
p_firma=.t.
kr_firma=.f.
for i=1 to wmagil
  NM[i]:=space(15)
  MM[i]:=space(15)
  UM[i]:=space(15)
next
dostep=.t.
wek1="chr(27)+chr(15)"
wek2="chr(18)"
tlo=chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)+chr(176)
*set default to bazy

if.not. file ("pam.mem")
  @ 0,0,24,79 box tlo
  @ 10,18 say "                                            "  
  @ 11,18 say " PROGRAM NIE ZOSTAL POPRAWNIE ZAINSTALOWANY "
  @ 12,18 say "         Nacisnij dowolny klawisz           "
  @ 13,18 say "                                            "  
  inkey(0)
  clear
  return
endif

restore from pam additive
if in47             &&musi wybrac odpowiedni katalog dokumentow
  NumKas=NumStan
endif  
do dokdefault
restore from pam additive
*
set default to leg01
if file("drukarki.dbf")
  if kj_use("drukarki",.f.,3)
    locate for dr="*"
	if.not.found()
	  go top
	endif
    druk_lad()	
    use
  endif
endif
do dokdefault
*

sh_firma=.f.
m_firma=.f.
p_firma=.t.
kr_firma=.f.
shfirma=sh_firma
mfirma=m_firma
pfirma=p_firma
krfirma=kr_firma
public rurlop:=0 
ksiegakon=.f.
if.not.vvt
  fakturtyp=2
  rachuntyp=2
  paragtyp=2
endif
pksiega=.f.
set color to (coldef)
help="menu"
do nstan

*magil=4
do mdef
*do defkonto
do tl
@ 2,17 say "          P  R  O  D  U  K  C  J  A           "

if.not.p_lic
  do blokada
  if.not.licencja
    return
  endif  
endif
set color to
do haslo with 10,25 
if.not.dostep
  clear
  return
endif  
keyboard chr(205)
daf:=date()  && data obowiazujaca
fwar=".t."
rekon=.f.
save to pam
hel="magazyn"
use
pozm=1
do while .t.
  zm=.f.
 * do menu      &&jesli koniec - zm=.t.
  do fmenu
  if zm
    exit
  endif	
enddo
clear
return

