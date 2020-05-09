if (FALSE)
{"
A Tecator Infratec Food and Feed Analyzer working in the wavelength range 850 - 1050 nm by the
Near Infrared Transmission (NIT) principle was used to collect data on samples of finely chopped pure meat.
215 samples were measured. For each sample, the fat content was measured along with a 100 channel spectrum of absorbances.
Since determining the fat content via analytical chemistry is time consuming we would like to build a model to predict the fat content of new samples using
the 100 absorbances which can be measured more easily.
"}

library(faraway) 
data(meatspec,package="faraway")
trainmeat <- meatspec[1:172,] #creates training data set
testmeat <- meatspec[173:215,] #creates test data set
head(meatspec)
nrow(meatspec)

#save graph in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/ridge_fatinmeatR_Figure.pdf")

# Basic Scatterplot Matrix
pairs(~V1+V2+V3+V4+V5+V6,data=meatspec,main="Simple Scatterplot Matrix")

require(MASS)
##need to install 
rgmod <- lm.ridge(fat ~ ., trainmeat, lambda = seq(0, 5e-8, len=21))
matplot(rgmod$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod$GCV)  #use the generalized cross validation (GCV) estimate
abline(v=1.75e-08)

require(Metrics)#You will need to install the package Metrics#

#recall the ridge regression both centers and scales the predictors, so need to do the same in computing the fit#
#fits on training data set
ypred <- cbind(1,as.matrix(trainmeat[,-101])) %*% coef(rgmod)[8,]
rmse(ypred, trainmeat$fat)

#fits on test data set
ytpred <- cbind(1,as.matrix(testmeat[,-101])) %*% coef(rgmod)[8,]#prediction in test data
rmse(ytpred, testmeat$fat)  #Much larger than found in training data set#

#bad fit in test data set due to 1 observation?#
c(ytpred[13],testmeat$fat[13])

rmse(ytpred[-13], testmeat$fat[-13])
#removal of possible outlier (obs 13) in test data set reduces rmse by over 1/2

dev.off(0)