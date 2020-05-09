#HW12
if (FALSE)
{"
Use 5-fold cross validation to decide the degree of polynomial to use for a regression of speed on distance needed to stop from the cars data set.  See details below and the Rcode you will need.  This R program, HR12.R is also loaded into Canvas under Files Loaded after Spring Break.  Just hand in the text output with a sentence explaining your choice of degree - no graphics files are necessary.
cars is a data frame with 50 observations on 2 variables
speed - speed(mph)
dist - stopping distance measured in feet
"}
##-------------------------------------------------------------##
#Program to help you
library(faraway)
library(caret) #install this package if needed

set.seed(13245) #use this seed
head(cars,1L)
attach(cars) #n=50
# sorting dataset by distance for graphing purposes
cars <- cars[order(dist),] 
cars

windows(7,7)
#save graph(s) in pdf
pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Homework/HW12_Figures.pdf")
plot(x=cars$dist,y=cars$speed)

##-------------------------------------------------------------##
#The researcher is interested in predicting speed based on knowing stopping distance
#fit a polynomial to the data - use degree 1, 2, 3, or 4?
#use cross-validation since overfitting is a concern
#ASSIGNMENT: use 5-fold cross validation to obtain the choice of degree 1, 2, 3, or 4

#Here is the r-code for a polynomial of degree 4 and plotting the fitted curve
#You can use the code below and just repeat for a polynomials of degree 1, 2, and 3
#Fit a polynomial of degree 4
poly4<- lm(speed~dist+I(dist^2)+I(dist^3)+I(dist^4), data=cars)
summary(poly4) #summary of results from fitting a polynomial of degree 4
plot(x=cars$dist,y=cars$speed)
lines(x=cars$dist,y=poly4$fitted, type="l", col="red")
#Compute the cross-validation metrics for degree 4
# Define training control
train.control <- trainControl(method = "cv", number = 5)
# Train the model
CVpoly4 <- train(speed~dist+I(dist^2)+I(dist^3)+I(dist^4),data = cars, method = "lm",
trControl = train.control)
# Summarize the results
print(CVpoly4)
##

#Fit a polynomial of degree 3
poly3<- lm(speed~dist+I(dist^2)+I(dist^3), data=cars)
summary(poly3) #summary of results from fitting a polynomial of degree 3
plot(x=cars$dist,y=cars$speed)
lines(x=cars$dist,y=poly3$fitted, type="l", col="red")
#Compute the cross-validation metrics for degree 3
# Define training control
train.control <- trainControl(method = "cv", number = 5)
# Train the model
CVpoly3 <- train(speed~dist+I(dist^2)+I(dist^3),data = cars, method = "lm",
trControl = train.control)
# Summarize the results
print(CVpoly3)
##

#Fit a polynomial of degree 2
poly2<- lm(speed~dist+I(dist^2), data=cars)
summary(poly2) #summary of results from fitting a polynomial of degree 2
plot(x=cars$dist,y=cars$speed)
lines(x=cars$dist,y=poly2$fitted, type="l", col="red")
#Compute the cross-validation metrics for degree 2
# Define training control
train.control <- trainControl(method = "cv", number = 5)
# Train the model
CVpoly2 <- train(speed~dist+I(dist^2),data = cars, method = "lm",
trControl = train.control)
# Summarize the results
print(CVpoly2)
##

#Fit a polynomial of degree 1 - straight line model
poly1<- lm(speed~dist, data=cars)
summary(poly1) #summary of results from fitting a polynomial of degree 1
plot(x=cars$dist,y=cars$speed)
lines(x=cars$dist,y=poly1$fitted, type="l", col="red")
#Compute the cross-validation metrics for degree 1
# Define training control
train.control <- trainControl(method = "cv", number = 5)
# Train the model
CVpoly1 <- train(speed~dist,data = cars, method = "lm",
trControl = train.control)
# Summarize the results
print(CVpoly1)
##


##-------------------------------------------------------------##
dev.off()