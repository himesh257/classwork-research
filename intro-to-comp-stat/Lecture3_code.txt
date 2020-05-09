/* Example 3.1 */
DATA one;
INPUT name $ weight height @@;
LABEL name= 'Name' weight= 'Weight(lb)'
      height= 'Height(cm)' ;
TITLE 'Survey Data';
TITLE2 'FROM NJ';
DATALINES;
John 200 175 Jeffrey 160 180
Tom 140 162 Chris 155 170
;
RUN;
PROC PRINT data=one LABEL NOOBS; /* TITLE 'new' ; */
RUN;

/* Example 3.2 */ 
DATA wghtclub;
     input idno $ name $ team $ strtwght endwght;
     loss = strtwght - endwght;
     label       idno='Identification Number'
                 strtwght='Weight when joining the club'
                 endwght='Weight when exiting the club'
                 loss='Weight lost during the period of club membership';
     title 'Records of Weight-losing club';
     datalines;
1023 David red 189 165
1049 Amelia yellow 145 124
1219 Alan red 210 192
1246 Ravi yellow 194 177
1078 Ashley red 127 118
1221 Jim yellow 220 211
1095 Susan blue 135 127
1157 Rose green 155 141
1331 Jason blue 187 172
1067 Kanoko green 135 122
1251 Richard blue 181 166
1333 Li-Hwa green 141 129
1192 Charlene yellow 152 139
;
RUN;

PROC PRINT label;
RUN;

PROC UNIVARIATE DATA=wghtclub;      /*Use the default setting*/
RUN;

PROC UNIVARIATE DATA=wghtclub normal; /*add the tests of normality*/
RUN;

PROC UNIVARIATE DATA=wghtclub plot;   /*add the plots*/
RUN;

PROC UNIVARIATE DATA=wghtclub normal plot;  /*use both of the normal and plot options*/
RUN;

PROC UNIVARIATE DATA=wghtclub; /*only analyze the variable strtwght*/
VAR strtwght;
ID idno;
RUN;

PROC sort data=wghtclub;   /*sort the data set to use the by statement*/
BY team;
run;
PROC UNIVARIATE DATA=wghtclub;  /*split the set by team*/
BY team;
VAR strtwght;
ID idno;
RUN;

/* Example 3.3 */
DATA  grade;
infile  '/folders/myfolders/grades.dat';
input  id $ gender $ year quiz exam1 exam2 lab finexam;
quiz = quiz*2;
finexam = finexam/2 + 10;
course = 0.1*quiz + 0.2*(exam1+exam2) + 0.1*lab + 0.4*finexam;
if course >= 90 then grade = 'A';
else if course >= 80 then grade = 'B';
else if course >= 70 then grade = 'C';
else if course >= 60 then grade = 'D';
else grade = 'F';
run;

PROC MEANS DATA=grade;    /*Use the default setting*/
run;

PROC MEANS data=grade min max nmiss var t;     /*try some options*/
var course quiz exam1 exam2 lab finexam;
title 'Summary Statistics from Statistics Class';
run;

proc sort data=grade;               /*use the by statement*/
     by year;
run;

proc means data=grade min max nmiss var t;         
     by year;
     var course quiz exam1 exam2 lab finexam;
     title 'Summary Statistics from Statistics Class';
run;

/* Example 3.4 */
PROC freq data=grade;
TITLE 'Grades from Statistics Class';
run;

PROC freq data=grade;
TABLES grade grade*year gender*year /chisq;
run;

/* Example 3.5 */
PROC SORT data=grade;
BY year;

PROC CHART data=grade;
BY year;
VBAR grade;
TITLE1 'Histogram of grades from statistics class';
RUN;

PROC CHART data=grade;
VBAR grade/subgroup=year;
TITLE1 'Histogram of grades from statistics class';
RUN;

/* Example 3.6 */
PROC PLOT data=grade;
plot course*finexam;
run;
PROC PLOT data=grade;
plot course*finexam=grade;
run;
PROC PLOT data=grade;
plot course*finexam='f' course*quiz='q' /overlay;
run;
PROC PLOT data=grade;
plot (course finexam quiz);
run;
