# Read in the data.
#set filepath for data file
filepath <- "https://quantdev.ssri.psu.edu/sites/qdev/files/student-mat.csv"
#read in the .csv file using the url() function
data <- read.table(file=url(filepath),sep=";",header=TRUE)

#change all variable names to lowercase
var.names.data <-tolower(colnames(data))
colnames(data) <- var.names.data
head(data)

#libraries needed  install if needed

library(faraway)
library(caret)
library(class)
library(dplyr)
library(e1071)
library(FNN)
library(gmodels)
library(psych)

data_class <- data

# put outcome in its own object
mjob_outcome <- data_class %>% select(mjob)
# remove original variable from the data set
data_class <- data_class %>% select(-mjob)

str(data_class)

data_class[, c("age", "medu", "fedu", "traveltime", "studytime", "failures", "famrel", "freetime", "goout", "dalc", "walc",
 "health", "absences", "g1", "g2", "g3")] <- scale(data_class[, c("age", "medu", "fedu", "traveltime", "studytime", "failures",
 "famrel", "freetime", "goout", "dalc", "walc", "health", "absences", "g1", "g2", "g3")])

head(data_class)

str(data_class)

#We now dummy code variables that have just two levels and are coded 1/0.

data_class$schoolsup <- ifelse(data_class$schoolsup == "yes", 1, 0)
data_class$famsup <- ifelse(data_class$famsup == "yes", 1, 0)
data_class$paid <- ifelse(data_class$paid == "yes", 1, 0)
data_class$activities <- ifelse(data_class$activities == "yes", 1, 0)
data_class$nursery <- ifelse(data_class$nursery == "yes", 1, 0)
data_class$higher <- ifelse(data_class$higher == "yes", 1, 0)
data_class$internet <- ifelse(data_class$internet == "yes", 1, 0)
data_class$romantic <- ifelse(data_class$romantic == "yes", 1, 0)

#Then dummy code variables that have two levels, but are not numeric.

data_class$school <- dummy.code(data_class$school)
data_class$sex <- dummy.code(data_class$sex)
data_class$address <- dummy.code(data_class$address)
data_class$famsize <- dummy.code(data_class$famsize)
data_class$pstatus <- dummy.code(data_class$pstatus)

#Next we dummy code variables that have three or more levels.

fjob <- as.data.frame(dummy.code(data_class$fjob))
reason <- as.data.frame(dummy.code(data_class$reason))
guardian <- as.data.frame(dummy.code(data_class$guardian))

#Rename “other” columns in “fjob”, “reason,” and “guardian,” and rename 
# “health” in “fjob” (so we don’t have duplicate columns later).

fjob <- rename(fjob, other_fjob = other)
fjob <- rename(fjob, health_fjob = health)

reason <- rename(reason, other_reason = other)

guardian <- rename(guardian, other_guardian = other)

#Combine new dummy variables with original data set.

data_class <- cbind(data_class, fjob, guardian, reason)

#Remove original variables that had to be dummy coded

data_class <- data_class %>% select(-one_of(c("fjob", "guardian", "reason")))
head(data_class)

#Now we’re ready for k-NN classification!
#We split the data into training and test sets. We partition 75% of the data 
# into the training set and the remaining 25% into the test set.

set.seed(1234) # set the seed to make the partition reproducible
# 75% of the sample size
smp_size <- floor(0.75 * nrow(data_class))
train_ind <- sample(seq_len(nrow(data_class)), size = smp_size)
# creating test and training sets that contain all of the predictors
class_pred_train <- data_class[train_ind, ]
class_pred_test <- data_class[-train_ind, ]

#Split outcome variable into training and test sets using the same partition as above.

mjob_outcome_train <- mjob_outcome[train_ind, ]
mjob_outcome_test <- mjob_outcome[-train_ind, ]

#Use class package. Run k-NN classification.
#We have to decide on the number of neighbors (k). There are several rules of thumb, 
# one being the square root of the number of observations in the training set. In this case, 
#we select 17 as the number of neighbors, which is approximately the square root of our sample size N = 296.

mjob_pred_knn <- knn(train = class_pred_train, test = class_pred_test, cl = mjob_outcome_train, k=17)

#Model evaluation.
# put "mjob_outcome_test" in a data frame
mjob_outcome_test <- data.frame(mjob_outcome_test)

# merge "mjob_pred_knn" and "mjob_outcome_test"
class_comparison <- data.frame(mjob_pred_knn, mjob_outcome_test)

# specify column names for "class_comparison"
names(class_comparison) <- c("PredictedMjob", "ObservedMjob")

# inspect "class_comparison"
head(class_comparison)

# create table examining model accuracy
CrossTable(x = class_comparison$ObservedMjob, y = class_comparison$PredictedMjob, prop.chisq=FALSE, prop.c = FALSE, prop.r =
FALSE, prop.t = FALSE)

#The results of the Cross Table indicate that our model did not predict mother’s job very well.

#Use caret package to run k-NN classification.
#In this package, the function picks the optimal number of neighbors (k) for you.

mjob_pred_caret <- train(class_pred_train, mjob_outcome_train, method = "knn", preProcess = c("center","scale"))

#Looking at the output of the caret package k-NN model, we can see that it chose k = 9, 
#given that this was the number at which accuracy and kappa peaked.

mjob_pred_caret


#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/k_NN_classification_Figure.pdf")

plot(mjob_pred_caret)  #this plot also shows accuracy peaking at 9

#compare our predicted values of mjob to our actual values

knnPredict <- predict(mjob_pred_caret, newdata = class_pred_test)
confusionMatrix(knnPredict, mjob_outcome_test$mjob_outcome_test)

#-------------------------------------------------------------------------------------------------------#
#end of KNN classification
#The model did not perform well - note the low accuracy (proportion of correctly classified cases) of the model.
#Important consideration: A large number of our predictor variables were binary or dummy-coded
#categorical variables, which are not necessarily the most suited for k-NN

dev.off()