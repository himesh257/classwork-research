#HW12 Assignment and program to help you

library(faraway)
#install.packages("caret") #install this package if needed
library(caret)
set.seed(13245) #use this seed

head(cars,1L)

attach(cars) #n=50
# sorting dataset by distance for graphing purposes
cars <- cars[order(dist),]
cars

windows(7,7)
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