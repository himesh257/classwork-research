options nonumber orientation=landscape linesize=100 pagesize=50 nodate;
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options formdlim='-';

title1 "Euclidean distance compared to H distance";
data distance; 
input x1 x2;
y=3 + 2*x1 + 4*x2 + rand('NORMAL',0,2); *B0=3 B1 = 2, B2 = 4 and Sigma=2;
x1mean=0;x2mean=.5;
datalines; 
 0   1
-2   0
-3   1
-3   0
-2  .5
 0  .5
 3  .5
 3   0
 3   1
 1   0
 0   1
;
run;

proc print data=distance;
var x1 x2 y;
run;

ods pdf file="exdistance.pdf";

proc means data=distance mean std maxdec=2;
var x1 x2;
run;

proc reg data=distance;
model y=x1 x2/influence;
output out=hmatrix  h=hii;
run; 

data hmatrix;
	set hmatrix;
edistance=sqrt(((x1-x1mean)**2) + ((x2-x2mean)**2));
hdistance=hii;
run;

proc sort data=hmatrix;
by edistance;
run;

proc print data=hmatrix;
var x1 x2 edistance hdistance;
run;

ods graphics on;
proc g3d data=hmatrix;
scatter x2*x1=hii/grid;
run;
quit;
ods graphics off;

ods pdf close;
run;