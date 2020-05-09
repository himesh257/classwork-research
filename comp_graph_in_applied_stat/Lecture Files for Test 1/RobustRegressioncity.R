if (FALSE)
{"
Robust Regression is performed in R using the quantreg package

Least absolute deviation (LAD) regression is an alternative to 
ordinary least squares (OLS) regression that has greater power
for thick-tailed symmetric and asymmetric error distributions (Cade and Richards 1996).

LAD regression estimates the median (a 0.50 quantile) of a dependent variable
given the independent variable(s) by minimizing sums of absolute deviations
between observed and predicted values. LAD regression can be used anywhere
OLS regression would be used but is often more desirable because it is less
sensitive to outlying data points and is more efficient for skewed error distributions
as well as some symmetric error distributions.

LAD Least Absolute Deviations is the default robust regression procedure that is used.
generate the growprice data set - Taiwan city prices
"}

year <- 40:46
price = c(1.62, 1.63, 1.90, 2.64, 2.05, 2.13, 1.94)

growprice <- data.frame(year,price)
growprice
summary(growprice)

windows(7,7)
#now save the ecdf in a pdf file
 pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 07 11Feb2020/RobustRegressioncityR_out.pdf")


plot(price~year,growprice)
lmod <-lm(price~year,growprice) #perform OLS.  Also the Maximum Likelihood Estimator for B0, B1.
abline(lmod,col="red",lty=2)

summary(lmod)
names(lmod) #provides the names of the different objects from a regression

ei <- residuals(lmod)
ei
eisq <- ei^2
eisq


stem(eisq) #stem and leaf display of residuals squared
sum(eisq) #this quantity is minimized for OLS

require(quantreg)
LADmodel <-rq(price ~ year,model=TRUE,data=growprice,alpha=0.05) #perform LAD regression
summary(LADmodel)

#boot.rq performs bootstrapping to obtain confidence intervals on the Beta parameters
boot.rq(x=year, y=price, tau = 0.5, R = 200, se="boot", bsmethod = "xy")  #tau = 0.5 indicates LAD regression

names(LADmodel)

results <- summary.rq(LADmodel,se="boot", R=200)
head(results)

coef(results)[1,1]
coef(results)[1,2]
coef(results)[2,1]
coef(results)[2,2]

coef(results)[2,1]+ c(-1,1)*1.96*coef(results)[2,2]  #bootstrap CI on slope parameter

plot(price~year,growprice)
abline(lmod,col="red",lty=2)
abline(LADmodel,col="blue",lty=1)

eiRob <- resid(LADmodel)
sum(abs(eiRob)) #this quantity is minimized in LAD 

eisq2Rob <- eiRob^2
sum(eisq)
sum(eisq2Rob)  #this quantity should be bigger than the OLS sum(eisq2)

eiRob
plot(ecdf(eiRob)) #plots the ecdf for the residuals from the LAD model

plot(ei~year,growprice,ylim=c(-.3,.8),col="red")
par(new=TRUE)  #plot the next plot using the same axes as the previous plot
plot(eiRob~year,growprice,axes=F,xlab=" ",ylab=" ",col="blue")

#----------------------------------------------------#
