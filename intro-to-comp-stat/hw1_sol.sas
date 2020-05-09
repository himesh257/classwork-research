*Prob1 a);

options nodate LINESIZE=78;                       ;
data mydata;
input name $ Score1 Score2 Score3 Score4 Score5 final;                          ;
datalines;
Gamma1 11.25 9.75 10 10 10 90
Delta1 9.5 7.5 8 10 10 95
Epsilon1 11.5 10 9.75 3.5 10 100
Theta1 12.5 10 9.5 9 10 100
;
run;
proc print data=mydata;
     var name Score3 final;
run;

*Prob1 b);
options nodate LINESIZE=78;                       ;
data mydata;
input name $ Score1 Score2 Score3 Score4 Score5 final @@;                          ;
datalines;
Gamma1 11.25 9.75 10 10 10 90 Delta1 9.5 7.5 8 10 10 95
Epsilon1 11.5 10 9.75 3.5 10 100 Theta1 12.5 10 9.5 9 10 100
;
run;
proc print data=mydata;
     var name Score3 final;
run;

*Prob2;

data summer17transfer;
input name $ 1-14 from $ 16-30 to $ 32-38 pounds 43-46;
datalines;
Angel Di Maria Real Madrid     Man United 59.7 
Diego Costa    Atletico Madrid Chelsea    32.0
Cesc Fabregas  Barcelona       Chelsea    27.0 
Romelu Lukaku  Chelsea         Everton    28.0
;
run;
proc print data=summer17transfer;
run;