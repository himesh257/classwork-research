if (FALSE)
{"
Robust Regression is performed in R using the quantreg package
LAD Least Absolute Deviations is the default robust regression procedure that is used.
generate the growprice data set - Taiwan city prices
"}
 
year <- 40:46
price = c(1.62, 1.63, 1.90, 2.64, 2.05, 2.13, 1.94)

growprice <- data.frame(year,price)
growprice
summary(growprice)

plot(price~year,growprice)
lmod <-lm(price~year,growprice) #perform OLS.  Also the MLE for B0, B1.
abline(lmod,col="red",lty=2)

summary(lmod)
names(lmod) #provides the names of the different objects from a regression

ei <- resid(lmod)
ei
eisq <- ei^2
eisq
stem(eisq) #stem and leaf display of residuals squared
sum(eisq) #this quantity is minimized for OLS

require(quantreg)  #install if it is not already installed
LADmodel <-rq(price ~ year,model=TRUE,data=growprice,alpha=0.05) #perform LAD regression
summary(LADmodel)

#the function boot.rq in quantreg package performs bootstrapping of quantile regression
#tau is set at the quantile of interest - in this case, the median or 0.5
boot.rq(x=year, y=price, tau = 0.5, R = 200, se="boot", bsmethod = "xy") #bsmethod = "xy" uses the xy-pair method

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

plot(ecdf(eiRob)) #plots the ecdf for the residuals from the LAD model

plot(ei~year,growprice,ylim=c(-.3,.8),col="red")
par(new=TRUE)  #plot the next plot on the same axes as the previous plot
plot(eiRob~year,growprice,axes=FALSE,xlab=" ",ylab=" ",col="blue")
