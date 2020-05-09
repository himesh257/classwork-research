/*problem 1 part a)*/
filename datain '/folders/myfolders/oil costs hw4.txt';
DATA oil;
infile datain firstobs=5;
input Date Domestic Imported Composite;
Domestic1=Domestic-20;
Imported1=Imported-15;
change=Domestic-Imported;
RUN; 
PROC MEANS data=oil N MEAN STD T PRT;
     VAR Domestic1;
RUN;
/*p-value/2<0.05 yes*/
    
/*problem 1 part b)*/
PROC MEANS data=oil N MEAN STD T PRT;
     VAR Imported1;
RUN;
/*p-value<0.05 yes*/

/*problem 1 part c)*/
PROC MEANS N MEAN STD T PRT;
     VAR change;
RUN;
/*p-value>0.05 no*/

/*problem 1 part d)*/
filename datain '/folders/myfolders/oil costs hw4 part 2.txt';
DATA oil2;
infile datain;
input costs group;
RUN; 
PROC TTEST data=oil2;
class group;
var costs;
RUN;
/*p-value>0.05 no*/

/*problem 1 part e)*/
PROC ANOVA DATA=oil2;
CLASS group;
MODEL costs = group;
run;
/*f=t^2, p-value are the same*/

/*problem 2 part a)*/
PROC PLOT data=oil;
plot Domestic*Date;
run;

/*problem 2 part b)*/
PROC PLOT data=oil;
plot Imported*Date='%';
run;

/*problem 2 part c)*/
PROC PLOT data=oil;
plot Domestic*Date Imported*Date='%'/overlay;
run;