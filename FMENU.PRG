*******************************************************************************
* MENU PROGRAMU "FIRMA"                                                       *
****************************************************************************** 
local t2[1],t3[2],T4[2],t5[6],t10[4],t11[3],T6[2],T7[2],T8[4],t9[3],t12[5],t13[3]
local s:=1
local last:=lastkey()
local em:=savescreen(0,0,24,79)
local em1:=savescreen(0,0,24,79)
local em2:=savescreen(0,0,24,79)
local em3:=savescreen(0,0,24,79)
local lmnaz:=space(32)
*local pozm:=1
declare t[5]
hel="firma"
t6[1]:="WYDANO DO MAG."
t6[2]:="PRZYJETO Z MAG"
t10[1]:="1. RACHUNKI  "
t10[2]:="2. PARAGONY   "
t10[3]:="4. Z A K U P. "
t10[4]:="5.PRZESUNIECIE"
t11[1]:="1. FAKTURY   "
t11[2]:="2. RACHUNKI  "
t11[3]:="3. PARAGONY   "
*t1[1]:="1. PRZEROB   "
*t1[2]:="2.PRZESUNIECIE"
*if.not.vvt
*  t1[1]:="*.           "
*endif  
t3[1]:="1. PRZEROB    "
t3[2]:="2.PRZESUNIECIA"
*t3[4]:="4.BIL.OTWARCIA"
t4[1]:="1. MAGAZYNY   "
t4[2]:="2. KONTRAHENT "
t5[1]:=" A N A L I Z A"
*t5[2]:=" OPER..DYSKOWE"
t5[2]:=" PARAMETRY    "
t5[3]:=" INDEKSACJA   "
t5[4]:=" ZEROWANIE BAZ"
t5[5]:=" NOWY  R O K  "
t[1]:= "   PRZEROB  "
t[2]:="  PRACOWNIK  "
t[3]:="   MAGAZYN   "
t[4]:="    PLACE    "
t[5]:="   I N N E  "
t7[1]:="  R A P O R T "
t7[2]:="  P L A C E   "
t12[1]:=" Z A K U P    "
t12[2]:=" SPRZEDAZ     "
t12[3]:=" FAKTURY - SP."
t12[4]:=" RZCHUNKI- SP."
t12[5]:=" UTARGI -  SP."
t13[1]:="SPRZEDAZ-ZEST."
t13[2]:="TOWAR - ZYSK  "
t13[3]:="DOKUMENT-ZYSK "
t8[1]:="   RAPORTY    "
t8[2]:="  DOKUMENTY   "
t8[3]:="    WYROBY    "
t8[4]:=" BIL.OTWARCIA "
t9[1]:="FAKTURA NETTO"
t9[2]:="FAKTURA BRUTT"
t9[3]:="RACHUNEK     "
aspozyc=10
set color to
set cursor off
@ 4,0 clear to 6,79
@ 4,0 to 6,79 double
@ 5,2 say t[1]
@ 5,17 say t[2]
@ 5,33 say t[3]
@ 5,49 say t[4]
@ 5,65 say t[5]
do kreska with 4,15
do kreska with 4,31
do kreska with 4,47
do kreska with 4,63
@ 4,0 say chr(204)
@ 6,0 say chr(204)
@ 4,79 say chr(185)
@ 6,79 say chr(185)
*@ 4,16 say chr(207)
*@ 4,63 say chr(216)
@ 0,60 say chr(205)
@ 0,61 say chr(205)
@ 0,62 say chr(205)

do pole2 with pozm

do while .t.
  close databases
  do while .t.
    last=inkey(0)
    if last=27.or.last=13.or.last=19.or.last=4.or.last=1.or.last=6.or.last=68.or.last=100.or.last=77.or.last=109.or.last=75.or.last=107.or.last=87.or.last=119.or.last=73.or.last=105.or.last=-1 
      exit
    endif
    if last=-9
	  do robak
	endif
  enddo
	  do case
        case last=-1
          do gmag 
	    case last=19     &&strzalka w lewo
	      if pozm>1
		    pozm=pozm-1
		  else
		    pozm=5
		  endif
	    case last=4
	      if pozm<5
		    pozm=pozm+1
		  else
		    pozm=1
		  endif
	    case last=68.or.last=100   &&Dokumenty
	      pozm=1
	    case last=80.or.last=112   &&Pracownik
	      pozm=2
		case last=77.or.last=109  &&Magazyn
		  pozm=3		  
        case last=80.or.last=112   &&Place
		  pozm=4
        case last=73.or.last=105   &&Inne    
		  pozm=5		  
	    case last=27
          @ 21,1 clear to 23,78
          zm=.t.
          set cursor on
          @ 21,27 to 23,48 double
          set color to w/n*
          @ 22,29 say "K O N I E C  ?  "get zm
          read
          set cursor off
          set color to
          if zm
            return
          endif	
          return

	    case last=13
          do pole2 with pozm	  
		  exit			    	    
	 endcase
     do pole2 with pozm
  enddo
save screen to em
do case
  case pozm=1
     analiza=.f.
	 ztyp="MM/A"
	 do kartdok

   case pozm=2
			pdok=.f.
           do pracowni with space(30) 

   case pozm=3
     do while.t.
       if wmag
         do WyborMag
       else
	     do magdefault
       endif
           if lastkey()=27.or.lastkey()=19.or.lastkey()=4
             restore screen from em
             do dokdefault
			 exit
           endif	   
           pdok=.f.
           asmenu=.t.
           cena=" "
           ztyp="MM/A"
           do mag with lmnaz,space(7),.f.
		   lmnaz=zmnaz
           restore screen from em
     enddo 
	 restore screen from em


	 
   case pozm=4
     do placa   

 case pozm=5
     dd=1
     do while .t.
	 restore screen from em
	   do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
       if in47
	     do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
	   endif
	   set color to
       @ 6,63 TO 12,79 double   
       dd=achoice(7,64,11,78,t5,,,dd)   
       do case 
		 case dd=1
           do while.t.
	         do tx with 0,22,"Zatwierdz rodzaj analizy."		   
		     @ 11,48 to 15,64 double 
             z=achoice(12,49,14,63,t8)
			 save screen to em1
			   do case
                 case z=1
				    do prodhis
                 case z=2
                   analiza=.t.
				   d=1
                     set color to (coldef)
                     ztyp="MM/A"
                     do kartdok
			     case z=3
     		       do rejestr with 3
                  case z=4
                    save screen to em2
			        if wmag
                      do tx with 0,22,"Zatwiedz magazyn."
					  do WyborMag
                    else
	                  do magdefault
                    endif
        			do mag with "","",.f.,"BO"
		        	do dokdefault
					restore screen from em2					 
                  case z=0
				    restore screen from em1
				    exit
				endcase	
		   enddo	 
         

*        case dd=2
*          do case
*            case dysk="A:\"
*              do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie A:"
*            case dysk="B:\"
*              do tx with 0,22,"Wspolpraca systemu z dyskietka znajdujaca sie w napedzie B:"	
*          endcase  
*          do march
*       dd=2
*	   pozm=5 
         case dd=2
           do param	
		 case dd=3
           do magindex		   	   
         case dd=4
           do tx with 0,21," UWAGA!  W wyniku dzialania modulu zatwierdzone do zerowania grupy baz danych "
           do tx with 1,22,"                       zostana bezpowrotnie utracone.                         "   
           do tx with 1,23,"       OPERACJE ZEROWANIA NALEZY POPRZEDZIC ARCHIWIZACJA BAZ DANYCH !!        "
		   do haslo with 15,34
		   if magpraw.and.haslo#space(10).and.shaslo#space(10).and.lastkey()#27
		     do zero
		   endif	 
         case dd=5
           do nowyrok
		 case dd=0
            exit 
       endcase
     enddo
endcase
restore screen from em
RETURN

PROCEDURE POLE2
parameters ppoz
do case
  case ppoz=1
    set color to n/w
    @ 5,2 say t[1]
	set color to
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=2
    @ 5,2 say t[1]
	set color to n/w
    @ 5,17 say t[2]
	set color to
    @ 5,33 say t[3]
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=3
    @ 5,2 say t[1]
    @ 5,17 say t[2]
	set color to n/w
    @ 5,33 say t[3]
	set color to
    @ 5,49 say t[4]
    @ 5,65 say t[5]
  case ppoz=4
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
	set color to n/w
    @ 5,49 say t[4]
	set color to
    @ 5,65 say t[5]
  case ppoz=5
    @ 5,2 say t[1]
    @ 5,17 say t[2]
    @ 5,33 say t[3]
    @ 5,49 say t[4]
	set color to n/w
    @ 5,65 say t[5]				
	set color to
endcase  
do tx with 0,22,"<STRZALKI> - wybor  <ENTER> - zatwierdzenie   <ESC> - rezygnacja"
if in47
  do txt213 with 23, "F2 - WYBOR MAGAZYNU GLOWNEGO"
endif
RETURN
