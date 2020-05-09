#PRINCIPAL COMPONENTS ANALYSIS (PCA)

library(faraway)
library(MASS)
library(pls)
#library(olsrr)

#write output to a file, append or overwrite, split to file and terminal
 sink("C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/PCAexample2_Out.txt",append=FALSE,split=TRUE)

#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/PCAexample2_Figure.pdf")

#now go back to determine the performance of the model using the concept of training 
# and test in another dataset (meatspec) as an example
# A Tecator Infratec Food and Feed Analyzer working in the wavelength range of 850 to 1050 nm
# by the near-infrared transmission (NIT) principle was used to collect data on samples of finely chopped
# pure meat and 215 samples were measured. For each sample, the fat content was measured along 
# with a 100-channel spectrum of absorbances. Since determining the fat content via analytical chemistry 
# is time consuming, we would like to build a model to predict the fat content of new samples
# using the 100 absorbances which can be measured more easily.

#partition data into training(n=172) and testing(n=43) data sets

data(meatspec, package="faraway")
trainmeat <- meatspec[1:172,]
testmeat <- meatspec[173:215,]
modlm <- lm(fat ~ ., trainmeat)  # . indicates to include all other variables as predictors
summary(modlm)
#note the large number of large p-values - type 3 versus type 1

#type 1
modlm1 <- lm(fat ~ V1, trainmeat)
modlm2 <- lm(fat ~ V1 + V2, trainmeat)
anova(modlm1,modlm2)
anova(modlm2)
#compare V2 p-value to V2 p-value from 100 predictors

#recall LRT approach (similar in concept to Reduced vs. Full Model approach
library(lmtest)
lrtest(modlm1,modlm2)

#now back to the material
rmse <- function(x,y) sqrt(mean((x-y)^2))  #define a RMSE function

rmse(fitted(modlm), trainmeat$fat)  #RMSE for training data set
rmse(predict(modlm,testmeat), testmeat$fat) #RMSE for test data set

#note the difference in rmse.  Performance of model is much worse in test data set
# - over 5 times as large in the test data set.  Not unusual - good illustration of over-fitting

#now do model building - may not need all 100 predictors - overfitting the noise?
modsteplm <- step(modlm)
summary(modsteplm)  #n=172 n-p=99   p=73  therefore 28 variables were not included

rmse(modsteplm$fit, trainmeat$fat)
rmse(predict(modsteplm,testmeat), testmeat$fat)
#28 variables were not included - a little smaller difference in training versus test

##-----------OK now try dimension reduction using PCA----------------#

meatpca <- prcomp(trainmeat[,-101])  #include only the 100 predictors

#examine the standard deviations of the principal components
round(meatpca$sdev,3)

#this plot below looks at the first 3 principal components and plots the coefficients of their rotations against 
#the 100 predictor variables

matplot(1:100, meatpca$rot[,1:3], type="l", xlab="Frequency (V1-V100)", ylab="", col=1)
#solid line 1st PC, dotted line is for 2nd PC, dashed line is for the 3rd PC

#Now perform PCR (PC Regression) using pcr() in pls package instead of prcomp()
pcrmod <- pcr(fat ~ ., data=trainmeat, ncomp=50)
#conduct a PCA building only up to 50 components

#look at the fit using only the first 4 principal components
rmse(predict(pcrmod, ncomp=4), trainmeat$fat)
#not so bad of a fit according to rmse by using only 4 principal components
#PCR is an example of shrinkage estimation - to be discussed further

#plot the 100 slope coefficients for the full least squares fit
plot(modlm$coef[-1],xlab="Frequency",ylab="Coefficient",type="l")
#the plot is suprising - expect adjacent frequencies
# to have a very similar effect on the response

coefplot(pcrmod, ncomp=4, xlab="Frequency",main="")
#have a more stable result

#generate a scree plot to help with choice of #PCs
plot(meatpca$sdev[1:10],type="l",ylab="SD of PC", xlab="PC number")

#scree shows 2 PCs - try 4 PCs with test data set
rmse(predict(pcrmod, testmeat, ncomp=4), testmeat$fat)
#not very impressive

#how many PCs would give the best result on the test sample
pcrmse <- RMSEP(pcrmod, newdata=testmeat)
plot(pcrmse,main="")
which.min(pcrmse$val)

pcrmse$val[28]

set.seed(123)
pcrmod <- pcr(fat ~ ., data=trainmeat, validation="CV", ncomp=50)
pcrCV <- RMSEP(pcrmod, estimate="CV")
plot(pcrCV,main="")
which.min(pcrCV$val)

ypred <- predict(pcrmod, trainmeat, ncomp=18)
rmse(ypred, trainmeat$fat)
#compare to rmse = 0.69032 from model on all 100 predictors

ypred <- predict(pcrmod, testmeat, ncomp=18)
rmse(ypred, testmeat$fat)
#compare to rmse = 3.814 from model on all 100 predictors

dev.off()