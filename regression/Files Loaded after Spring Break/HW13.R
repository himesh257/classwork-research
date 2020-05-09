#HW13
#The following R code generates a ridge regression using all 100 variables in the meatspec dataset in the faraway library.

library(faraway)
library(psych)
library(QuantPsyc)
library(MASS) 

hw13 <- meatspec
hw13 <- data.frame(hw13)  
describe(hw13)

lmod <- lm(fat ~ .,data=hw13) 
summary(lmod) 

rgmod <- lm.ridge(fat ~ .,data=hw13, lambda = seq(0, 6e-08, len=21))

windows(7,7)
#save graph(s) in pdf
  pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/HW13_Figures.pdf")

matplot(rgmod$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod$GCV)  #use the generalized cross validation (GCV) estimate
abline(v=3.0e-08)
rgmod$coef  #prints out the coefficients

rgmod$coef[,11]  #prints out the coefficients at 3.0e-08

##-------------End of Program for Ridge Regression on V1-V100 -----------------##

#Use the program above as a template to generate a ridge regression on variables V71-V100.

if (FALSE)
{"
QUESTION: Are the ridge regression estimates for V71-V100 at the GCV chosen lambda 
 similar to the ridge regression estimates for V71-V100 at the GCV chosen 
 lambda for the ridge regression performed on all 100 variables? 

HELPFUL HINT: #start your R program with these next 7 lines of code to select variables V71-V100.
"}

library(faraway)
library(psych)
library(QuantPsyc)
library(MASS)
hw13 <- meatspec[,-(1:70)]
hw13 <- data.frame(hw13)  
describe(hw13)

##---------------------------------------------##

library(faraway)
library(psych)
library(QuantPsyc)
library(MASS)

hw13 <- meatspec[,-(1:70)]
hw13 <- data.frame(hw13)  
describe(hw13)

lmod <- lm(fat ~ .,data=hw13) 
summary(lmod) 

rgmod <- lm.ridge(fat ~ .,data=hw13, lambda = seq(0, 1e-07, len=21))
matplot(rgmod$lambda, coef(rgmod), type="l", xlab=expression(lambda),ylab=expression(hat(beta)),col=1)
which.min(rgmod$GCV)  #use the generalized cross validation (GCV) estimate
abline(v=9.0e-08)

rgmod$coef       #prints out the coefficients
rgmod$coef[,19]  #prints out the coefficients at 9.0e-08
##-------------End of Program-----------------##

dev.off()