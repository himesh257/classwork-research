options nonumber orientation=landscape linesize=120 pagesize=50 nodate;
options nofmterr validvarname=v7;
OPTIONS FORMCHAR="|----|+|---+=|-/\<>*"; 
options formdlim='-';

ods pdf file="Rocket.pdf";

title1 'Rocket Propellant Example';
data rocket;
input obs shear age;
label shear='Shear Strength (psi)'
 age='Age of Propellant (week)';

datalines; 
1   2158.7   15.5    
2   1678.15  23.75    
3   2316     8    
4   2061.3   17    
5   2207.5   5.5    
6   1708.3   19    
7   1784.7   24    
8   2575     2.5    
9   2357.9   7.5    
10  2256.7   11    
11  2165.2   13    
12  2399.55  3.75    
13  1779.8   25    
14  2336.75  9.75    
15  1765.3   22    
16  2053.5   18    
17  2414.4   6    
18  2200.5   12.5    
19  2654.2   2    
20  1753.7   21.5  
;
run;
ods graphics on;
run;
proc reg data=rocket simple corr;
model shear=age/all;
run;
ods graphics off;
run;         
ods _all_ close;
run;
