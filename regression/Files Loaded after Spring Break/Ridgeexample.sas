options nonumber orientation=landscape linesize=130 pagesize=50 nodate; 
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*";
options formdlim='-';

title1 'Gasoline mileage data';
data mileage;
input y x1 x2 x3 x4 x5 x6 x7 x8 x9 x10 x11; 

label y='mpg' x1='displacement' x2='hp' x3='torque' x4='compress ratio'
x5='r axle ratio' x6='carb' x7='# speeds' x8='length'
x9='width' x10='weight' x11='trans type'
;
  
datalines; 
18.9  350  165  260  8  2.56  4  3  200.3  69.9  3910  1     
17  350  170  275  8.5  2.56  4  3  199.6  72.9  3860  1     
20  250  105  185  8.25  2.73  1  3  196.7  72.2  3510  1     
18.25  351  143  255  8  3  2  3  199.9  74  3890  1     
20.07  225  95  170  8.4  2.76  1  3  194.1  71.8  3365  0     
11.2  440  215  330  8.2  2.88  4  3  184.5  69  4215  1     
22.12  231  110  175  8  2.56  2  3  179.3  65.4  3020  1     
21.47  262  110  200  8.5  2.56  2  3  179.3  65.4  3180  1     
34.7  89.7  70  81  8.2  3.9  2  4  155.7  64  1905  0     
30.4  96.9  75  83  9  4.3  2  5  165.2  65  2320  0     
16.5  350  155  250  8.5  3.08  4  3  195.4  74.4  3885  1     
36.5  85.3  80  83  8.5  3.89  2  4  160.6  62.2  2009  0     
21.5  171  109  146  8.2  3.22  2  4  170.4  66.9  2655  0     
19.7  258  110  195  8  3.08  1  3  171.5  77  3375  1     
20.3  140  83  109  8.4  3.4  2  4  168.8  69.4  2700  0     
17.8  302  129  220  8  3  2  3  199.9  74  3890  1     
14.39  500  190  360  8.5  2.73  4  3  224.1  79.8  5290  1     
14.89  440  215  330  8.2  2.71  4  3  231  79.7  5185  1     
17.8  350  155  250  8.5  3.08  4  3  196.7  72.2  3910  1     
16.41  318  145  255  8.5  2.45  2  3  197.6  71  3660  1     
23.54  231  110  175  8  2.56  2  3  179.3  65.4  3050  1     
21.47  360  180  290  8.4  2.45  2  3  214.2  76.3  4250  1     
16.59  400  185   .   7.6  3.08  4  3  196  73  3850  1     
31.9  96.9  75  83  9  4.3  2  5  165.2  61.8  2275  0     
29.4  140  86    .   8  2.92  2  4  176.4  65.4  2150  0     
13.27  460  223  366  8  3  4  3  228  79.8  5430  1     
23.9  133.6  96  120  8.4  3.91  2  5  171.5  63.4  2535  0     
19.73  318  140  255  8.5  2.71  2  3  215.3  76.3  4370  1     
13.9  351  148  243  8  3.25  2  3  215.5  78.5  4540  1     
13.27  351  148  243  8  3.26  2  3  216.1  78.5  4715  1     
13.77  360  195  295  8.25  3.15  4  3  209.3  77.4  4215  1     
16.5  360  165  255  8.5  2.73  4  3  185.2  69  3660  1
;
run;

ods pdf file="Ridgeexample.pdf";
run;

ods graphics on;
proc reg data=mileage outest=b ridge=0 to .4 by .05;
model y=x1-x11/vif;
plot/ridgeplot nomodel;
quit;
run;
ods graphics off;

proc print data=b;
run;

ods pdf close;
run;

