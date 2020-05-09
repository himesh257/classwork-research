#https://rstudio-pubs-static.s3.amazonaws.com/347013_371e59e8867549ddb922ea7b530e5c6a.html#fn2
#Riaz Khan, South Dakota State University

library(faraway)
library(caret)
library(e1071)
library(naivebayes)
library(psych)

#Reading data into R
mydata <- read.csv("C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Bayes_Material/hsbdemo.csv")
mydata$sesf <- as.factor(mydata$ses)

#data set contains information on 200 student scores in different subjects and educational choices (prog = general, academic or vocational).
#interested in classifying new students into educational choices based on their scores.

head(mydata)
str(mydata)
describe(mydata)

attach(mydata)

numx <- data.frame(mydata$prog,mydata$read,mydata$write,mydata$math,mydata$science,mydata$socst)
## Correlation matrix across all programs
cor(numx[,2:6],method="pearson")

subdata1 <- subset(numx,prog=='academic')
subdata2 <- subset(numx,prog=='general')
subdata3 <- subset(numx,prog=='vocation')

## Correlation matrix within academic
cor(subdata1[,2:6],method="pearson")

## Correlation matrix within general
cor(subdata2[,2:6],method="pearson")

## Correlation matrix within vocational
cor(subdata3[,2:6],method="pearson")

set.seed(7267166)
trainIndex=createDataPartition(mydata$prog, p=0.7)$Resample1
train=mydata[trainIndex, ]
test=mydata[-trainIndex, ]

## check the balance
print(table(mydata$prog))

print(table(train$prog))

NBclassfier=naiveBayes(prog~read+write+math+science+socst, data=train)
print(NBclassfier)

printALL=function(model){
  trainPred=predict(model, newdata = train, type = "class")
  trainTable=table(train$prog, trainPred)
  testPred=predict(NBclassfier, newdata=test, type="class")
  testTable=table(test$prog, testPred)
  trainAcc=(trainTable[1,1]+trainTable[2,2]+trainTable[3,3])/sum(trainTable)
  testAcc=(testTable[1,1]+testTable[2,2]+testTable[3,3])/sum(testTable)
  message("Contingency Table for Training Data")
  print(trainTable)
  message("Contingency Table for Test Data")
  print(testTable)
  message("Accuracy")
  print(round(cbind(trainAccuracy=trainAcc, testAccuracy=testAcc),3))
}
printALL(NBclassfier)

## Results after converting ses as factor  ses=Social Economic Status 1=low 2=middle 3=high

## Contingency Table for Training Data

newNBclassifier=naive_bayes(prog~sesf+read+write+math+science+socst,usekernel=T, data=train)
printALL(newNBclassifier)
