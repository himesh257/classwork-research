#an example of repeated cross validation

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

# The full model should include all the candidate predictor variables.
head(fat$brozek,3L)

#full model
lmod <- lm(brozek ~ age + weight + height + neck + chest + abdom + hip + thigh + knee + ankle + biceps + forearm + wrist, data=fat)
summary(lmod)

#install.packages("olsrr")  #install olsrr if package has not been installed on your computer
library(olsrr)

#Start the cross-validation to choose between the model chosen by sequential stepwise selection
# and the model chosen by backward elimination

#install.packages("caret")  #install this package if needed
require(caret)

####Show the repeated CV option####

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
set.seed(13245)
train.control <- trainControl(method = "repeatedcv", number = 10,repeats=6)
# Train the model
model_both <- train(brozek ~ abdom + weight + wrist + forearm,data = fat, method = "lm",
trControl = train.control)
# Summarize the results
print(model_both)

####End of 10-fold Cross Validation####







