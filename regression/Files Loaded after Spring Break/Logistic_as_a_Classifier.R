#Measuring the performance of Logistic Regression as a classifier
#Using the Challenger data as an example

library(faraway)
library(caret)
library(pROC)
library(epiDisplay)


if (FALSE)
{"
O-Ring data analyzed using a logistic model in R
"}

#read in the data which is in a csv file
oring <- read.csv("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 11 07Apr2020/Challenger.csv",header = TRUE)
oring
nrow(oring)
summary(oring)

logistic <- glm(TD ~ Temp,data=oring,family=binomial(link='logit'))
summary(logistic)

#now save the graph in a pdf file
 pdf(file="C:/users/jmard/Desktop/RegressionMethodsSpring2020/Output/Logistic_as_a_ClassifierR_Figure.pdf")
#generate ROC curve
ROCresult <- roc(oring$TD ~ logistic$fitted)
plot(ROCresult, legacy.axes = TRUE)
names(ROCresult)
ROCresult$auc

logistic.display(logistic)

plot(TD~Temp,data=oring,xlab="Temperature",ylab="Thermal Distress")
lines(oring$Temp,logistic$fitted, type="l", col="red")
title(main="O-Ring Data with Fitted Logistic Regression Line")

#Assessing the predictive ability of the model
#would like to see how the model is doing as a classifier
#Our decision boundary will be 0.5. If predicted probability of P(TD|Temp) > 0.5 then predicted.TD = 1 otherwise predicted.TD=0
#Note that for some applications, thresholds different than 0.5 could be a better option

#This analysis is provided for instructional purposes only
#we should be using test data and should be performing Cross Validation
#we are using the training data set so overfitting is a concern

predicted.TD <- predict(logistic,data=oring,type='response')  #using the type='response' option generates P(TD|at each level of Temp) 
predicted.TD <- ifelse(predicted.TD > 0.5,1,0)  #predicted.TD is 1 if predicted P(TD|Temp) > 0.50, 0 otherwise

table(predicted.TD, oring$TD)

misClasificError <- mean(predicted.TD != oring$TD)  #  != is the symbol for not equal
misClasificError

#check misClassificationError rate
5/24

print(paste('Accuracy',1-misClasificError))

oring <- cbind(oring,predicted.TD)
data.frame(oring)

predicted.TD <- as.factor(predicted.TD)  #need to be sure this variable is a factor
oring$TD <- as.factor(oring$TD)  #need to be sure this variable is a factor

confusionMatrix(oring$TD,predicted.TD)  #found in the caret library

dev.off()