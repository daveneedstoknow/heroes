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
               88 PF-KEY-12 value 1012.
           01 WS-ACCEPT-FNC-KEY PIC X.
          

           01 heroes.
               05 hero-values.
                   10 pic 99 value 01.
                   10 pic x(20) value "Superman".

                   10 pic 99 value 02.
                   10 pic x(20) value "Batman".

                   10 pic 99 value 03.
                   10 pic x(20) value "Spiderman".

                   10 PIC XX VALUE HIGH-VALUES.
                   10 PIC X(20).

           01 hero-data redefines heroes.
               05 hero occurs 4 times.
                   10 hero-id PIC 99.
                   10 hero-name PIC X(20).

           01 selectors.
               05 selectBox PIC X value space occurs 3.


           01 editRow PIC X.
           
           01 heroNumber PIC 99.
           01 lineNumber PIC 99.

       SCREEN SECTION.
              
           01 HEADINGS.
               05 VALUE "HEROES" col 20.
               05 VALUE "ID #" LINE NUMBER PLUS 3 COL 1.
               05 VALUE "NAME" COL 25.
           
           01 DATA-ENTRY.
               05 FILLER PIC X LINE NUMBER lineNumber TO WS-ACCEPT-FNC-KEY.


           01 SC-DETAILS.
               10 hero-id PIC 99 COL 1 LINE NUMBER lineNumber.
               10 hero-name PIC X(20) COL 25 LINE NUMBER lineNumber.

      *>     01 DETAILS.
      *>             10 PIC X USING selectBox(1) LINE NUMBER PLUS 1 COL 1.
      *>             10 pic 99 from hero-id(1)  col 3.
      *>             10 pic X(20) from hero-name(1) COL 25.
      *>             10 PIC X USING selectBox(2) LINE NUMBER PLUS 1 COL 1.
      *>             10 pic 99 from hero-id(2) COL 3.
      *>             10 pic X(20) from hero-name(2) COL 25.

      *>     01 SINGLE.  
      *>         05 VALUE "Detail" LINE NUMBER PLUS 3 COL 1.
      *>         05 VALUE "ID #" LINE NUMBER PLUS 1 COL 1.
      *>         05 PIC 99 USING detailHeroId COL 10.
      *>         05 VALUE "NAME" LINE NUMBER PLUS 1 COL 1.
      *>         05 PIC X(20) USING detailHeroName COL 10.
                       
              
       PROCEDURE DIVISION.
           DISPLAY HEADINGS.


           PERFORM SHOW-DETAILS 
                   VARYING heroNumber 
                   FROM 1 BY 1
                   UNTIL hero-id of hero(heroNumber) equal to HIGH-VALUES.
                   
           PERFORM accept-it UNTIL PF-KEY-1.

           STOP RUN.

       SHOW-DETAILS.

           ADD 5 to heroNumber GIVING lineNumber.
           MOVE corresponding hero(heroNumber) to SC-DETAILS.
           DISPLAY SC-DETAILS.

       accept-it.

           ADD 1 to lineNumber.    
           ACCEPT DATA-ENTRY.

           
