*******************************************************************************
* Procedury z pliku tow.prg dotyczace tylko czesci P_FIRMA                    *
*******************************************************************************

PROCEDURE ASAYPOZ
@ 21,1 clear to 23,78
@ 21,1 say " Nazwa..                                .    ILOSC............                "
@ 22,1 say " Jednostka..........                         W A R T O S C :                  "
@ 23,1 say " Placa jednostkowa..                                                          "
@ 21,9 say ztnaz
@ 22,21 say ztjm
@ 23,21 say ztcen picture "99,999,999.99"
@ 21,63 say ztil picture "9,999,999"
@ 22,63 say ztwar picture "999,999,999,999"
RETURN


*******************************************************************************
*Procedura wypelniajaca przerobione pozycje - wspolpracuje z TOW.PRG
******************************************************************************* 
PROCEDURE APOZWYP
parameters pnowa
local naz:=space(32)
local ltnaz:=ztnaz
local ltkod:=ztkod
local ltcen:=ztcen
local ltjm:=space(3)
set color to
do asaypoz
do while .t.
ztmagazyn=.f.
  do while .t.
  do skom with "PgUp - wybor pozycji z magazynu    Enter - zatwierdzenie    Esc-rezygnacja"
    zz=.t.
    set color to (n/w,w/n)
	set cursor on
    @ 21,9 get ztnaz picture "@!"
    read	
    naz=stuff(naz,1,len(ztnaz),ztnaz)
 	set cursor off
	do case 
		
      case lastkey()=18
        save screen to ep
        ltnaz=ztnaz
		do mag with ltnaz
	    restore screen from ep
        select 11
		if lastkey()=13		
          set color to
          ztwartbp=ztkoszt*100
          do asaypoz
		  ztmagazyn=.t.
          exit
        else
		  ztnaz=naz
		endif 
		
	  case lastkey()=13              && Zapamietanie pozycji bez magazynu
        set color to
		exit

	  case lastkey()=27
        do gkom with "Przerwac edycje pozycji ? [Y/F] ",zz
	    if zz
          ztlp=ztlp-1
          koniec=.t.
	      return
	    endif    
      case lastkey()=3
        ztnaz=naz
	    kod=.f.
		exit
	endcase  
  enddo             && koniec wprowadzania nazwy

  do skom with "   Enter - zatwierdzenie             Esc-rezygnacja"


if.not.ztmagazyn
  do while .t.
    zz=.t.
    set color to (n/w,w/n)
	set cursor on
    @ 22,21 get ztjm picture "@!"
    read	
 	set cursor off
	do case 
		
      case lastkey()=18
        save screen to ep
        ltnaz=ztnaz
		do mag with ltnaz
	    restore screen from ep
        select 11
		if lastkey()=13		
          set color to
          ztwartbp=ztkoszt*100
          do asaypoz
		  ztmagazyn=.t.
          exit
        else
		  ztnaz=naz
		endif 
		
	  case lastkey()=13              && Zapamietanie pozycji bez magazynu
        set color to
		exit

	  case lastkey()=27
        do gkom with "Przerwac edycje pozycji ? [Y/F] ",zz
	    if zz
          ztlp=ztlp-1
          koniec=.t.
	      return
	    endif    
      case lastkey()=3
        ztnaz=naz
	    kod=.f.
		exit
	endcase  
  enddo             && koniec wprowadzania nazwy
endif

if.not.ztmagazyn
  do while .t.
    zz=.t.
	@ 23,21 say space(15)	
    set color to (n/w,w/n)
	set cursor on
    @ 23,21 get ztkoszt picture "99999999.99"
    read	
 	set cursor off
	do case 
		
      case lastkey()=18
        save screen to ep
        ltnaz=ztnaz
		do mag with ltnaz
	    restore screen from ep
        select 11
		if lastkey()=13		
          set color to
          ztwartbp=ztkoszt*100		  
          do asaypoz
		  ztmagazyn=.t.
          exit
        else
		  ztnaz=naz
		endif 
		
	  case lastkey()=13              && Zapamietanie pozycji bez magazynu
        set color to
		exit

	  case lastkey()=27
        do gkom with "Przerwac edycje pozycji ? [Y/F] ",zz
	    if zz
          ztlp=ztlp-1
          koniec=.t.
	      return
	    endif    
      case lastkey()=3
        ztnaz=naz
	    kod=.f.
		exit
	endcase  
  enddo             && koniec wprowadzania nazwy
endif


	
 if.not.ztmagazyn
    tone(500,9)
    do tkom1 with "U W A G A !  Pozycja nie bedzie aktualizowana w magazynie !  Nacisnij klawisz."
 *   ztmagazyn=.f.
    ztwartbp=100*ztkoszt
  endif
do skom with "F1-HELP    Enter-zatwierdz_wiersz    PgDn-zatwierdz_pozycje    Esc-zrezygnuj"
  do while .t.
    zz=.t.
    @ 21,63 say space(15)
    set color to (n/w,w/n)
	set cursor on
    @ 21,63 get ztil picture "9999999"	
    read	
 	set cursor off
	do case 
      case lastkey()=13
        set color to	  
		exit
	  case lastkey()=27
        do gkom with "Przerwac edycje pozycji ? [Y/F] ",zz
	    if zz
          koniec=.t.
		  ztlp=ztlp-1
	      return
	    endif    		
      case lastkey()=3
		exit
      endcase
    enddo             && koniec worowadzania ceny

    set color to

    ztkoszt=ztwartbp/100    
	ztwar=ztkoszt*ztil
	
    do asaypoz
	
    do gkom with "Czy dane wprowadzono poprawnie ?  [T/N] ",zz   
	  if zz
	    select 11
		zatwierdz=.t.
		exit
	  endif		
  enddo               && koniec wprowadzania nowej pozycji
zwar=ztwar
recno=recno()
go top
do while eof()=.f.
  zwar=zwar+(tcen*til)*(1+(tstawka/100))
  skip
enddo
go recno

@ 19,53 say "RAZEM :"
@ 19,63 say zwar picture "999,999,999,999"


@ 21,1 clear to 23,78
  append blank
  do treplac

skok=12
if ztlp>skok
  skip -(skok-1)
else
  skip -(ztlp-1)
endif   
RETURN
