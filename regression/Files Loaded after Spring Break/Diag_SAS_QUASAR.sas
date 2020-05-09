options nonumber orientation=landscape linesize=132 pagesize=60 nodate;
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options formdlim='-';

*Use the QUASARS dataset from the textbook to examine residuals (data - fit) USING SAS;

%macro csvtosas(in,out);
PROC IMPORT OUT=&out 
DATAFILE= "C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/&in..csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
     GUESSINGROWS=2; 
RUN;
%mend csvtosas;

%csvtosas(QUASAR,quasars);run;
proc print data=quasars(obs=10);run;


 ods excel file="Diag_SAS_QUASAR_output.xlsx";

title1 'SAS regression using Quasars Data';

proc reg data=quasars;
model RFEWIDTH = REDSHIFT LINEFLUX LUMINOSITY AB1450/p r influence;
run;
ods excel close;
run;

ods pdf file="Diag_SAS_QUASAR_output.pdf";
ods graphics on;run;
proc reg data=quasars;
model RFEWIDTH = REDSHIFT LINEFLUX LUMINOSITY AB1450/all;
run;
ods pdf close;
run;

ods graphics off;
run; 
        
ods _all_ close;
run;
