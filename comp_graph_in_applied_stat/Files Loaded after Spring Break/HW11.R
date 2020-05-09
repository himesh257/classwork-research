#HW11
if (FALSE)
{"
Use Ex_Cross_Validation.R to perform a 10-fold cross validation to choose between the model 
that includes weight and abdom with the model that includes weight, abdom, and thigh.Choose the 
model by RMSE, by Rsquared, and by MAE criteria. Are the choices consistent? Submit the output (no graphics needed) 
and a short paragraph into Canvas summarizing the results.
"}
##-------------------------------------------------------------------------------------##
library(faraway)
library(caret)
library(olsrr)

#model one
one <- lm(brozek ~ abdom + weight, data=fat)
summary(one)

#model two
two <- lm(brozek ~ abdom + weight + thigh, data=fat)
summary(two)

#Start the cross-validation to choose between the model that includes weight and abdom 
# with the model that includes weight, abdom, and thigh

# Define training control
set.seed(13245)
#asks for 10-fold validation with 5 repeats
train.control <- trainControl(method = "repeatedcv",repeats=5, number = 10)  
##the choices in this function are either 10 or 25

# Train the model
model_one <- train(brozek ~ abdom + weight,data = fat, method = "lm",
trControl = train.control)
# Summarize the results
print(model_one)
##

# Define training control
set.seed(14235)
#asks for 10-fold validation with 5 repeats
train.control <- trainControl(method = "repeatedcv",repeats=5, number = 10)  
# Train the model
model_two <- train(brozek ~ abdom + weight + thigh,data = fat, method = "lm",
trControl = train.control)
# Summarize the results
print(model_two)
##

summary(one)
summary(two)

####End of 10-fold Cross Validation####