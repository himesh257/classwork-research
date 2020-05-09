options nonumber orientation=landscape linesize=120 pagesize=50 nodate;
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options formdlim='-';

ods pdf file="ShelfStocking_SASout.pdf"; 

title1 'Shelf Stocking Example';
data shelf;
input time_y cases_x;
datalines; 
10.15 25
2.96 6
3 8
6.88 17
0.28 2
5.06 13
9.14 23
11.86 30
11.69 28
6.04 14
7.57 19
1.74 4
9.38 24
0.16 1
1.84 5
;
run;
ods graphics on;
run;
proc reg data=shelf;
model time_y=cases_x;
run;
ods graphics off;
run;         
ods _all_ close;
run;
