
#Joint Inferences:  Example is simplified to restrict focus on only two X's: Area and Adjacent from gala data
library(faraway)  #this command brings in a library of regression functions

#Focus attention on only Area and Adjacent
lmod <- lm(Species ~ Area + Adjacent,data=gala)
summary(lmod)
confint(lmod) #95% confidence intervals on individual regression coefficients  

#For example: 95% CI on B1 (Area) is given above
#Formula 

qt(0.975, 30-3)  #finds the upper tail 0.975 quantile of the t-distribution with n-p (30-3) df
# 95% CI on B1   B1hat +/- tabled value * std error of B1hat or
0.08406 + c(-1,1) *  2.052 * 0.02028

#and similarly 95% CI for B2 (Adjacent) is given by
-0.01166 + c(-1,1) *  2.052 * 0.02027

##Joint Confidence Intervals for Betas
####Want a Confidence Region confidence interval on B1 covers B1 and confidence interval on B2 covers B2 jointly with 95% confidence 

##Bonferroni approach which essentially states: use alphastar = alpha/k where k is the number of intervals of interest (k=2 in this case)

##--How about Bonferroni Confidence Intervals for B1 and B2---##
##  k=2  so alphastar= .05/2=.025  and each tail is loaded with alphastar/2 probability
qt(0.9875, 30-3)  #k=2  so alphastar= .05/2=.025  and alphastar/2=.0125
##Bonferroni Confidence Intervals that hold jointly for B1 and B2 given by
 0.08406 + c(-1,1) *  2.373 * 0.02028
-0.01166 + c(-1,1) *  2.373 * 0.02027
 
##------How about confidence ellipsoid--------##
##Defined by beta that satisfies: (betahat - beta)'(X'X)(betahat-beta) <= p*MSE*F(alpha,p,n-p)##

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 09 18FEB2020/Joint_InferenceR_out.pdf")

require(ellipse)
plot(ellipse(lmod,c(2,3)),type="l")  #note the use of 2 and 3 - the intercept occupies the 1 position
points(coef(lmod)[2], coef(lmod)[3], pch=19)

abline(v=confint(lmod)[2,],lty=2)
abline(h=confint(lmod)[3,],lty=2)

abline(v= 0.08406 + c(-1,1) *  2.373 * 0.02028,lty=3)
abline(h=-0.01166 + c(-1,1) *  2.373 * 0.02027,lty=3)

#in univariate case, experimenters want 95% CIs that are narrow in width
#in bivariate case, experimenters want 95% Confidence Regions with minimum area

##------End Joint Inference------##

dev.off()

