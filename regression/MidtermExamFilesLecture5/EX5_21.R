#Exercise 5.21 (GASTURBINE), page 291, 8th edition which is Exercise 4.64, page 232 7th edition
library(faraway)  #this command brings in a library of regression functions

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
 
#Fit a model for heat rate (kilojoules per kolowatt/hour) of a gas turbine
# as a function of cycle speed (revs/minute) and cycle pressure ratio

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 05 18FEB2020/ex5_21R_out.pdf")

ex5_21 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 05 18FEB2020/GASTURBINE.csv",header = TRUE)
ex5_21
summary(ex5_21)

#write a complete second-order model for heat rate (y)
lmod <- lm(HEATRATE ~ RPM + CPRATIO + I(RPM*CPRATIO) + I(RPM^2) + I(CPRATIO^2),data=ex5_21)
#conduct global F-test
lmod
summary(lmod)
anova(lmod)

#state prediction model
#heat_rate_hat < - 1.558e+04 + 7.823e-02*RPM + -5.231e+02*CPRATIO + 4.452e-03*(RPMxCPRATIO) + -1.806e-07*RPM^2 + 8.840e+00*CPRATIO^2  

#graph the relationship between heat rate and cycle pressure ratio when cycle speed
#is held constant at 5,0000 rpm
#repeat when cycle speed is held constant at 15,0000 rpm

new.dat1 <- data.frame(RPM=5000,CPRATIO <- seq(from=1,to=40,by = 0.5))  #creates an observation where RPM=5000
yhat1 <- predict(lmod, newdata = new.dat1) 
new.dat2 <- data.frame(RPM=15000,CPRATIO <- seq(from=1,to=40,by = 0.5))  #creates an observation where RPM=5000
yhat2 <- predict(lmod, newdata = new.dat2) 

plot(x=CPRATIO,y=yhat1,type="p",col="red",pch=1)  #plotting symbol is a square
par(new=TRUE)
plot(x=CPRATIO,y=yhat2,type="p",col="blue",pch=8, ylab=" ",axes=FALSE) #plotting symbol is an asterisk

#the two curves are on top of each other indicating there is no interaction between RPM and CPRATIO.

#test whether the curvature term for RPM is significant
p=0.1616872 #do not reject

#test whether the curvature term for CPRATIO is significant
p =0.00013  #Reject Ho.

#keep in mind there was no adjustment for multiple testing.
#Bonferroni - .05/k=.001  or k ~ 50
#So, even with a conservative Bonferroni adjustment, we would reject Ho: curvature term for CPRATIO=0

##------------------------------------------##


dev.off()

