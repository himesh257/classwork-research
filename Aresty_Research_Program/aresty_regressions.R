# Requied libraries/packages
# ==========================
require(olsrr)
require(MASS)
install.packages("devtools")
library(devtools)
library(ggplot2)


# Loading the .csv file
# =====================
main_data <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/stacked-data-ergodicity.csv",header = TRUE)

# Different types of regression
# =============================
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/All_Possible_Regression.pdf") 
k <- ols_step_all_possible(lmod)    # all possible regressions
k
plot(k)
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Best_Subset_Regression.pdf") 
k <- ols_step_best_subset(lmod,print_plot = TRUE)    # best subset regregression
k
plot(k)
dev.off()

# forward stepwise regression
# ===========================
# Build regression model from a set of candidate predictor variables
# by entering predictors based on p values, in a stepwise manner until there
# is no variable left to enter any more. The model should include all
# the candidate predictor variables. 
# If details is set to TRUE, each step is displayed.
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Forward_Stepwise_Regression.pdf") 
k <- ols_step_forward_p(lmod,details=TRUE)
k
plot(k)
dev.off()

# backward stepwise regression
# ============================
# Build regression model from a set of candidate predictor variables by removing predictors
# based on p values, in a stepwise manner until there is no variable left to remove any more.
# The model should include all the candidate predictor variables.
# If details is set to TRUE, each step is displayed.
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Backward_Stepwise_Regression.pdf") 
k <- ols_step_backward_p(lmod,details=TRUE)
k
plot(k)
dev.off()

# sequential (both directions) stepwise regression
# ================================================
# Build regression model from a set of candidate predictor variables by entering and removing predictors
# based on p values, in a stepwise manner until there is no variable left to enter or remove any more.
# The model should include all the candidate predictor variables.
# If details is set to TRUE, each step is displayed.
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Sequential_Regression.pdf") 
k <- ols_step_both_p(lmod,details=TRUE)
k
plot(k)
dev.off()

# Stepwise models based on Akaike Information Criteria criterion
# ==============================================================
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Forward_Stepwise_Regression_Akaike.pdf") 
k <- ols_step_forward_aic(lmod)       # forward selection
k
plot(k)
dev.off()
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Backward_Stepwise_Regression_Akaike.pdf") 
k <- ols_step_backward_aic(lmod)      # backward selection
k
plot(k)
dev.off()
pdf(file="C:/Users/buchh/OneDrive/Desktop/pdf/Sequential_Regression_Akaike.pdf") 
k <- ols_step_both_aic(lmod)          # both sides
k
plot(k)
dev.off()


