
#https://www.edureka.co/blog/naive-bayes-in-r/
#Zulaikha Lateef
#Zulaikha is a tech enthusiast working as a Research Analyst at Edureka.

if (FALSE)
{"
Data Set Description: The given data set contains 768 observations of patients along with their health details. Here’s a list of the
predictor variables that will help us classify a patient as either Diabetic or Normal:

Pregnancies: Number of pregnancies so far
Glucose: Plasma glucose concentration
BloodPressure: Diastolic blood pressure (mm Hg)
SkinThickness: Triceps skin fold thickness (mm)
Insulin: 2-Hour serum insulin (mu U/ml)
BMI: Body mass index (weight in kg/(height in m)^2)
DiabetesPedigreeFunction: Diabetes pedigree function
Age: Age (years)
The response variable or the output variable is:
Outcome: Class variable (0 or 1)

Logic: To build a Naive Bayes model in order to classify patients as either Diabetic or normal by studying their medical records such as
Glucose level, age, BMI, etc.
"}

#Loading required packages
#install.packages('tidyverse')
library(tidyverse)
#install.packages('ggplot2')
library(ggplot2)
#install.packages('caret')
library(caret)
#install.packages('caretEnsemble')
library(caretEnsemble)
#install.packages('psych')
library(psych)
#install.packages('Amelia')
library(Amelia)
#install.packages('mice')
library(mice)
#install.packages('GGally')
library(GGally)
#install.packages('rpart')
library(rpart)
#install.packages('randomForest')
library(randomForest)
#install.packages('klaR')
library(klaR)

#Reading data into R
data<- read.csv("C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Bayes_Material/diabetes.csv")
table(data$Outcome)

#Setting outcome variables as categorical
data$Outcome <- factor(data$Outcome, levels = c(0,1), labels = c("False", "True"))
table(data$Outcome)

#Studying the structure of the data
str(data)
describe(data)

#Convert '0' values into NA
data[, 2:7][data[, 2:7] == 0] <- NA

#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/BayesClassifierExample2R_Figure.pdf")

#visualize the missing data
missmap(data)

#Use mice package to predict missing values  Generates Multivariate Imputations by Chained Equations (MICE)
mice_mod <- mice(data[, c("Glucose","BloodPressure","SkinThickness","Insulin","BMI")], method='rf')  #method is rf=Random Forest
mice_complete <- complete(mice_mod)

#Transfer the predicted missing values into the main data set
data$Glucose <- mice_complete$Glucose
data$BloodPressure <- mice_complete$BloodPressure
data$SkinThickness <- mice_complete$SkinThickness
data$Insulin<- mice_complete$Insulin
data$BMI <- mice_complete$BMI

missmap(data)

#Data Visualization
#Visual 1
ggplot(data, aes(Age, colour = Outcome)) +
geom_freqpoly(binwidth = 1) + labs(title="Age Distribution by Outcome")

#visual 2
c <- ggplot(data, aes(x=Pregnancies, fill=Outcome, color=Outcome)) +
geom_histogram(binwidth = 1) + labs(title="Pregnancy Distribution by Outcome")
c + theme_bw()

#visual 3
P <- ggplot(data, aes(x=BMI, fill=Outcome, color=Outcome)) +
geom_histogram(binwidth = 1) + labs(title="BMI Distribution by Outcome")
P + theme_bw()

#visual 4
ggplot(data, aes(Glucose, colour = Outcome)) +
geom_freqpoly(binwidth = 1) + labs(title="Glucose Distribution by Outcome")

#visual 5
ggpairs(data)

#Building a model
#split data into training and test data sets
indxTrain <- createDataPartition(y = data$Outcome,p = 0.75,list = FALSE)
training <- data[indxTrain,]
testing <- data[-indxTrain,]
 
#Check dimensions of the split
 
prop.table(table(data$Outcome)) * 100

prop.table(table(training$Outcome)) * 100

prop.table(table(testing$Outcome)) * 100

#create objects x which holds the predictor variables and y which holds the response variables
x = training[,-9]
y = training$Outcome

#create Naive Bayes model by using the training data set
library(e1071)
model = train(x,y,'nb',trControl=trainControl(method='cv',number=10))

#Model Evaluation
#Predict testing set
Predict <- predict(model,newdata = testing )
#Get the confusion matrix to see accuracy value and other parameter values
confusionMatrix(Predict, testing$Outcome )

#draw a plot that shows how each predictor variable is independently responsible for predicting the outcome
#Plot Variable performance
X <- varImp(model)
plot(X)

##-------------------------------------------------------------##
dev.off()