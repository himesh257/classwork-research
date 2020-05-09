
##HW05
library(faraway)  #this command brings in a library of regression functions

#Read in the data set HW04.csv that contains 28 observations and a response variable y with nine regressors x1, x2, . . . ,x9
HW05 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/HW04_data.csv",header = TRUE)
head(HW05,10L)

#Use the data from HW04 and generate a regression with all 9 variables.  The model with all 9 predictors is the Full Model.
lmod <- lm(y ~ x1+x2+x3+x4+x5+x6+x7+x8+x9,data=HW05)

#a) Compute the Variance Inflation Factors for the Full Model
vif(lmod)

#b) Generate a Q-Q normality plot of the residuals from the Full Model
windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/HW05_graphs.pdf")

qqnorm(residuals(lmod),ylab="Residuals",main="Q-Q plot")
qqline(residuals(lmod))

#c) Generate a plot of residuals versus the Fitted values from the Full Model
plot(fitted(lmod),residuals(lmod),xlab="Fitted",ylab="Residuals")
abline(h=0) 

dev.off()
##-----------------------------------------------------------------------##

