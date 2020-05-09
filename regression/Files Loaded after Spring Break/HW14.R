#HW14
#The following R code performs LASSO selection using all 100 variables in the meatspec dataset in the faraway library

library(faraway)
library(glmnet) # include glmnet library including functions for LASSO
library(plotmo) # for plot_glmnet

#------------------------------------------------#

# glmnet requires the x matrix and the response vector

hw14x <- as.matrix(meatspec[,-101])  #creates the x matrix for all 100 predictors V1-V100
hw14y <- meatspec[, 101]  #creates the y vector 

windows(7,7)
#save graph(s) in pdf
  pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/HW14_Figures.pdf")

lassomod <- glmnet(hw14x,hw14y)
plot(lassomod,xvar="lambda",label=TRUE)
plot_glmnet(lassomod, label=10)  #label the 10 biggest final coefficients    
print(lassomod)

cvfit <- cv.glmnet(hw14x,hw14y)
plot(cvfit)
cvfit$lambda.min
coef(cvfit,s="lambda.min") #variables with non-zero coefficients should be included in the LASSO model

##-------------End of Program-----------------##
#Use the program above as a template to generate a LASSO selection on variables V1-V30.
#QUESTION: List the variables among V1-V30 from the LASSO regression on all V1-100 variables that are selected by the LASSO selection on variables V1-V30.
#HELPFUL HINT: #start your R program with these next 2 lines of code to select variables V1-V30.

hw14x <- as.matrix(meatspec[,1:30]) #includes the the first 30 variables V1 - V30
hw14y <- meatspec[, 101]  #creates the y vector 

lassomod <- glmnet(hw14x,hw14y)
plot(lassomod,xvar="lambda",label=TRUE)
plot_glmnet(lassomod, label=10)  #label the 10 biggest final coefficients    
print(lassomod)

cvfit <- cv.glmnet(hw14x,hw14y)
plot(cvfit)
cvfit$lambda.min

coef(cvfit,s="lambda.min") #variables with non-zero coefficients should be included in the LASSO model

##--------------------------------------------------------------------------------##

dev.off()