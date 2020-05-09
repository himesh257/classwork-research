/*problem 1 part 1)*/
filename datain '/folders/myfolders/wine.data';
DATA one;
infile datain delimiter=',';
input iden alco mali ash alca magn tota flav nonf proa colo hue od28 prol;
label iden='identifier'
alco='Alcohol'
mali='Malic acid'
ash='Ash' 
alca='Alcalinity of ash' 
magn='Magnesium' 
tota='Total phenols' 
flav='Flavanoids' 
nonf='Nonflavanoid phenols' 
proa='Proanthocyanins' 
colo='Color intensity' 
hue='Hue' 
od28='OD280/OD315 of diluted wines' 
prol='Proline';
RUN;

/*problem 1 part 2)*/
Data two;
set one;
title 'Wine Summary Data';
RUN;

/*problem 1 part 3)*/
PROC MEANS data=two;
RUN;

/*problem 1 part 4)*/
PROC UNIVARIATE data=two normal plot;
var mali;
RUN;

/*problem 1 part 5)*/
PROC CHART data=two;
vbar mali/subgroup=iden;
RUN;

/*problem 1 part 6)*/
PROC PLOT data=two;
by iden;
plot mali*ash;
RUN;

/*problem 2*/
filename datain '/folders/myfolders/corn.txt';
DATA one;
infile datain;
input year yield rain;
if yield<32 then catyield='poor';
else catyield='good';
if rain<=9.7 then catrain='drought';
else if 9.7<rain<=12 then catrain='normal';
else catrain='wet';
RUN;

/*problem 2 part 1)*/
PROC FREQ data=one;
tables catyield catrain;
RUN;
/*the catyield distribution was 12 goods and 7 poors
the catrain distribution was 9 droughts,7 normals and 3 wets*/

/*problem 2 part 2)*/
PROC FREQ data=one;
tables catyield*catrain/;
RUN;
/*when the rain is normal or good,the yield tend to be good*/