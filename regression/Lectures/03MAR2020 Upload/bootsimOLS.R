library(faraway) 
library(psych)

data(fat, package="faraway")
describe(fat)

X1 <- scale(fat$abdom)  
X2 <- scale(fat$weight) 
X3 <- scale(fat$wrist)
n <- 252

set.seed(12534)
error <- rnorm(n, m=0, sd=1)

for(i in 1:n)
{
y[i] <- 0  
}

y <- scale(2*X1 + 3*X2 + 4*X3 + error)
head(y)

newdata <- cbind(y,X1,X2,X3)
describe(newdata)

lmod <- lm(y ~ 0 + X1 + X2 + X3)  #note the 0 indicates regression through the origin
lmod

confint(lmod)

##------Bootstrapping Confidence Intervals in Linear Regression--------##
##--this example bootstraps OLS Regression where n=# observations and p=# of parameters and k=#X's ##
##bootstrapping process
# fit the desired linear model (lmod) of y on X1, X2, . . ., Xk and obtain Bhat - want bootstrapped CIs on B's
# obtain the residuals e1, e2, . . ., en  Fhat of es is a good estimator of F of the population of error terms
# take a random sample with replacement of n residuals from e1, e2, . . ., en and label as e*1, e*2, . . ., e*n
# generate new observations yhat*1, yhat*2, . . .,yhat*n
# where yhat*i = the ith row vector of X multiplied by Bhat column vector + e*i  i=1, 2, . . . ,n
# keep in mind the ith row vector of the X matrix = covariate observations on the ith experimental unit
# now run the same desired linear model of yhat* on X1, X2, . . ., Xk to obtain Bhat*1, Bhat*2, ..., Bhat*p
# keep track of the Bhats from each run 1, 2, . . ., nb where nb = # bootstrap runs is at least 200
# the std error of Bhati is equal to the std deviation of the bootstrapped Bhat*i's - there are nb of them 
# now form the 95% confidence interval:
# Bhati +/- 1.96 x (std deviation of the bootstrapped Bhat*i's)
#---------------------------------------------------------------------------------------------------------#

sample(n,rep=TRUE)
##takes a sample of size 252 WITH REPLACEMENT from the residuals.  creates the indices of the sampled residuals##
##should try to take a sample as large as the number of observations in the data set##

set.seed(123)
nb <- 4000
coefmat <- matrix(NA,nb,3) #sets up (nb by 3) matrix to keep track of the results of each bootstrap
head(coefmat)

resids <- residuals(lmod) #store the e1, e2, . . ., en from the desired linear model
resids

preds <- fitted(lmod) #store the yhat (fitted values) from the desired linear model
preds

for(i in 1:nb)
{

#this row below resamples residuals to obtain the new predicted observations
booty <- preds + sample(resids, rep=TRUE) #sampling with replacement
bmod <- update(lmod, booty ~ 0 + X1 + X2 + X3)
coefmat[i,] <- coef(bmod)

}

coefmat <- data.frame(coefmat)
head(coefmat)
apply(coefmat,2,function(x) quantile(x,c(0.025,0.975)))
#first position of apply( , , ,) is an array or matrix, second position=2 indicates to operate on columns
#third position is the function to apply

#compare to the CIs obtained by usual methods
confint(lmod)

windows(7,7)
#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Backup/bootsimOLSR_out.pdf")

#show a distribution of the bootstrapped Betahat's for x1 and x2 and x3

#install.packages("ggplot2")  #install if needed
#show bootstrapped 95% CIs for x1 and x2 and x3

require(ggplot2)

ggplot(coefmat, aes(x=X1)) + geom_density() + geom_vline(xintercept=c(0.197,0.260),lty=2)

ggplot(coefmat, aes(x=X2)) + geom_density() + geom_vline(xintercept=c(0.339,0.411),lty=2)

ggplot(coefmat, aes(x=X3)) + geom_density() + geom_vline(xintercept=c(0.464,0.507),lty=2)

##------------------------------##

dev.off()
