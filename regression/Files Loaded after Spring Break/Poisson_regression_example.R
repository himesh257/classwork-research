#Poisson regression example: Heart Valve Failures 
library(faraway)
library(lmtest)
library(psych)

if (FALSE)
{"
Analysis of Valve Failures using R 
numfail=# Failures
month=# months since install
"}

windows(7,7)
#save graph(s) in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Output/Poisson_HeartValveFailures_Figure.pdf")

#read in the data which is in a csv file
valve <- read.csv("C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Lecture 12 14Apr2020/HeartValves.csv",header = TRUE)
monthsq <- valve$month^2
valve <- cbind(valve,monthsq)
valve  #note the observations are sorted by month for plotting purposes
describe(valve)

attach(valve) #The attach() function in R can be used to make objects within dataframes accessible in R with fewer keystrokes

#first plot the data
plot(numfail~month,data=valve,xlab="Months since installed",ylab="Number of failed valves")

valve_analysis <- glm(numfail ~ month, family=poisson(link=log),data=valve)  #log is the default link function for Poisson
summary(valve_analysis)
confint.default(valve_analysis) 

plot(numfail~month,data=valve,xlab="Months since installed",ylab="Number of failed valves")
lines(month,valve_analysis$fitted, type="l", col="red")
title(main="Valve data with fitted Poisson regression line")

#try added a quadratic term into the model - model building
valve_analysis2 <- glm(numfail ~ month + monthsq,family=poisson(link=log),data=valve)
lrtest(valve_analysis,valve_analysis2)

summary(valve_analysis2)  #recall the LRT is not the same as Wald
confint.default(valve_analysis2) 

#now graph the fitted model with month and month**2
plot(numfail~month,data=valve,xlab="Months since installed",ylab="Number of failed valves")
lines(month,valve_analysis2$fitted, type="l", col="red")
title(main="Valve data with fitted Poisson regression line (month month^2)")
   
dev.off()