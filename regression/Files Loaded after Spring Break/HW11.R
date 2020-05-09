#HW11
#See HW09 for the description of the pima dataset.
#Use the Rcode below to perform forward, backward, and bi-directional stepwise #regression.  Provide a paragraph summarizing the results.
#Multiple Logistic Regression in R 
library(epiDisplay)
library(pROC)
library(caret)
library(faraway)
library(StepReg)
library(lmtest)

if (FALSE)
{"
The National Institute of Diabetes and Digestive and Kidney Diseases 
conducted a study on 768 adult female Pima Indians living near Phoenix.
The pima dataset available in R contains the following variables

test - results of a test to determine if the female patient shows signs of diabetes (coded 0 if negative, 1 if positive)
age - Age (years)
bmi - Body mass index (weight in kg/(height in metres squared))
diastolic - Diastolic blood pressure (mm Hg)
diabetes - Diabetes pedigree function
glucose - Plasma glucose concentration at 2 hours in an oral glucose tolerance test
insulin - 2-Hour serum insulin (mu U/ml)
pregnant - Number of times pregnant
triceps - Triceps skin fold thickness (mm)
"}

logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps,family=binomial(logit),data=pima)
summary(logistic)
anova(logistic)

y <- "test"
stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "forward",
select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "backward",
select = "AIC", sle = 0.15, sls = 0.15)

stepwiselogit(data=pima,y, exclude = NULL, include = NULL, selection = "bidirection",
select = "AIC", sle = 0.15, sls = 0.15)

logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps,family=binomial(logit),data=pima)
summary(logistic)

## Easier view
logistic.display(logistic)

##------------------------------------------------------##
dev.off()
