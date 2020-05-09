##HW04
library(faraway)  #this command brings in a library of regression functions

#Read in the data set HW04.csv that contains 28 observations and a response variable y with nine regressors x1, x2, . . . ,x9
HW04 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/HW04_data.csv",header = TRUE)
head(HW04,10L)

#a) use the program Ex6_8_olsrr.R as a model to perform Best Subset Regression for each k from 1 to 9
lmod <- lm(y ~ x1+x2+x3+x4+x5+x6+x7+x8+x9,data=HW04)
require(olsrr)

windows(7,7)
#save graph in pdf
#pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/HW04_graphs.pdf")

#plots were not required in the HW assignment but will be shown during the review of HW in class

#a) use the program Ex6_8_olsrr.R as a model to perform Best Subset Regression for each k from 1 to 9
k <- ols_step_best_subset(lmod,print_plot = TRUE)
k
plot(k)  

#b) perform forward stepwise regression using the option 'details=TRUE'
k <- ols_step_forward_p(lmod,details=TRUE)
k
plot(k)

#c) perform backward stepwise regression using the option 'details=TRUE'
k <- ols_step_backward_p(lmod,details=TRUE)
k
plot(k)

#d) perform sequential (both directions) stepwise regression using the option 'details=TRUE'
k <- ols_step_both_p(lmod,details=TRUE)
k
plot(k)

dev.off()
##-----------------------------------------------------------------------##

