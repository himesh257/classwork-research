options nodate;
run;
data ex10_35;
input month_t atl_rooms phx_rooms m1-m11;
datalines;
1 59  67 1 0 0 0 0 0 0 0 0 0 0
2 63  85 0 1 0 0 0 0 0 0 0 0 0
3 68  83 0 0 1 0 0 0 0 0 0 0 0
4 70  69 0 0 0 1 0 0 0 0 0 0 0
5 63  63 0 0 0 0 1 0 0 0 0 0 0
6 59  52 0 0 0 0 0 1 0 0 0 0 0
7 68  49 0 0 0 0 0 0 1 0 0 0 0
8 64  49 0 0 0 0 0 0 0 1 0 0 0
9 62  56 0 0 0 0 0 0 0 0 1 0 0
10 73 69 0 0 0 0 0 0 0 0 0 1 0
11 62 63 0 0 0 0 0 0 0 0 0 0 1
12 47 48 0 0 0 0 0 0 0 0 0 0 0
13 64 72 1 0 0 0 0 0 0 0 0 0 0
14 69 91 0 1 0 0 0 0 0 0 0 0 0
15 73 87 0 0 1 0 0 0 0 0 0 0 0
16 67 75 0 0 0 1 0 0 0 0 0 0 0
17 68 70 0 0 0 0 1 0 0 0 0 0 0
18 71 61 0 0 0 0 0 1 0 0 0 0 0
19 67 46 0 0 0 0 0 0 1 0 0 0 0
20 71 44 0 0 0 0 0 0 0 1 0 0 0
21 65 63 0 0 0 0 0 0 0 0 1 0 0
22 72 73 0 0 0 0 0 0 0 0 0 1 0
23 63 71 0 0 0 0 0 0 0 0 0 0 1
24 47 51 0 0 0 0 0 0 0 0 0 0 0
25  . .  1 0 0 0 0 0 0 0 0 0 0
;
run;
ods pdf file="Ex10_35_Output.pdf";
run;

title1 "Exercise 10.35/8th edition - first 3 observations";
proc print data=ex10_35(obs=3);
run;

title1 "Exercise 10.35/8th edition Phoenix Rooms";
title2 "Obtain initial estimates of the Betas, Conduct DW test";
proc reg data=ex10_35;
model phx_rooms=month_t m1-m11/dw dwprob;
run;

*part c fit Reduced model
proc reg data=ex10_35;
model phx_rooms=month_t;
run;

proc autoreg data=ex10_35;
   model phx_rooms = month_t m1-m11/nlag=1;
   output out=p p=yhat pm=ytrend
                lcl=lcl ucl=ucl;
run;
title2 "Obtain forecast for January of Year 3";
proc print data=p;
where month_t ge 25;
run;

title1 "Exercise 10.35/8th edition Atlanta Rooms";
title2 "Obtain initial estimates of the Betas, Conduct DW test";
proc reg data=ex10_35;
model atl_rooms=month_t m1-m11/dw dwprob;
run;

*part c fit Reduced model
proc reg data=ex10_35;
model atl_rooms=month_t;
run;

proc autoreg data=ex10_35;
   model atl_rooms = month_t m1-m11/nlag=1;
   output out=p p=yhat pm=ytrend
                lcl=lcl ucl=ucl;
run;

title2 "Obtain forecast for January of Year 3";
proc print data=p;
where month_t ge 25;
run;

ods pdf close;run;
quit;
