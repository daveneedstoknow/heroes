      	IDENTIFICATION DIVISION.
            PROGRAM-ID. hello.
       ENVIRONMENT DIVISION.
       configuration section.
           SPECIAL-NAMES.
               CRT STATUS IS keyStatus.    
       DATA DIVISION.
        
           WORKING-STORAGE SECTION.
           01 keyStatus pic 9(4).
               88 PF-KEY-1 value 1001.
               88 PF-KEY-2 value 1002.
               88 PF-KEY-3 value 1003.
               88 PF-KEY-4 value 1004.
               88 PF-KEY-5 value 1005.
               88 PF-KEY-8 value 1008.
               88 PF-KEY-10 value 1010.
               88 PF-KEY-12 value 1012.
          
           01 WS-ACCEPT-FNC-KEY PIC X.
          
           01 heroCount pic 99 value 4.
           01 heroes.
               05 hero-values.
                   10 pic 99 value 01.
                   10 pic x(20) value "Superman".

                   10 pic 99 value 02.
                   10 pic x(20) value "Batman".

                   10 pic 99 value 11.
                   10 pic x(20) value "Wonder Woman".

                   10 pic 99 value 03.
                   10 pic x(20) value "Spiderman".
           


           01 hero-data redefines heroes.
               05 hero occurs 4 times.
                   10 hero-id PIC 99.
                   10 hero-name PIC X(20).

           01 selectors.
               05 selectBox PIC X value space occurs 3.


           01 editRow PIC X.
           
           01 heroNumber PIC 99.
           01 lineNumber PIC 99.
           01 detailPanelLineNumber PIC 99.

           01 selectedHeroNumber PIC 99 VALUE 1.
           01 background-colour PIC 9.
           01 col-highlight pic 9 value 4.
           01 col-normal pic 9 value 0.

           01 hero-edit.
               05 hero-name pic x(20).

       SCREEN SECTION.
              
           01 HEADINGS.
               
               05 VALUE "HEROES" col 20.
               05 VALUE "ID #" LINE NUMBER PLUS 3 COL 1.
               05 VALUE "NAME" COL 25.
               
           
           01 SC-FUNCTION-KEYS.
               05 VALUE "F1 EXIT, F2 PREV, F3 NEXT, F5 EDIT" LINE NUMBER lineNumber COL 1.
               05 FILLER PIC X TO WS-ACCEPT-FNC-KEY  LINE NUMBER PLUS 1 COL 1 .

           01 SC-DASHBOARD-ROW.
               10 hero-id PIC 99 COL 1 LINE NUMBER lineNumber
                   BACKGROUND-COLOR background-colour. 
               10 hero-name PIC X(20) COL 25 LINE NUMBER lineNumber
                   BACKGROUND-COLOR background-colour.

           01 SC-DETAILS-PANEL.
               10  VALUE "My hero is " col 1 line number detailPanelLineNumber.
               10  hero-name using hero-name of hero-edit PIC X(20).
              
       PROCEDURE DIVISION.
           DISPLAY HEADINGS.


           PERFORM display-it.
                   
           PERFORM accept-it UNTIL PF-KEY-1.

           STOP RUN.

       display-it.
           PERFORM SHOW-DASHBOARD-ROW 
                   VARYING heroNumber 
                   FROM 1 BY 1
                   UNTIL heroNumber > heroCount.

           PERFORM SHOW-DETAILS.

       SHOW-DASHBOARD-ROW.

           ADD 5 to heroNumber GIVING lineNumber.
           MOVE corresponding hero(heroNumber) to SC-DASHBOARD-ROW.
           IF heroNumber IS equal selectedHeroNumber
               MOVE col-highlight TO background-colour
           else
               MOVE col-normal TO background-colour.
           DISPLAY SC-DASHBOARD-ROW.

       SHOW-DETAILS.
           add 2 to lineNumber.
           move lineNumber to detailPanelLineNumber.
           MOVE corresponding hero(selectedHeroNumber) TO hero-edit.
           DISPLAY SC-DETAILS-PANEL.

       accept-it.
           
           ADD 2 to lineNumber.
           ACCEPT SC-FUNCTION-KEYS
           .
           evaluate TRUE
               WHEN PF-KEY-3
                   IF selectedHeroNumber < heroCount  
                       ADD 1 TO selectedHeroNumber
                   end-if
               WHEN PF-KEY-2
                   IF selectedHeroNumber > 1
                       subtract 1 FROM selectedHeroNumber
                   end-if
               WHEN PF-KEY-5
                   perform edit
           end-evaluate.

           perform display-it. 

       edit.
           ACCEPT SC-DETAILS-PANEL.
           move corresponding hero-edit to hero(selectedHeroNumber).
           
