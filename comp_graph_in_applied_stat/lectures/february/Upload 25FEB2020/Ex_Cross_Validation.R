#an example of cross validation

if (FALSE)  
{"
Measuring body fat is not so simple.  Hydrostatic underwater weighing is a method of determining body composition (body fat to lean mass).
Obtain a person's total body density by submerging the body underwater in a tank and measuring the displacement.
Considered the gold standard for body composition assessment. More sophisticated methods may make underwater weighing obsolete in the near future.
n=252 men  - Brozek's equation was applied to each man's hydrostatic underwater weighing results to accurately estimate their percentage of body fat.
"}

library(faraway)  #this command brings in a library of regression functions
data(fat,package="faraway")
#Can we predict body fat using only easy-to-record measurements?

#full model
lmod <- lm(brozek ~ age + weight + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)

x <- model.matrix(lmod)
head(x)
head(fat$brozek)

#install.packages("olsrr")  #install olsrr if package has not been installed on your computer
require(olsrr)

#save graph in pdf
# pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 05 18FEB2020/ex_cross_validation_graph.pdf")

#Build regression model from a set of candidate predictor variables by entering and removing predictors
# based on p values, in a stepwise manner until there is no variable left to enter or remove any more.
# The model should include all the candidate predictor variables.
#If details is set to TRUE, each step is displayed.

both <- ols_step_both_p(lmod,details=FALSE)
both
plot(both)

back <- ols_step_backward_p(lmod,details=FALSE)
back
plot(back)

#install.packages("caret")  #install this package if needed
require(caret)

# Define training control
set.seed(13245)
train.control <- trainControl(method = "cv", number = 10)
# Train the model
model_both <- train(brozek ~ abdom + weight + wrist + forearm,data = fat, method = "lm",
trControl = train.control)
# Summarize the results
print(model_both)
##

# Define training control
set.seed(14235)
train.control <- trainControl(method = "cv", number = 10)
# Train the model
model_both <- train(brozek ~ knee + chest + height + ankle + biceps,data = fat, method = "lm",
trControl = train.control)
# Summarize the results
print(model_both)
##
back
both

####End of 10-fold Cross Validation####

dev.off()






