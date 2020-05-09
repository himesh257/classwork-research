library(faraway)
library(glmnet) # include glmnet library including functions for LASSO

# glmnet requires the x matrix and the response vector

hw14x <- as.matrix(meatspec[,-101]) #creates the x matrix for all 100 predictors V1-V100
hw14y <- meatspec[, 101] #creates the y vector

lassomod <- glmnet(hw14x,hw14y)
plot(lassomod)
print(lassomod)

cvfit <- cv.glmnet(hw14x,hw14y)
plot(cvfit)
cvfit$lambda.min
coef(cvfit,s="lambda.min") #variables with non-zero coefficients should be included in the LASSO model


hw14x_2 <- as.matrix(meatspec[,1:30]) #includes the the first 30 variables V1 - V30
hw14y_2 <- meatspec[, 101] #creates the y vector

lassomod_2 <- glmnet(hw14x_2,hw14y_2)
plot(lassomod_2)
print(lassomod_2)

cvfit_2 <- cv.glmnet(hw14x_2,hw14y_2)
plot(cvfit_2)
cvfit_2$lambda.min
coef(cvfit_2,s="lambda.min")


