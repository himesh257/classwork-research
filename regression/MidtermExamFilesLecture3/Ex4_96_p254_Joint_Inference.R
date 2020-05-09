
#Joint Inferences:  For 02/11/2020 Example was simplified to restrict focus on only two X's RESHIFT AND LINEFLUX
library(faraway)  #this command brings in a library of regression functions

#Exercise 4.96 (quasars), page 254, 8th edition which is Exercise 4.11, page 186 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex496 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)
ex496

#Focus attention on only REDSHIFT and LINEFLUX
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX,data=ex496)
summary(lmod)
confint(lmod) #95% confidence intervals on individual regression coefficients  

#For example: 95% CI on B1 (REDSHIFT) is given above
#Formula 

qt(0.975, 25-3)  #finds the upper tail 0.975 quantile of the t-distribution with n-p (25-3) df
# 95% CI on B1   B1hat +/- tabled value * std error of B1hat or
5.94 + c(-1,1) *  2.073873 * 24.43

#and similarly 95% CI for B2 (LINEFLUX) is given by
48.41 + c(-1,1) *  2.073873 * 49.69

##Joint Confidence Intervals for Betas
##Want a Confidence Region where confidence interval on B1 covers B1 and
##the confidence interval on B2 covers B2 with overall 95% confidence 

##Bonferroni approach which essentially states: use alphastar = alpha/k 
# where k is the number of intervals of interest (k=2 in this case)

##--How about Bonferroni Confidence Intervals for B1 and B2---##
##  k=2  so alphastar= .05/2=.025  and each tail is loaded with alphastar/2 probability
qt(0.9875, 25-3)  #k=2  so alphastar= .05/2=.025  and alphastar/2=.0125
##Bonferroni Confidence Intervals that hold jointly for B1 and B2 given by

 5.94 + c(-1,1) *  2.405473 * 24.43
48.41 + c(-1,1) *  2.405473 * 49.69

##------How about confidence ellipsoid--------##
##Defined by beta that satisfies: (betahat - beta)'(X'X)(betahat-beta) <= p*MSE*F(alpha,p,n-p)##

windows(7,7)
#save graph in pdf
pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/Ex4_96_p254R_Joint_InferenceR_out.pdf")

require(ellipse)
# Plot an ellipse corresponding to a 95% probability region for a
# bivariate normal distribution 

plot(ellipse(lmod,c(2,3)),type="l")  #note the use of 2 and 3 - the intercept occupies the 1 position
points(coef(lmod)[2], coef(lmod)[3], pch=19)  #pch is used to define the plotting character

abline(v=confint(lmod)[2,],lty=2)
abline(h=confint(lmod)[3,],lty=2)

abline(v= 5.94 + c(-1,1) *  2.405473 * 24.43,lty=3)
abline(h=48.41 + c(-1,1) *  2.405473 * 49.69,lty=3)

##------End Inference------##
dev.off()
