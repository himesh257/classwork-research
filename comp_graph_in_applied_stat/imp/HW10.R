#HW10: 
if (FALSE)
{"
Use the R program code below to generate all possible and stepwise selection procedures on the 6 predictors provided in the lmod statement.
Submit the following output and summary into Canvas.
generated output (graphic output is not needed)
a short paragraph discussing the model you would choose
"}
##--------------------------------------------------------------------------------##
library(faraway) #this command brings in a library of regression functions
#install.packages("olsrr") #install olsrr if package has not been installed on your computer
library(olsrr)

data(fat,package="faraway")
#Can we predict body fat using only easy-to-record measurements?
#use the variables specified in this model
lmod <- lm(brozek ~ weight + neck + chest + abdom + hip + thigh, data=fat)

ols_step_all_possible(lmod)
ols_step_forward_p(lmod,details=TRUE)
ols_step_backward_p(lmod,details=TRUE)
ols_step_both_p(lmod,details=TRUE)
##--------------------------------------------------------------------------------##
