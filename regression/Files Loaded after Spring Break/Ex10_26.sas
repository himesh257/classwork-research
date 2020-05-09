options nodate;
run;
data ex10_26;
input YEAR RATE;
time=_n_;
datalines;
1995 7.93
1996 7.81
1997 7.6
1998 6.94
1999 7.44
2000 8.05
2001 6.97
2002 6.54
2003 5.83
2004 5.84
2005 5.87
2006 6.41
2007 6.34
2008 6.03
2009 5.04
2010 4.69
2011 4.45
2012 3.66
2013 3.98
2014 4.17
2015 3.85
2016 3.65
2017 3.99
;
run;
ods pdf file="Ex10_26_Output.pdf";
run;

title1 "Exercise 10.26/7th and 8th editions: Steps 1 and 2";
title2 "Obtain initial estimates of the Betas, Conduct DW test";
proc print data=ex10_26;
run;
ods graphics on;
proc reg data=ex10_26;*get the regression estimates;
model RATE=time/dw dwprob;
run; 

title1 "Exercise 10.26/7th and 8th editions: Steps 3 and 4";
title2 "There is evidence of autocorrelation.  Use 1st order autoregressive model";
proc sgplot data=ex10_26 noautolegend;
   series x=time y=RATE / markers;
   reg x=time y=RATE/  lineattrs=(color=black);
run;

proc autoreg data=ex10_26;
   model RATE = time/nlag=1;
run;
ods close pdf;run;
quit;

