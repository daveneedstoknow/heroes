# heroes
Cobol heroes 

## WHAT?

Its a version of the Angular tutorial https://angular.io/tutorial Heroes application using COBOL & tech from the 80's

## WHY?

My good friend Dave Farley was looking at if new technologies have really made the developers job any easier.
I said I'd do a COBOL terminal based one just for giggles.
It's a lot less code than the angular one with essentially the same finctionality.

## HOW DO I RUN this?

Install GNUCOBOL  

On Ubuntu
sudo apt install open-cobol

Compile & run with.
cobc -x -free heroes.cob -o ./build/heroes && ./build/heroes
