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

           01 heroes.
               05 hero-values.
                   10 pic 99 value 01.
                   10 pic x(20) value "Superman".

                   10 pic 99 value 02.
                   10 pic x(20) value "Batman".

           01 hero-data redefines heroes.
               05 hero occurs 2 times.
                   10 hero-id PIC 99.
                   10 hero-name PIC X(20).

           01 selectors.
               05 selectBox PIC X value space occurs 3.

           01 details.
               05 detailHeroId PIC 99.
               05 detailHeroName PIC X(20).

           01 heroCount PIC 99 COMP VALUE 2.


           01  HEADINGS.
               05 FILLER PIC X(10).
               05 FILLER PIC X(10) VALUE "HEROES".

           01 SUBHEADING.    
               05 hero-id PIC X(10) VALUE "ID #".
               05 hero-name PIC X(10) VALUE "NAME".

           01 detailLine.
               05 hero-id pic X(7).
               05 hero-name pic X(20).

           01 command pic xx.
               88 COMMAND-ADD VALUE "a ".
               88 COMMAND-DELETE VALUE "d ".

           01 heroNumber pic 99.

       PROCEDURE DIVISION.
           PERFORM display-it.

           PERFORM get-command UNTIL 0 EQUAL TO 1.

           STOP RUN.

       display-it.
           
           DISPLAY HEADINGS.
           MOVE CORRESPONDING SUBHEADING to detailLine.
           DISPLAY detailLine.

           PERFORM display-detail 
                VARYING detailHeroId 
                           FROM 1 BY 1
                           UNTIL detailHeroId IS GREATER THAN heroCount.
                               
           DISPLAY "Enter Hero number:" WITH NO ADVANCING.

       display-detail.
           MOVE CORRESPONDING hero(detailHeroId) to detailLine.
           DISPLAY detailLine.

       get-command.
           
           ACCEPT command FROM CONSOLE.
           IF COMMAND-ADD 
               DISPLAY "ADD".
           IF COMMAND-DELETE
               DISPLAY "DELETE".

           MOVE command TO heroNumber.
           DISPLAY heroNumber.

           IF heroNumber IS NUMERIC
               DISPLAY "Number".
