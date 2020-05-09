data ex10_11;
input year quarter sales_index;
Q1=0;Q2=0;Q3=0;
if quarter=1 then Q1=1;
if quarter=2 then Q2=1;
if quarter=3 then Q3=1;
t=_n_;
datalines;
2014 1 438
2014 2 398
2014 3 252
2014 4 160
2015 1 464
2015 2 429
2015 3 376
2015 4 216
2016 1 523
2016 2 496
2016 3 425
2016 4 318
2017 1 593
2017 2 576
2017 3 456
2017 4 398
2018 1 636
2018 2 640
2018 3 526
2018 4 498
2019 1 .
2019 2 .
2019 3 .
2019 4 .
;
run;
ods pdf file="Ex10_11_Output.pdf";run;
title1 "Exercise 10.11/8th edition";
proc print;
run;
proc reg data=ex10_11;*get the regression estimates;
model sales_index=t Q1 Q2 Q3/dw dwprob;
run; 
proc glm data=ex10_11;
class Q1 Q2 Q3;
model sales_index=t Q1 Q2 Q3/p cli;
run; 
quit;
ods pdf close;
run;
