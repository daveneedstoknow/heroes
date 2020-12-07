# heroes
Cobol heroes 

## WHAT?

Its a version of the Angular tutorial https://angular.io/tutorial Heroes application using COBOL & tech from the 80's

## WHY?

My good friend Dave Farley was looking at if new technologies have really made the developers job any easier.
I said I'd do a COBOL terminal based one just for giggles.
It's a lot less code than the angular one with essentially the same finctionality.

## HOW DO I RUN this?

### Install GNUCOBOL  

On Ubuntu

sudo apt install open-cobol

or excellent page here on installing the latest version of GNUCOBOL https://learningcobol.wordpress.com/2018/05/04/how-to-install-gnucobol-2-2-0-on-ubuntu/

### Compile & run with.

cobc -x -free heroes.cob -o ./build/heroes && ./build/heroes

## DID I LEARN ANYTHING?

Although my first professional development job was as a COBOL programmer on Wang VS machines https://en.wikipedia.org/wiki/Wang_Laboratories#The_Wang_VS_computer_line its been a long time since I wrote any COBOL.
I'd forgotten that we used to do most of our front end stuff in Wang VS procedure language, so had to learn some of the screen handling stuff.
In fact there was quite a lot of re-learning.
The online resources for learning COBOL are appaling compared to what we are used to with modern languages and frameworks. There was a lot of trial and error, I'm sure someone using COBOL on a regular basis will have done a better job.

Lack of unit testing tools is a pain.
Global variables for everything is hard work even on something as small as this. 
I miss a proper IDE, there are some VSCode syntax highlighting but don't know if its the COBOL support or just VSCode vs Intellij that I'm more used to that made life hard.
Overall it was about as easy as I expected, and wasn't surprised it was less code.
