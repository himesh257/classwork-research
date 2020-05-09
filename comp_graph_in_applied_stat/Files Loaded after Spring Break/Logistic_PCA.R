#https://cran.r-project.org/web/packages/logisticPCA/vignettes/logisticPCA.html

if (FALSE)
{"
An Introduction to the logisticPCA R Package Andrew J. Landgraf 2016-03-13

Logistic Principal Component Regression
United States Congressional Voting Records 1984
This data set includes votes for each of the U.S. House of Representatives Congressmen on the 
 16 key votes identified by the Congressional Quarterly Almanac (CQA). The CQA lists nine different types 
 of votes: voted for, paired for, and announced for (these three simplified to yea), voted against, paired against, and announced 
 against (these three simplified to nay), voted present, voted present to avoid conflict of interest, 
 and did not vote or otherwise make a position known (these three simplified to an unknown disposition).
"}

#perform PCA on the 16 (0,1) variables in the house_votes84 data set in an attempt to reduce the dimension

library(psych)  #has a dummy.code function
library(logisticPCA)
library(ggplot2)
data("house_votes84")
str(house_votes84)

#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/OneDrive/Desktop/Computing and Graphics in Applied Statistics2020/Output/Logistic_PCA_Figure.pdf")

#We split the data into training and test sets. We partition 75% of the data 
# into the training set and the remaining 25% into the test set.

set.seed(1234) # set the seed to make the partition reproducible
# 75% of the sample size
smp_size <- floor(0.75 * nrow(house_votes84))

#partition the predictors into training and test
train_ind <- sample(seq_len(nrow(house_votes84)), size = smp_size)
# creating test and training sets that contain all of the predictors
class_pred_train <- house_votes84[train_ind, ]
class_pred_test <-  house_votes84[-train_ind, ]

#partition the outcome into training and test
democrat <- dummy.code(row.names(house_votes84))[,1]
democrat_train <- democrat[ train_ind]
democrat_test <-  democrat[-train_ind]

table(democrat)
table(democrat_train)
table(democrat_test)

#For logistic PCA, we want to first decide which m to use with cross validation. 
# We are assuming k = 2 and trying different m's from 1 to 10.
# Alternative formulation of logistic PCA has an additional parameter m, 
# which is the value to approximate the saturated model.

logpca_cv = cv.lpca(class_pred_train, ks = 2, ms = 1:10)
plot(logpca_cv)

logpca_model = logisticPCA(class_pred_train, k = 2, m = which.min(logpca_cv))

party = rownames(class_pred_train)

plot(logpca_model, type = "scores") + geom_point(aes(colour = party)) + 
  ggtitle("Logistic PCA") + scale_colour_manual(values = c("blue", "red"))

class_pred_train <- cbind(class_pred_train,democrat_train)
class_pred_test  <- cbind(class_pred_test, democrat_test)

class_pred_train <- data.frame(class_pred_train)
class_pred_test  <- data.frame(class_pred_test)

PCAdata <- data.frame(democrat_train,logpca_model$PCs)

logisticPCs <- glm(democrat_train ~ X1 + X2,family=binomial(logit),data=PCAdata)
summary(logisticPCs)

library(pROC)
#generate ROC curve
ROCresult <- roc(democrat_train ~ logisticPCs$fitted)
plot(ROCresult, legacy.axes = TRUE)
names(ROCresult)
ROCresult$auc

library(caret)
predicted.party <- ifelse(logisticPCs$fitted > 0.5,1,0)  #predicted.party = democrat if predicted prob > 0.50, 0 otherwise
predicted.party <- as.factor(predicted.party)
democrat_train <- as.factor(democrat_train)
confusionMatrix(democrat_train,predicted.party)  #found in the caret library

#Finally, suppose after fitting the data, the voting record of a new congressman appears. 
#The predict function provides predicted probabilities or natural parameters for that new congressman, 
#based on the previously fit model and the new data. In addition, there is an option to predict the PC scores 
#on the new data. This may be useful if the low-dimensional scores are inputs to some other model.

X <- as.matrix(nrow=(nrow(class_pred_test)),ncol=16,x=class_pred_test[,-17])

newPredict <- predict(logpca_model, X, type = "PCs")

PCAdata <- data.frame(democrat_test,newPredict)

#Use the beta(hats) from the logistic model with the training PC1 and PC2
b0 <- 1.56691
b1 <- -0.33115
b2 <- 0.37203

#define the fit on the test data
fit <- b0 + (b1*PCAdata$X1) + (b2*PCAdata$X2)

testfit.p <- exp(fit)/(1+exp(fit))

class_testfit.p <- ifelse(testfit.p > 0.5,1,0)  #predicted.party = democrat if predicted prob > 0.50, 0 otherwise
predicted.party <- as.factor(class_testfit.p)
democrat_test <- as.factor(democrat_test)
confusionMatrix(democrat_test,predicted.party) 

  
dev.off()