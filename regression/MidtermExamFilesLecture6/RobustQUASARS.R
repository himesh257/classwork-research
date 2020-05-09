if (FALSE) 
{"
Robust Regression is performed in R using the quantreg package
LAD is the default robust regression procedure that is used.
Use the QUASARS dataset from the textbook to perform Robust Regression
"}  

#read in the data which is in a csv file
quasars <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)
head(quasars)

#install.packages("quantreg") #need to install this package if it is not already installed

library(faraway)

#fit the OLS model
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)
summary(lmod)
confint(lmod)

###-----------To Here --------------###

set.seed(15324)  #set the seed for random number generation that is used
#fit the LAD model - minimize the sum of the absolute values of (data - fit) |yi - yhati|
require(quantreg)

#note the rq function generates the LAD results
LADmodel <- rq(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)  
summary(LADmodel)

###-----------To Here --------------###

#use bootstrapping to obtain the confidence intervals  use B=1000 there are 5 regression coefficients B0, B1, B2, B3, B4

bcoef <- matrix(0,1000,5)  #generate a 1000 by 5 matrix of 0s which will be populated with the bootstrap regression results
head(bcoef)

#want s(bo), s(b1), s(b2), s(b3), s(b4) although we are not so interested in s(b0)
#have e1, e2, e3, . . . , e25  ecdf (or Fhat) of the eis is a good estimator of F

windows(7,7)
#now save the plots in a pdf file
 pdf(file="C:/users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 06 25FEB2020/RobustQUASARS_R_out.pdf")

plot(ecdf(residuals(LADmodel)))

###-----------To Here --------------###

#start the boot strap process

#generate a n=25 sample of eis with replacement: e*1, e*2, e*3, . . . , e*25
#generate new responses - y*i = yhati(original predicted value) + e*i for i=1, 2, . . ., 25
#compute y*i=bo + b1x1i + b2x2i +b3x3i + b4x4i + e*i  for i=1, 2, . . ., 25 
#perform LAD and record b01 b11 b21 b31 b41 from the the first bootstrapped sample
#repeat a large number times, 1000 in this case
#have b0i b1i, b2i, b3i b4i from i=1 to 1000
#compute the 0.0275 and the 0.975 quantiles of the 1000 b1is, b2is, b3is, b4is  ignore b0

#A 95% bootstrapped CI on b1 is equal (0.0275 quantile, 0.975 quantile) of the b1is
#Repeat for b2, b3, b4

for(i in 1:1000){
newy <- predict(LADmodel) + residuals(LADmodel)[sample(25,rep=TRUE)]  #take a sample of residuals and generate new y values
brg <- rq(newy  ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)
bcoef[i,] <- brg$coef
}
colnames(bcoef) <- names(coef(LADmodel))
head(bcoef) #prints out the first 6 observations 

#apply:Returns a vector or array or list of values obtained
#        by applying a function to margins of an array or matrix
#        the 2 in the statement indicates to operate over columns.  A 1 indicates to operate over rows
#  for example, col.sums <- apply(x, 2, sum)  sums the columns of the x matrix
#        row.sums <- apply(x, 1, sum) sums the rows of the x matrix

apply(bcoef,2,function(x) quantile(x, c(0.025,0.975)))

#compare to OLS 95% CIs
confint(lmod)
#The LAD bootstrapped CIs are more narrow - due to handling of outliers?

bcoef <- data.frame(bcoef)
head(bcoef)

require(ggplot2)  #Review the bootstrapping results for REDSHIFT and LINEFLUX

p1 <- ggplot(bcoef, aes(x = REDSHIFT)) + geom_density() + xlim(-10, 180)
p1 + geom_vline(xintercept=c(-8.030, 159.4), linetype="dashed")

p2 <- ggplot(bcoef, aes(x = LINEFLUX)) + geom_density() + xlim(100, 700)
p2 + geom_vline(xintercept=c(106.6, 691.7), linetype="dashed")

##-------------------------------------------------##
dev.off()
