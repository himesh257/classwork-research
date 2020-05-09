#Multiple Logistic Regression in R

library(faraway)
library(StepReg)

logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps, family=binomial(logit),data=pima)
summary(logistic)
analysis(logistic)

y <- "test"
stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "forward",
              select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "backward",
              select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "bidirection",
              select = "AIC", sle = 0.15, sls = 0.15)

