#I found another package that performs variable selection methods and generates more readable output.
#See the manual at https://cran.r-project.org/web/packages/olsrr/olsrr.pdf 
#See an example at https://cran.r-project.org/web/packages/olsrr/vignettes/variable_selection.html

#R code to demonstrate Variable Selection: stepwise and all possible
#will perform stepwise (forward, backward, stepwise)
#and all possible regressions  k=7 so 2**7 = 128 possible regressions

#this site below has a useful tutorial on Variable Selection in R
#https://rpubs.com/davoodastaraky/subset

library(faraway)  #this command brings in a library of regression functions
#Exercise 6.8 (CLERICAL), page 352, 8th edition which is Exercise 6.6, page 340 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex6_8 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 04 11FEB2020/CLERICAL.csv",header = TRUE)
ex6_8   #ignore DAY variable

#install.packages("olsrr")  #install olsrr if package has not been installed on your computer
#Because R is developed by an open source community, it is not uncommon
# that multiple packages may use the same name for a function or dataset.
# If you load packages that use the same name for an object, R will warn
# that certain object(s) have been “masked”.
require(olsrr)

lmod <- lm(Y ~ X1+X2+X3+X4+X5+X6+X7,data=ex6_8)

#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 05 18FEB2020/ex6_8_olsrr_R_out.pdf")

#all possible regressions
k <- ols_step_all_possible(lmod)
k
plot(k)

#best subset regregression
k <- ols_step_best_subset(lmod,print_plot = TRUE)
k
plot(k)

#Selection criteria output - focus on the criteria starting with ##
##rsquare rsquare of the model
##adjr adjusted rsquare of the model
##predrsq predicted rsquare of the model
##cp mallow’s Cp
##aic akaike information criteria
#sbic sawa bayesian information criteria
##sbc schwarz bayes information criteria
##gmsep estimated MSE of prediction, assuming multivariate normality

#jp final prediction error
#pc amemiya prediction criteria
#sp hocking’s Sp

#Stepwise Forward Regression
#Build regression model from a set of candidate predictor variables
# by entering predictors based on p values, in a stepwise manner until there
# is no variable left to enter any more. The model should include all
# the candidate predictor variables. 
#If details is set to TRUE, each step is displayed.

k <- ols_step_forward_p(lmod,details=TRUE)
k
plot(k)

#Stepwise Backward Regression
#Build regression model from a set of candidate predictor variables by removing predictors
# based on p values, in a stepwise manner until there is no variable left to remove any more.
# The model should include all the candidate predictor variables.
#If details is set to TRUE, each step is displayed.

k <- ols_step_backward_p(lmod,details=TRUE)
k
plot(k)

#Stepwise Regression
#Build regression model from a set of candidate predictor variables by entering and removing predictors
# based on p values, in a stepwise manner until there is no variable left to enter or remove any more.
# The model should include all the candidate predictor variables.
#If details is set to TRUE, each step is displayed.

k <- ols_step_both_p(lmod,details=TRUE)
k
plot(k)

#Stepwise models based on Akaike Information Criteria criterion
k <- ols_step_forward_aic(lmod) #forward selection
k
plot(k)

k <- ols_step_backward_aic(lmod)
k
plot(k)

k <- ols_step_both_aic(lmod)
k
plot(k)

##----------------------------------------##

dev.off()






