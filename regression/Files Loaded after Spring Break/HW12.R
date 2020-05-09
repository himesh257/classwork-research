#HW12
#The FACTORS data set is described in Exercise 3.68 (7th edition) and Exercise 9.31 (8th edition) and is available here.

#libraries needed
library(faraway)
library(psych)
library(lmtest)

if (FALSE)
{"
a) Find the mean and variance of the dependent variable y= length of stay.
b) Plot LOS versus FACTORS
c) Fit a Poisson model of y (LOS) on the number of factors (FACTORS).	
d) Determine whether the quadratic term FACTORS^2 should be added to the model.
e) What is the difference in the AICs between the model including only FACTORS in the model with the model containing both FACTORS and FACTORS^2.

Submit the plot and output and responses to d) and e) into Canvas.

Perform Poisson regression for Ex9.31 page 523
x=number of FACTORS
y=length of stay
"}

#read in the data which is in a csv file
#change the directory below to your directory
hw12 <- read.csv(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/FACTORS.csv",header = TRUE)

library(faraway)
library(psych)
library(lmtest)

describe(hw12)

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Homework/HW12_Figures.pdf")

#first plot the data
plot(LOS~FACTORS,data=hw12)

hw12_analysis <- glm(LOS ~ FACTORS, family=poisson(link=log),data=hw12)
summary(hw12_analysis)
hw12_analysis2 <- glm(LOS ~ FACTORS + I(FACTORS^2), family=poisson(link=log),data=hw12)
lrtest(hw12_analysis,hw12_analysis2)
summary(hw12_analysis2)

##---------------------------------------------------------------##
dev.off()