# Read in the data.
#set filepath for data file
filepath <- "https://quantdev.ssri.psu.edu/sites/qdev/files/student-mat.csv"
#read in the .csv file using the url() function
data <- read.table(file=url(filepath),sep=";",header=TRUE)

#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/k_NN_regression_Figure.pdf")

#change all variable names to lowercase
var.names.data <-tolower(colnames(data))
colnames(data) <- var.names.data
head(data)

#libraries needed  (install those packages that you need)
library(faraway)
library(caret)
library(class)
library(dplyr)
library(e1071)
library(FNN)
library(gmodels)
library(psych)

data_reg <- data

# put outcome in its own object
absences_outcome <- data_reg %>% select(absences)
# remove original from the data set
data_reg <- data_reg %>% select(-absences)

str(data_reg)

data_reg[, c("age", "medu", "fedu", "traveltime", "studytime", "failures", "famrel", "freetime", "goout", "dalc", "walc",
 "health", "g1", "g2", "g3")] <- scale(data_reg[, c("age", "medu", "fedu", "traveltime", "studytime", "failures", "famrel",
 "freetime", "goout", "dalc", "walc", "health", "g1", "g2", "g3")])

head(data_reg)

str(data_reg)


data_reg$schoolsup <- ifelse(data_reg$schoolsup == "yes", 1, 0)
data_reg$famsup <- ifelse(data_reg$famsup == "yes", 1, 0)
data_reg$paid <- ifelse(data_reg$paid == "yes", 1, 0)
data_reg$activities <- ifelse(data_reg$activities == "yes", 1, 0)
data_reg$nursery <- ifelse(data_reg$nursery == "yes", 1, 0)
data_reg$higher <- ifelse(data_reg$higher == "yes", 1, 0)
data_reg$internet <- ifelse(data_reg$internet == "yes", 1, 0)
data_reg$romantic <- ifelse(data_reg$romantic == "yes", 1, 0)

data_reg$school <- dummy.code(data_reg$school)
data_reg$sex <- dummy.code(data_reg$sex)
data_reg$address <- dummy.code(data_reg$address)
data_reg$famsize <- dummy.code(data_reg$famsize)
data_reg$pstatus <- dummy.code(data_reg$pstatus)


mjob <- as.data.frame(dummy.code(data_reg$mjob))
fjob <- as.data.frame(dummy.code(data_reg$fjob))
reason <- as.data.frame(dummy.code(data_reg$reason))
guardian <- as.data.frame(dummy.code(data_reg$guardian))

mjob <- rename(mjob, health_mjob = health)
mjob <- rename(mjob, at_home_mjob = at_home)
mjob <- rename(mjob, services_mjob = services)
mjob <- rename(mjob, teacher_mjob = teacher)
mjob <- rename(mjob, other_mjob = other)

fjob <- rename(fjob, health_fjob = health)
fjob <- rename(fjob, at_home_fjob = at_home)
fjob <- rename(fjob, services_fjob = services)
fjob <- rename(fjob, teacher_fjob = teacher)
fjob <- rename(fjob, other_fjob = other)

reason <- rename(reason, other_reason = other)

guardian <- rename(guardian, other_guardian = other)

data_reg <- cbind(data_reg, mjob, fjob, guardian, reason)

data_reg <- data_reg %>% select(-one_of(c("mjob", "fjob", "guardian", "reason")))

head(data_reg)

set.seed(1234) # set the seed to make the partition reproducible

# 75% of the sample size
smp_size <- floor(0.75 * nrow(data_reg))

train_ind <- sample(seq_len(nrow(data_reg)), size = smp_size)

# creating test and training sets that contain all of the predictors
reg_pred_train <- data_reg[train_ind, ]
reg_pred_test <- data_reg[-train_ind, ]

abs_outcome_train <- absences_outcome[train_ind, ]
abs_outcome_test <- absences_outcome[-train_ind, ]

reg_results <- knn.reg(reg_pred_train, reg_pred_test, abs_outcome_train, k = 17)
print(reg_results)

plot(abs_outcome_test, reg_results$pred, xlab="y", ylab=expression(hat(y)))

#mean square prediction error
mean((abs_outcome_test - reg_results$pred) ^ 2)

#mean absolute error
mean(abs(abs_outcome_test - reg_results$pred))

dev.off()