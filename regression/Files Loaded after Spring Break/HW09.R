#Multiple Logistic Regression in R
library(epiDisplay)
library(pROC)
library(caret)
library(faraway)
library(StepReg)

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

library(faraway)
library(StepReg)

logistic <- glm(test ~ age + bmi + diastolic + diabetes + glucose + insulin + pregnant + triceps,family=binomial(logit),data=pima)
summary(logistic)
anova(logistic)

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/HW09_Figures.pdf")

predicted.test <- ifelse(logistic$fitted.values > 0.5,1,0)  

predicted.test <- as.factor(predicted.test) #need to be sure this variable is a factor
pima$test <- as.factor(pima$test)  #need to be sure this variable is a factor

table(pima$test)
table(predicted.test)

#These results are slightly different than results in HW
#Also, the confusion matrix from this output considers '0' as the event
confusionMatrix(predicted.test,pima$test,positive='1')  #found in the caret library

#generate ROC curve  - this information is extra to the Homework
ROCresult <- roc(pima$test ~ logistic$fitted)
plot(ROCresult, legacy.axes = TRUE)
names(ROCresult)
ROCresult$auc   

##--------------------------------------------------------------------#
dev.off()