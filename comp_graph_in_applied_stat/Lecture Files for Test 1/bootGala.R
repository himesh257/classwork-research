library(faraway) 
data(gala, package="faraway")
summary(gala)
nrow(gala)#provides a count of the number of observations in the gala dataset#

lmod <- lm(Species ~ Area + Elevation + Nearest + Scruz  + Adjacent, gala)
summary(lmod)
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

sample(30,rep=TRUE)
##takes a sample of size 30 WITH REPLACEMENT from the residuals.  creates the indices of the sampled residuals##
##should try to take a sample as large as the number of observations in the data set##

set.seed(123)
nb <- 4000
coefmat <- matrix(NA,nb,6) #sets up (nb by 6) matrix to keep track of the results of each bootstrap
head(coefmat)

resids <- residuals(lmod) #store the e1, e2, . . ., en from the desired linear model
resids

preds <- fitted(lmod) #store the yhat (fitted values) from the desired linear model
preds

for(i in 1:nb)
{

#this row below resamples residuals to obtain the new predicted observations
booty <- preds + sample(resids, rep=TRUE) #sampling with replacement
bmod <- update(lmod, booty ~ Area + Elevation + Nearest + Scruz  + Adjacent)
coefmat[i,] <- coef(bmod)

}

colnames(coefmat) <- c("Intercept",colnames(gala[,3:7]))
coefmat <- data.frame(coefmat)
head(coefmat)
apply(coefmat,2,function(x) quantile(x,c(0.025,0.975)))
#first position of apply( , , ,) is an array or matrix, second position=2 indicates to operate on columns
#third position is the function to apply

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 04 31Jan2020/bootGalaR_out.pdf")

#compare to the CIs obtained by usual methods
confint(lmod)

#show a distribution of the bootstrapped Betahat's for Area and Adjacent
#install.packages("ggplot2")  #install if needed
#show bootstrapped 95% CIs for Area and Adjacent as examples
require(ggplot2)
ggplot(coefmat, aes(x=Area)) + geom_density() + geom_vline(xintercept=c(-0.0628, 0.0185),lty=2)

ggplot(coefmat, aes(x=Adjacent)) + geom_density() + geom_vline(xintercept=c(-0.104, -0.0409),lty=2)

##------------------------------##

dev.off()
