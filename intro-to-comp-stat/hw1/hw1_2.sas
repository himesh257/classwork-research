DATA mydata;
INPUT   name $ 1-14 from $ 15-26 to $ 27-37 pounds_million $ 38-46;
DATALINES;
Benjamin Mendy Monaco      Man City      52.0
Alvaro Morata  Real Madrid Chelsea       58.0
Romelu Lukaku  Everton     Man United    75.0
Neymar         Barcelona   PSG           199.8 
;
PROC PRINT DATA = mydata;
RUN;