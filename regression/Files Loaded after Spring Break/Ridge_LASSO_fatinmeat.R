if (FALSE)
{"
A Tecator Infratec Food and Feed Analyzer working in the wavelength range 850 - 1050 nm by the
Near Infrared Transmission (NIT) principle was used to collect data on samples of finely chopped pure meat.
215 samples were measured. For each sample, the fat content was measured along with a 100 channel spectrum of absorbances.
Since determining the fat content via analytical chemistry is time consuming we would like to build a model to predict the fat content of new samples using
the 100 absorbances which can be measured more easily.
"}

library(faraway)
data(meatspec,package="faraway")  #the dataset meatspec is found in the faraway package

set.seed(15342)

trainmeat <- meatspec[1:172,] #creates training data set
testmeat <- meatspec[173:215,] #creates test data set

trainy <- trainmeat$fat
trainx <- as.matrix(trainmeat[,-101]) #includes the 100 variables V1 - V100

#save graphs in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/Ridge_LASSO_fatinmeat_Figure.pdf")

# Basic Scatterplot Matrix
pairs(~V1+V2+V3+V4+V5+V6,data=meatspec,main="Simple Scatterplot Matrix")
##-------------------------------------##

library(MASS) ##you may need to install the package MASS which has a ridge regression function##

rgmod <- lm.ridge(fat ~ ., trainmeat, lambda = seq(0, 5e-8, len=21))

matplot(rgmod$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod$GCV)#this command prints out the optimal value of lambda using Generalized Cross Validation
##unfortunately, GCV details are not provided
##the 8 below 1.75e-08 identifies the row where the optimal lambda was found

abline(v=1.75e-08)

## you may need to install package parcor  ##
library(parcor)
#the line below performs k-fold cross validation
ridge.cross <- ridge.cv(trainx,trainy,lambda = seq(0, 15e-8, len=16),scale = FALSE, k = 10, plot.it = TRUE)

ridge.cross$lambda.opt
ridge.cross$intercept
ridge.cross$coefficients

#what is value of GCV at the optimal lambda by GCV (lambda=1.75e-8)
rgmod <- lm.ridge(fat ~ ., trainmeat, lambda = 1.75e-8)  
rgmod$GCV

ypred <- cbind(1,as.matrix(trainmeat[,-101])) %*% coef(rgmod)

library(Metrics)#you may need to install the package Metrics#
rmse(ypred, trainmeat$fat)#compute the rmse for lambda = 1.75e-8

##---LASSO----------------------------------##

library(lars) # include lars library including functions for finding the LASSO
#------------------------------------------------#

# lars requires design matrix and response variable

trainy <- trainmeat$fat
trainx <- as.matrix(trainmeat[,-101]) #includes the 100 variables V1 - V100

lassomod <- lars(trainx,trainy)
set.seed(123)
cvout <- cv.lars(trainx,trainy)
cvout$index[which.min(cvout$cv)]
predtrain <- predict(lassomod,trainx,s=0.0101,mode="fraction")
rmse(trainmeat$fat, predtrain$fit)#compute the rmse

testx <- as.matrix(testmeat[,-101])
predtest <- predict(lassomod,testx,s=0.0101,mode="fraction")
rmse(testmeat$fat, predtest$fit)#compute the rmse

pred <- predict(lassomod, s=0.0101, type="coef", mode="fraction")
plot(pred$coef,type="h",ylab="Coefficient")
sum(pred$coef != 0)

pred$coef

dev.off() #closes pdf file