
#Standardized Beta Coeffcients
library(faraway)  #this command brings in a library of regression functions
library(psych)  #has a describe function that reports out mean and standard deviation along with other useful statistics
#Use quasar data from Exercise 4.96, page 254, 8th edition which is Exercise 4.11, page 186 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex496 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)
ex496

#Focus attention on only REDSHIFT and LINEFLUX
lmod <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX,data=ex496)
summary(lmod)
confint(lmod) #95% confidence intervals on individual regression coefficients  

#install.packages("lm.beta") #may need to install the package, lm.beta
require(lm.beta)

lmod_beta <- lm.beta(lmod)
summary(lmod_beta)

SRFEWIDTH <- scale(ex496$RFEWIDTH)
head(SRFEWIDTH,1L)
describe(ex496$RFEWIDTH)
head(ex496$RFEWIDTH,1L)
(117 - 88.3200)/47.39701  #show the first scaled observation for RFEWIDTH

SREDSHIFT <- scale(ex496$REDSHIFT)
SLINEFLUX <- scale(ex496$LINEFLUX)

ex496new <- data.frame(cbind(ex496$RFEWIDTH,SRFEWIDTH,ex496$REDSHIFT,SREDSHIFT,ex496$LINEFLUX,SLINEFLUX))  #generate a new dataframe
ex496new

slmod <- lm(SRFEWIDTH ~ SREDSHIFT + SLINEFLUX,data=ex496new)
summary(slmod)

#show what lm.beta essentially calculates
require(psych)  #install package if needed
results <- describe(ex496new,fast=TRUE)  #fast=TRUE requests just a few of the available statistics
results

print(results,digits=5)






