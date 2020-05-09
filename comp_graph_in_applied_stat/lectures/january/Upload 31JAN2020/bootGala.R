library(faraway) 
data(gala, package="faraway")
summary(gala)
nrow(gala)#provides a count of the number of observations in the gala dataset#

lmod <- lm(Species ~ Area + Elevation + Nearest + Scruz  + Adjacent, gala)
summary(lmod)
confint(lmod)

##------Bootstrapping Confidence Intervals--------##
##--this example bootstraps OLS Regression--##


sample(30,rep=TRUE)
##takes a sample of size 30 with replacement from the residuals.  creates the indices of the sampled residuals##
##should try to take a sample as large as the number of observations in the data set##

set.seed(123)
nb <- 4000
coefmat <- matrix(NA,nb,6)
head(coefmat)

resids <- residuals(lmod)
resids

preds <- fitted(lmod)
preds

for(i in 1:nb)
{

#this row below resamples residuals to obtain the new predicted observations - see BootstrapProject.pptx
booty <- preds + sample(resids, rep=TRUE)

bmod <- update(lmod, booty ~ .)
coefmat[i,] <- coef(bmod)
}
colnames(coefmat) <- c("Intercept",colnames(gala[,3:7]))
coefmat <- data.frame(coefmat)
head(coefmat)
apply(coefmat,2,function(x) quantile(x,c(0.025,0.975)))
#first position of apply( , , ,) is an array or matric, second position=2 indicates to operate on columns
#third position is the function to apply
windows (5,5)


require(ggplot2)
ggplot(coefmat, aes(x=Area)) + geom_density() + geom_vline(xintercept=c(-0.0628, 0.0185),lty=2)

ggplot(coefmat, aes(x=Adjacent)) + geom_density() + geom_vline(xintercept=c(-0.104, -0.0409),lty=2)

##------------------------------##
