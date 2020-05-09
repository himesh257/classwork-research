#Perform simple linear regression using the "gala" data set available in the faraway package

library(faraway)
data(gala, package="faraway") 
help(gala)

head(gala)
head(gala[,-2])  #excludes the second variable (column)

#Simple Linear Regression 
##always plot the data
windows(5,5)
plot(Species ~ Elevation,data=gala)

#fit a straight line (least squares line) through the data
lmod <- lm(Species ~ Elevation,data=gala)
abline(lmod)

summary(lmod)  #we are interested in the test of slope:  H0: slope=0   H1: slope not equal to 0
#When p is low (<0.05) then H0 must go

plot(Species ~ Nearest,data=gala)
#fit a straight line (least squares line) through the data
lmod <- lm(Species ~ Nearest,data=gala)
abline(lmod)

summary(lmod)  #we are interested in the test of slope:  H0: slope=0   H1: slope not equal to 0

plot(lmod)   #this plot generates various plots that we will review later

# Basic Scatterplot Matrix
pairs(~ Species +Area + Elevation + Nearest + Scruz  + Adjacent, data=gala, main="Simple Scatterplot Matrix")

pairs(~ Species +Elevation + Adjacent, data=gala, main="Simple Scatterplot Matrix") #focus on the significant variables

#focus on the Species (the response variable) with Adjacent (one of the covariates)
plot(Species~Adjacent,data=gala)
checkmod <- lm(Species ~ Adjacent,data=gala)
abline(checkmod)
summary(checkmod)

#now fit a multiple regression
lmod <- lm(Species ~ Area + Elevation + Nearest + Scruz  + Adjacent, data=gala)
summary(lmod)
#Adjacent is highly significant in the multiple regression model
#There are many more concepts to think about when performing multiple regression

#one detail to point out - the function sumary (not summary) developed by Faraway
require(faraway)
sumary(lmod) #sumary (only 1 "m") offers a subset of information provided by summary

##---------------------------------------------------------------------##

