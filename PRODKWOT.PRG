local t[2]
public NM[100],MM[100],UM[100]
t[1]:="PRODUKTY"
t[2]:="SUROWCE"
wmagil=99
for i=1 to wmagil
  NM[i]:=space(15)
  MM[i]:=space(15)
  UM[i]:=space(15)
next
do mdef
grafik=.t.
clear
select 1
set default to 1dok
use mmdok
set device to printer
set printer to "\kjplik.prn"
s=achoice(10,35,11,42,t)
do case
  case s=1
    do prod_01_kwot
  case s=2
    do prod_03_kwot	
endcase
return

PROCEDURE PROD_01_KWOT
local lt1:="|   |                 |                                      |                 |"
local lkwota,lrazem:=0
text1="PODSUMOWANIE PRODUKCJI W CENACH SREDNICH ZUZYTYCH SUROWCOW  -  WYROBY GOTOWE"
w=prow()
do prodglowkwot
do prod_kwottyt
for i=2 to wmagil
  set filter to tnkon=i.AND.substr(tkod,1,2)="01"
  go top
    sum round(til*tcen,2) to lkwota  
  lrazem=lrazem+lkwota
  lt1=stuff(lt1,2,3,str(i-1,3))
  lt1=stuff(lt1,7,15,nm[i])
  lt1=stuff(lt1,25,15,mm[i])
  lt1=stuff(lt1,44,15,um[i])
  lt1=stuff(lt1,64,15,str(lkwota,15,2))
  if lkwota#0
    w=w+1
    @ w,0 say lt1
  endif	
next
do prod_kwotstopa with lrazem
eject
RETURN

PROCEDURE PROD_03_KWOT
local lt1:="|   |                 |                                      |                 |"
local lkwota,lrazem:=0
text1="PODSUMOWANIE PRODUKCJI W CENACH SREDNICH ZUZYTYCH SUROWCOW  -  SUROWCE"
w=prow()
do prodglowkwot
do prod_kwottyt
for i=2 to wmagil
  set filter to tnkon=i.AND.(substr(tkod,1,2)="02".or.substr(tkod,1,2)="03")
  go top
    sum round(til*tcen,2) to lkwota  
  lrazem=lrazem+lkwota
  lt1=stuff(lt1,2,3,str(i-1,3))
  lt1=stuff(lt1,7,15,nm[i])
  lt1=stuff(lt1,25,15,mm[i])
  lt1=stuff(lt1,44,15,um[i])
  lt1=stuff(lt1,64,15,str(lkwota,15,2))
  if lkwota#0
    w=w+1
    @ w,0 say lt1
  endif	
next
do prod_kwotstopa with lrazem
eject
RETURN



PROCEDURE PRODGLOWKWOT
text1="PODSUMOWANIE PRODUKCJI W CENACH SREDNICH ZUZYTYCH SUROWCOW"
*  if drukar
    if grafik
      @ prow(),pcol() say &zdr_grubo+&zdr_kkond
    else
      @ prow(),pcol() say &zdr_kkond
    endif
*  endif
  @ w,0 say text1
  w=w+1
  @ w,0 say "======================="
  w=w+1
*  @ w,0 say text2
*  w=w+1
*  @ w,0 say text3
*  if drukar
*    if grafik
*      @ prow(),pcol() say &zdr_kgrubo	
*    endif  
*  endif
*  w=w+1
RETURN





PROCEDURE PROD_KWOTSTOPA
parameters prazem
local lt1:="-------------------------------------------|-----------------|-----------------|"
local lt2:="                                           |   R A Z E M  :  |                 |"
local lt3:="                                           -------------------------------------"
lt2=stuff(lt2,64,15,str(prazem,15,2))
w=w+1
@ w,0 say lt1
w=w+1
@ w,0 say lt2
w=w+1
@ w,0 say lt3
RETURN

PROCEDURE PROD_KWOTTYT
local lt1:="================================================================================"
local lt2:="|Lp.|    N A Z W A    |              A  D  R  E  S           |    K W O T A    |"
local lt3:="|   |    MAGAZYNU     |    MIASTO      /      ULICA          |    N E T T O    |"
local lt4:="|===|=================|======================================|=================="
local lt5:="|   |                 |                                      |                 |"
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


