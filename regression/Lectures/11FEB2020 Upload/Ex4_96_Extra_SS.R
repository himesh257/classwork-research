#R code to demonstrate Extra Sum of Squares

library(faraway)  #this command brings in a library of regression functions

#Exercise 4.96 (quasars), page 254, 8th edition which is Exercise 4.11, page 186 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex496 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

#Peform a multiple regression using the quasar data
lmod1 <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)
summary(lmod1)
anova(lmod1)

# the anova table for this exercise from anova(lmod1) can be viewed as a 6 by 5 matrix
# where the first column is the Df column, the fifth column is the Pr(>F) column
# and the first row includes REDSHIFT and the last row includes Residuals

anova(lmod1)[1,1]
anova(lmod1)[1,5]
anova(lmod1)[6,1]
anova(lmod1)[6,3]
            
#SSR=SSR(REDSHIFT) + SSR(LINEFLUX|REDSHIFT) + SSR(LUMINOSITY|REDSHIFT,LINEFLUX) 
#        +SSR(AB1450|REDSHIFT,LINEFLUX,LUMINOSITY) + SSR(ABSMAG|REDSHIFT,LINEFLUX,LUMINOSITY,AB1450)

#see the following commands to obtain various Sums of Squares
SSR1 <- sum(anova(lmod1)[1:5,2])   #SSR(REDSHIFT,LINEFLUX,LUMINOSITY,AB1450,ABSMAG)
SSR1
SSE1 <- anova(lmod1)[6,2]
SSE1
SSTO1 <- SSR1 + SSE1
SSTO1
R2=SSR1/SSTO1
R2

#Example Extra Sums of Squares
#SSR(REDSHIFT|LINEFLUX,LUMINOSITY,AB1450,ABSMAG)
lmod2 <- lm(RFEWIDTH ~ LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)
anova(lmod2)
SSR2 <- sum(anova(lmod2)[1:4,2])   #SSR(LINEFLUX,LUMINOSITY,AB1450,ABSMAG)

#SSR(REDSHIFT|LINEFLUX,LUMINOSITY,AB1450,ABSMAG) = SSR1 - SSR2
SSR3 <- SSR1 - SSR2
SSR3

#Check
anova(lmod2,lmod1)














