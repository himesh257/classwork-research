
#BE SURE TO CHANGE THE DIRECTORIES BELOW TO YOUR DIRECTORIES
#write output to a file, append or overwrite, split to file and terminal
# sink("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 08 14Feb2020/ChallengerR.txt",append=FALSE,split=TRUE)
        

#save graph in pdf
# pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 08 14Feb2020/ChallengerR.pdf")

if (FALSE)
{"
O-Ring data analyzed using a logistic model in R
"}
#read in the data which is in a csv file
oring <- read.csv("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 08 14Feb2020/Challenger.csv",header = TRUE)
oring

nrow(oring)
summary(oring)

#first plot the data
plot(TD~Temp,data=oring,xlab="Temperature",ylab="Thermal Distress")  
#-----------------------------------------------------------------#

logistic <- glm(TD ~ Temp,data=oring,family=binomial(link='logit'))
summary(logistic)
confint.default(logistic) 

plot(TD~Temp,data=oring,xlab="Temperature",ylab="Thermal Distress")
lines(oring$Temp,logistic$fitted, type="l", col="red")
title(main="O-Ring Data with Fitted Logistic Regression Line")

#install.packages("aod")  #wald.test is a function found in the package aod
require(aod)
wald.test(b = coef(logistic), Sigma = vcov(logistic), Terms = 2)

#Assessing the predictive ability of the model
#In the steps above, we briefly evaluated the fitting of the model
#would like to see how the model is doing when predicting y
#By setting the parameter type='response', R will output probabilities in the form of P(y=1|X)
#Our decision boundary will be 0.5. If P(y=1|X) > 0.5 then y = 1 otherwise y=0.
#Note that for some applications different thresholds could be a better option.

fitted.results <- predict(logistic,data=oring,type='response') #should actually use new data
fitted.results <- ifelse(fitted.results > 0.5,1,0)
fitted.results

misClasificError <- mean(fitted.results != oring$TD)
misClasificError

print(paste('Accuracy',1-misClasificError))

dev.off()