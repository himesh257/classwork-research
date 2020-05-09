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

bcoef <- matrix(0,1000,4)  #generate a 1000 by 6 matrix of 0s which will be populated with the regression results
head(bcoef)

for(i in 1:1000){
  newy <- predict(LADmodel) + residuals(LADmodel)[sample(21,rep=T)]  #take a sample of residuals and generate new y values
  brg <- rq(newy  ~ Area + Elevation + Nearest + Scruz + Adjacent, data= gala)
  bcoef[i,] <- brg$coef
}
head(bcoef) #prints out the first 6 observations 

colnames(bcoef) <- names(coef(LADmodel))
apply(bcoef,2,function(x) quantile(x, c(0.025,0.975)))
bcoef <- data.frame(bcoef)
head(bcoef)

require(ggplot2)  #Review the bootstrapping results for Area and Adjacent

p1 <- ggplot(bcoef, aes(x = Area)) + geom_density() + xlim(-0.08, 0.08)
p1 + geom_vline(xintercept=c(-0.03076586, 0.04701217), linetype="dashed")

p2 <- ggplot(bcoef, aes(x = Adjacent)) + geom_density() + xlim(-0.10, 0.02)
p2 + geom_vline(xintercept=c(-0.07363902, -0.00774367), linetype="dashed")

