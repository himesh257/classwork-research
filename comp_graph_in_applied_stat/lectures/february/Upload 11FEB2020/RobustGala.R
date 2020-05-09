if (FALSE) 
{"
Robust Regression is performed in R using the quantreg package
LAD is the default robust regression procedure that is used.
See page 126 of textbook - generate LAD on Gala data
;
"}  

#install.packages("quantreg") #need to install this package if it is not already installed

library(faraway)

#fit the OLS model
lmod <- lm(Species ~ Area+Elevation+Nearest+Scruz+Adjacent, data=gala)
summary(lmod)
confint(lmod)

set.seed(15324)  #set the seed for random number generation that is used
#fit the LAD model - minimize the sum of the absolute values of (data - fit) |yi - yhati|
require(quantreg)

#note the rq function generates the LAD results
LADmodel <- rq(Species ~ Area+Elevation+Nearest+Scruz+Adjacent, data=gala)  
summary(LADmodel)

#use bootstrapping to obtain the confidence intervals

bcoef <- matrix(0,1000,6)  #generate a 1000 by 6 matrix of 0s which will be populated with the bootstrap regression results
head(bcoef)

#want s(b1), s(b2), s(b3), s(b4), s(b5)
#have e1, e2, e3, . . . , e30  ecdf (or Fhat) of the eis is a good estimator of F

#start the boot strap process

#generate a n=30 sample of eis with replacement: e*1, e*2, e*3, . . . , e*30
#compute y*i=bo + b1x1i + b2x2i +b3x3i + b4x4i + b5x5i + e*i  for i=1, 2, . . ., 30 
#perform LAD and record b11 b21 b31 b41 b51 from the the first bootstrapped sample
#repeat a large number times, 1000 in this case
#have b1i, b2i, b3i b4i, b5i from i=1 to 1000
#compute the 0.0275 and the 0.975 quantiles of the 1000 b1is, b2is, b3is, b4is, b5is

#A 95% bootstrapped CI on b1 is equal (0.0275 quantile, 0.975 quantile) of the b1is
#Repeat for b2, b3, b4, b5

for(i in 1:1000){
newy <- predict(LADmodel) + residuals(LADmodel)[sample(30,rep=TRUE)]  #take a sample of residuals and generate new y values
brg <- rq(newy  ~ Area + Elevation + Nearest + Scruz + Adjacent, data= gala)
bcoef[i,] <- brg$coef
}
head(bcoef) #prints out the first 6 observations 

colnames(bcoef) <- names(coef(LADmodel))

#apply:Returns a vector or array or list of values obtained
#        by applying a function to margins of an array or matrix
#        the 2 in the statement indicates to operate over columns.  A 1 indicates to operate over rows
#  for example, col.sums <- apply(x, 2, sum)  sums the columns of the x matrix
#        row.sums <- apply(x, 1, sum) sums the rows of the x matrix

apply(bcoef,2,function(x) quantile(x, c(0.025,0.975)))
bcoef <- data.frame(bcoef)
head(bcoef)

require(ggplot2)  #Review the bootstrapping results for Area and Adjacent

p1 <- ggplot(bcoef, aes(x = Area)) + geom_density() + xlim(-0.08, 0.08)
p1 + geom_vline(xintercept=c(-0.03076586, 0.04701217), linetype="dashed")

p2 <- ggplot(bcoef, aes(x = Adjacent)) + geom_density() + xlim(-0.10, 0.02)
p2 + geom_vline(xintercept=c(-0.07363902, -0.00774367), linetype="dashed")

