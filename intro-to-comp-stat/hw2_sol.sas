/*Problem 1 part 1)*/
FILENAME datain '/folders/myfolders/tennis for hw2.dat';
DATA tennis;
INFILE datain firstobs = 3;
INPUT name $ 1-22 matches wins losses bagels_served bagels_eaten male;
RUN;
PROC PRINT data=tennis;
RUN;

/*Problem 1 part 2)*/
DATA tennis1;
set tennis;
keep name matches wins losses male;
RUN;
PROC PRINT data=tennis1;
RUN;

/*Problem 1 part 3)*/
DATA tennis2;
set tennis1;
pct = wins / matches;
if male = 1 then tour = 'ATP';
else tour = 'WTA';
RUN;
PROC PRINT data = tennis2;
RUN;

/*Problem 1 part 4)*/
PROC SORT data = tennis2 out = tennis3;
     BY DESCENDING pct;
RUN;  

PROC PRINT DATA = tennis3;
RUN;   
   
/*Problem 1 part 5)*/
DATA atpdata wtadata;
     SET tennis3;
     if male = 1 then output atpdata;
     else output wtadata;
RUN;     

PROC PRINT data = atpdata;
RUN;

PROC PRINT data=wtadata;
RUN;
   
/*Problem 1 part 6)*/
FILENAME dataout '/folders/myfolders/atp_rankings.txt';
DATA rank;
set atpdata;
FILE dataout;
PUT name pct;
DATALINES;
RUN;

/*Problem 2*/  
DATA One; 
INPUT ID age name $;  
DATALINES; 
1001 21 Jone 
1002 20 Peter 
1003 22 Mary 
1004 19 Joe 
1005 21 Mark 
1006 23 Sue 
1007 19 Harry 
1008 18 Tom 
1009 22 Andy 
1020 21 Larry 
; 
RUN; 
PROC PRINT DATA=One;  
RUN; 

DATA Two; 
INPUT ID gender $ department $;  
DATALINES;
1006 F Econ  
1007 M Econ  
1008 M Math  
1009 M Stat  
1010 M Stat  
1001 M Econ  
1002 M Stat  
1003 F Econ  
1004 F Econ  
1005 M Fina  
; 
RUN; 
PROC PRINT DATA=Two;  
RUN; 

/*Problem 2 part 1)*/
/*Concatenating*/
DATA combined1;
set One Two;
RUN;
PROC PRINT data=combined1;
RUN;

/*One-to-one merge*/
DATA combined2;
merge One Two;
RUN;

PROC PRINT data=combined2;
RUN;

/*Problem 2 part 2)*/ 
/*interleaving*/
PROC SORT data=One;
by ID;
RUN; 

PROC SORT data=Two;
by ID;
RUN;

DATA combined3;
set One Two;
by ID;
RUN;
PROC PRINT data=combined3;
RUN;

/*Match merge*/
DATA combined4;
merge One Two;
by ID;
RUN;
PROC PRINT data=combined4;
RUN;

/*Problem 2 part 3)*/ 
/*Concatenating*/
DATA combined5;
set One Two;
RUN;
PROC PRINT data=combined5;
RUN;
/*The output with part 1) is different.The reason is the two original
are sorted */