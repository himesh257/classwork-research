options pageno=1 orientation=landscape linesize=130 pagesize=50 nodate nonumber;
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options formdlim='-';

title1 'Multicollinearity - Ridge compared to LASSO'; 

data example;
  input y x1 x2 x3 x4;
datalines;
78.5    7 26  6 60
74.3    1 29 15 52
104.3  11 56  8 20
87.6   11 31  8 47
95.9    7 52  6 33
109.2  11 55  9 22
102.7   3 71 17  6
72.5    1 31 22 44
93.1    2 54 18 22
115.9  21 47  4 26
83.8    1 40 23 34
113.3  11 66  9 12
109.4  10 68  8 12
;
run;

ods trace on;
run;

ods pdf file="ridgevslasso.pdf";
run;

proc reg data=example outest=betas ridge=0 to .5 by .05;
model y=x1 x2 x3 x4/vif;
plot/ridgeplot nomodel;
quit;
run;
proc print data=betas;
run;

proc glmselect data=example;
model y = x1 x2 x3 x4/selection=lasso; 
run; 

ods trace off;
run;

ods pdf close;
run;
