
library(faraway)  
hw4_ans <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw4/HW04_data.csv",header = TRUE)
hw4_ans
require(olsrr)
lmod <- lm(y ~ x1+x2+x3+x4+x5+x6+x7+x8+x9,data=hw4_ans)

# part (a)
# best subset regregression
k <- ols_step_best_subset(lmod,print_plot = TRUE)
k

# part (b)
# forward stepwise regression
k <- ols_step_forward_p(lmod,details=TRUE)
k

# part (c)
# backward stepwise regression
k <- ols_step_backward_p(lmod,details=TRUE)
k

# part (d)
# sequential (both directions) stepwise regression 
k <- ols_step_both_p(lmod,details=TRUE)
k







