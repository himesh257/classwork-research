library(faraway)  #this command brings in a library of regression functions

#Use the QUASARS dataset from the textbook to examine residuals (data - fit)

#read in the data which is in a csv file
quasars <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)

# n=25 observations on 5 independent variables (covariates) 
# REDSHIFT (x1) LINEFLUX(x2) LUMINOSITY(x3) AB1450(x4) ABSMAG(x5) 
# and a response RFEWIDTH (y)
quasars

#Peform a multiple regression using the quasar data
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,data=quasars)

summary(lmod)
anova(lmod)

windows(7,7)
#now save the plots in a pdf file
 pdf(file="C:/users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 06 25FEB2020/Diag_QUASAR_R_out.pdf")

#what do we look for in checking error assumptions
par(mfrow=c(3,3))
n <- 50
for(i in 1:9) {x <- runif(n) ; plot(x,rnorm(n))}  #Constant variance

for(i in 1:9) {x <- runif(n) ; plot(x,x*rnorm(n))}  #Strong nonconstant variance

for(i in 1:9) {x <- runif(n) ; plot(x,sqrt((x))*rnorm(n))}  #Mild nonconstant variance

for(i in 1:9) {x <- runif(n) ; plot(x,cos(x*pi/25)+rnorm(n,sd=1))} #Nonlinearity
par(mfrow=c(1,1))

#checking for constant variance and nonlinear assumptions
plot(fitted(lmod),residuals(lmod),xlab="Fitted",ylab="Residuals")
abline(h=0)  #if you see patterns then suspect nonlinearity

#plot the square root of the absolute value of the residuals
# to examine the constant variance assumption more closely
plot(fitted(lmod),sqrt(abs(residuals(lmod))),xlab="Fitted",ylab="sqrt of |ei|")

#plot residuals against all the X's in the model
#powers of X should be added to the model?
plot(quasars$REDSHIFT,residuals(lmod),xlab="REDSHIFT",ylab="Residuals")  #plot residuals against all the X's in the model
abline(h=0)  #in this case OK - need to generate this plot for the other X's in the model

#plot residuals against X's not in the model for potential inclusion?	
plot(quasars$AB1450,residuals(lmod),xlab="ABSMAG",ylab="Residuals")  #plot residuals against potential X's not in the model
abline(h=0)

abs(residuals(lmod))
which.max(abs(residuals(lmod)))  #check for outliers

#Checking for normality
#The confidence intervals and tests of hypotheses we conduct assume errors are normal(0,sigma^2)
#Use Q-Q plots - sort residuals smallest to largest and plot residual against Finverse(i/n+1)
#where Finverse in the inverse of the standard normal distribution function

qqnorm(residuals(lmod),ylab="Residuals",main="Q-Q plot")
qqline(residuals(lmod))


#Examples of Q-Q plots from various distributions
par(mfrow=c(3,3))
n <- 50

for(i in 1:9) {x <- rnorm(n); qqnorm(x); qqline(x)}  #normal distribution

for(i in 1:9) {x <- exp(rnorm(n)); qqnorm(x); qqline(x)}  #log-normal which is skewed to right distribution

for(i in 1:9) {x <- rcauchy(n); qqnorm(x); qqline(x)}  #Cauchy which is thick tailed but symmetric distribution

for(i in 1:9) {x <- runif(n); qqnorm(x); qqline(x)} #uniform - short-tailed distribution
par(mfrow=c(1,1))

#A formal test for normality:  Shapiro-Wilk test
#This test is sensitive to slight depatures from normality - are of limited use in practice
# H0: residuals are normally distributed

shapiro.test(residuals(lmod))

sd(residuals(lmod))

ks.test(x=residuals(lmod),y="pnorm",0,15) #One-sample Kolmogorov-Smirnov test
#normal with mean=0 and sigma=15?  #has some issues with inflated TYPE II error

#Introduction to the concept of leverage and influence in Simple Linear Regression (one X)
#Leverage measures how far an observation is from Xbar
#Influence measures impact on estimates

#Test for detecting violation of normality assumption using olsrr package
require(olsrr)
ols_test_normality(lmod)

set.seed(123)

#example of a point with no leverage but influence
testdata <- data.frame(x=1:10,y=1:10+rnorm(10))
lmod <- lm(y ~ x, testdata)
p1 <- c(5.5,12)
lmod1 <- lm(y ~ x, rbind(testdata, p1))
plot(y ~ x, rbind(testdata, p1))
points(5.5,12,pch=4,cex=2)
abline(lmod)
abline(lmod1, lty=2)

#example of a point with leverage but little influence
p2 <- c(15,15.1)
lmod2 <- lm(y ~ x, rbind(testdata, p2))
plot(y ~ x, rbind(testdata, p2))
points(15,15.1,pch=4,cex=2)
abline(lmod)
abline(lmod2,lty=2)

#example of a point with leverage and influence
p3 <- c(15,5.1)
lmod3 <- lm(y ~ x, rbind(testdata, p3))
plot(y ~ x, rbind(testdata, p3))
points(15,5.1,pch=4,cex=2)
abline(lmod)
abline(lmod3,lty=2)

#Yhat=XBhat which is X(X'X)-1X'Y which is HY  Yhat is a linear combination of Y's
#The HAT matrix is H=X(X'X)-1X'  which is nxn
#hii – standardized measure of the distance of the ith observation
#from the center of the x-space.

x <- model.matrix( ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450,quasars)
head(x,10L)
xtxi <- solve(t(x) %*% x)  #compute XPX inverse
xtxi
H=(x %*% xtxi %*% t(x)) #H
head(H)

if (FALSE)
{"
Should an influential point be discarded?
Yes, if
–there is an error in recording a measured value;
–the sample point is invalid; or,
–the observation is not part of the population that was intended to be sampled
No, if
–the influential point is a valid observation.

Robust estimation techniques
–These techniques offer an alternative to deleting an influential observation.
–Observations are retained but downweighted in proportion to residual magnitude or influence.
"}

##------------------------------------------------------------------##

