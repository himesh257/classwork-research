options nodate;
run;
data ex10_26;**with forecasting**;
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
ods pdf file="Ex10_31_Output.pdf";
run;

data b;
   RATE = .;
   do time = 24 to 28; output; end;
run;

data b;
   merge ex10_26 b;
   by time;
run;


title1 "Data from Exercise 10.26/7th and 8th editions";
title2 "Forecasting";

ods graphics on;
proc autoreg data=b;
   model RATE = time / nlag=1;
   output out=p p=yhat pm=ytrend
                lcl=lcl ucl=ucl;
run;

footnote1 "Notice that the forecasts take into account the recent departures from the trend";
footnote2 "but converge back to the trend line for longer forecast horizons";
proc print data=p;
where time ge 23;
run;

title 'Forecasting Autocorrelated Time Series';
proc sgplot data=p;
   band x=time upper=ucl lower=lcl;
   scatter x=time y=RATE;
   series x=time y=yhat;
   series x=time y=ytrend / lineattrs=(color=black);
run;

ods pdf close;run;
quit;

