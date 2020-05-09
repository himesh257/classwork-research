#Multiple Logistic Regression in R
library(faraway)
library(lmtest)
library(epiDisplay)

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

#Multiple Logistic Regression in R
logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps, family=binomial(logit),data=pima)
summary(logistic)

## Easier view of Odds Ratios
## a) Interpret the adjusted Odds Ratio for diastolic.
logistic.display(logistic)

#Likelihood Ratio Test for H0: B(triceps)=0 #write model without triceps
logistic1 <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant,family=binomial(logit),data=pima)
lrtest(logistic1,logistic)

#b) Perform the Likelihood Ratio Test to determine if age, insulin, and triceps can be dropped from the model using alpha=0.05.
logistic_b <- glm(test ~ bmi + diastolic + diabetes + glucose + pregnant,family=binomial(logit),data=pima)
lrtest(logistic_b,logistic)

#c) Perform the Likelihood Ratio Test to determine if the coefficient of diastolic is equal to the coefficient of insulin using alpha=0.05.
logistic_c <- glm(test ~ age + bmi + I(diastolic+insulin) + diabetes + glucose + pregnant + triceps, family=binomial(logit),data=pima)
lrtest(logistic_c,logistic)

##--------------------------------------------------------------------#
