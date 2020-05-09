library(faraway)
library(lmtest)
library(epiDisplay)

logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps,family=binomial(logit),data=pima)
summary(logistic)

## Easier view
logistic.display(logistic)

#Multiple Logistic Regression in R
library(epiDisplay)

#Likelihood Ratio Test for H0: B(triceps)=0 #write model without triceps
logistic1 <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant,family=binomial(logit),data=pima)
lrtest(logistic1,logistic)

logistic2 <- glm(test ~ age + triceps + insulin,family=binomial(logit),data=pima)
summary(logistic2)

logistic3 <- glm(test ~ insulin + diastolic,family=binomial(logit),data=pima)
summary(logistic3)


