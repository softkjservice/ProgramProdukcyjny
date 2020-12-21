local ek,ek1,t[3]
local index:=.f.
t[1]:=" DOKUMENTY    "
t[2]:=" MAGAZYNY     "
t[3]:=" WSZYSTKO     "
*save screen to ek
zz=.f.
s=1
@ 11,47 to 15,63 double 
s=achoice(12,48,14,62,t,,,s)
do case
  case s=1
    do gkom with "UWaga !  Wszystkie dokumenty zostana usuniete. Zatwierdzic ?  [T/F] ",zz
    if zz.and.lastkey()#27
	  do zerdok
      do zernum
	  index=.t.
      zz=.f.
	  do gkom with "Usunac baze pracownikow ?  [T/F] ",zz
	  if zz.and.lastkey()#27
	    zz=.f.
	    do gkom with "Uwaga !  Baza pracownikow zostanie usunieta.  Zatwierdzic ?  [T/F] ",zz
	    if zz.and.lastkey()#27
	      do zerprac
	    endif	
	  endif	  
	endif  

  case s=2
    zz=.f.
	do gkom with "Uwaga!  Wszystkie pozycje magazynowe zostana usuniete.  Zatwierdzic?  [T/F]",zz
    if zz.and.lastkey()#27
	  do zermag
      index=.t.
	endif  
  case s=3
    zz=.f.
	do gkom with "Uwaga !  Wszystkie pozycje zostana usuniete.  Zatwierdzic ?  [T/F] ",zz 
    if zz.and.lastkey()#27
	  do zerdok
	  do zernum
	  do zerprac
	  do zermag
	  index=.t.
	endif  
endcase
if index
  do magindex
endif  
return

PROCEDURE ZERDOK
do dokdefault
select 1
use przerob
zap
use mmdok
zap
rdnum=0
save to pam
close
RETURN

PROCEDURE ZERMAG
select 1
for i=1 to wmagil
  do pmagdefault with i
  use asortym
  zap
  use magazyn
  zap
  use opis
  zap
  if file("bo.dbf")
    use bo
    zap
  endif	
  use mpam
  replace mnumer with 0,mdex with 0,magnum with i,msprzedaz with .f.
  replace mszukaj with .f.,mlog1 with .f.,mlog2 with .f.,mlog3 with .f.
  close
next  
RETURN

PROCEDURE ZERKON
select 1
do kondefault
use trah
zap
use kontrah
zap
use odebral
zap
close
RETURN

PROCEDURE ZERPRAC
select 1
do pracdefault
use pracow
zap
use wnik
zap
close
RETURN

PROCEDURE ZERNUM
local ek
save screen to ek
@ 12,13 to 16,47 double 
@ 13,14 say " Numer ostatnio zarejestrowanego "
@ 14,14 say "                                 "
@ 15,14 say " PRZEROBU.........               "
use dpam
set cursor on
@ 15,32 get dnumprzer
read
set cursor off
close
RETURN