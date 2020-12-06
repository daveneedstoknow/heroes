      IDENTIFICATION DIVISION.
            PROGRAM-ID. HEROES.
       ENVIRONMENT DIVISION.
       configuration section.
           SPECIAL-NAMES.
               CRT STATUS IS keyStatus.    
       DATA DIVISION.
        
           WORKING-STORAGE SECTION.
           01 keyStatus pic 9(4).
               88 PF-KEY-1-EXIT value 1001.
               88 PF-KEY-2-PREV value 1002.
               88 PF-KEY-3-NEXT value 1003.
               88 PF-KEY-5-EDIT value 1005.
          
           01 WS-ACCEPT-FNC-KEY PIC X.
          
           01 WS-NUMBER-OF-HEROES pic 99 value 4.
           01 WS-DEFAULT-HEROES.
               05 FILLER.
                   10 pic 99 value 01.
                   10 pic x(20) value "Superman".

                   10 pic 99 value 02.
                   10 pic x(20) value "Batman".

                   10 pic 99 value 11.
                   10 pic x(20) value "Wonder Woman".

                   10 pic 99 value 03.
                   10 pic x(20) value "Spiderman".
           
           01 WS-HERO-DATA redefines WS-DEFAULT-HEROES.
               05 WS-HERO occurs 4 times.
                   10 hero-id PIC 99.
                   10 hero-name PIC X(20).

           01 WS-HERO-EDIT.
               05 hero-name pic x(20).
           
           01 WS-HERO-NUMBER PIC 99.
           01 WS-SELECTED-HERO-NUMBER PIC 99 VALUE 1.

           01 WS-NEXT-DISPLAY-LINE-NUM PIC 99 value 0.
           01 WS-DETAIL-PANEL-LINE-NUM PIC 99.

           01 ROW-BACKGROUND-COLOUR PIC 9.
           01 CONST-HIGHLIGHT-COLOUR PIC 9 value 4.
           01 CONST-NORMAL-COLOUR PIC 9 value 0.

       SCREEN SECTION.
              
           01 SC-HEADINGS.
               05 VALUE "HEROES" COL 20 LINE WS-NEXT-DISPLAY-LINE-NUM.
               05 VALUE "ID #" LINE NUMBER PLUS 3 COL 1.
               05 VALUE "NAME" COL 25.
               
           
           01 SC-FUNCTION-KEYS.
               05 VALUE "F1 Exit, F2 Previous, F3 Next, F5 Edit" 
                   LINE NUMBER WS-NEXT-DISPLAY-LINE-NUM COL 1.
               05 FILLER PIC X TO WS-ACCEPT-FNC-KEY  
                   LINE NUMBER PLUS 1 COL 1 .

           01 SC-DASHBOARD-ROW.
               10 hero-id PIC 99 COL 1 
                   LINE NUMBER WS-NEXT-DISPLAY-LINE-NUM
                   BACKGROUND-COLOR ROW-BACKGROUND-COLOUR. 
               10 hero-name PIC X(20) COL 25 
                   LINE NUMBER WS-NEXT-DISPLAY-LINE-NUM
                   BACKGROUND-COLOR ROW-BACKGROUND-COLOUR.

           01 SC-DETAILS-PANEL.
               10  VALUE "My hero is " 
                   COL 1 LINE NUMBER WS-DETAIL-PANEL-LINE-NUM.
               10  hero-name USING hero-name OF WS-HERO-EDIT PIC X(20).
              
       PROCEDURE DIVISION.
           PERFORM COMMAND-POLL UNTIL PF-KEY-1-EXIT.
           STOP RUN.


       COMMAND-POLL.
           PERFORM DISPLAY-DASHBOARD.
           PERFORM ACCEPT-COMMAND.
           PERFORM HANDLE-COMMAND.

       DISPLAY-DASHBOARD.
           MOVE 1 TO WS-NEXT-DISPLAY-LINE-NUM.

           DISPLAY SC-HEADINGS.

           PERFORM SHOW-HEROES-LIST.
           PERFORM SHOW-DETAIL-PANEL.

       SHOW-HEROES-LIST.
           ADD 4 TO WS-NEXT-DISPLAY-LINE-NUM.

           PERFORM SHOW-HERO-ROW 
                   VARYING WS-HERO-NUMBER 
                   FROM 1 BY 1
                   UNTIL WS-HERO-NUMBER > WS-NUMBER-OF-HEROES.

       SHOW-HERO-ROW.
           ADD 1 TO WS-NEXT-DISPLAY-LINE-NUM.

           MOVE CORRESPONDING WS-HERO(WS-HERO-NUMBER) 
               TO SC-DASHBOARD-ROW.
           
           IF WS-HERO-NUMBER IS EQUAL WS-SELECTED-HERO-NUMBER
               MOVE CONST-HIGHLIGHT-COLOUR TO ROW-BACKGROUND-COLOUR
           else
               MOVE CONST-NORMAL-COLOUR TO ROW-BACKGROUND-COLOUR.
           
           DISPLAY SC-DASHBOARD-ROW.

       SHOW-DETAIL-PANEL.
           ADD 2 TO WS-NEXT-DISPLAY-LINE-NUM.
           MOVE WS-NEXT-DISPLAY-LINE-NUM TO WS-DETAIL-PANEL-LINE-NUM.

           MOVE CORRESPONDING WS-HERO(WS-SELECTED-HERO-NUMBER) TO WS-HERO-EDIT.
           DISPLAY SC-DETAILS-PANEL.

       EDIT-HERO.
           ACCEPT SC-DETAILS-PANEL.
           MOVE CORRESPONDING WS-HERO-EDIT TO WS-HERO(WS-SELECTED-HERO-NUMBER).
           

       ACCEPT-COMMAND. 
           ADD 2 TO WS-NEXT-DISPLAY-LINE-NUM.
           ACCEPT SC-FUNCTION-KEYS.

       HANDLE-COMMAND.
           EVALUATE TRUE
               WHEN PF-KEY-3-NEXT
                   IF WS-SELECTED-HERO-NUMBER < WS-NUMBER-OF-HEROES  
                       ADD 1 TO WS-SELECTED-HERO-NUMBER
                   END-IF
               WHEN PF-KEY-2-PREV
                   IF WS-SELECTED-HERO-NUMBER > 1
                       SUBTRACT 1 FROM WS-SELECTED-HERO-NUMBER
                   END-IF
               WHEN PF-KEY-5-EDIT
                   PERFORM EDIT-HERO
           END-EVALUATE.
           