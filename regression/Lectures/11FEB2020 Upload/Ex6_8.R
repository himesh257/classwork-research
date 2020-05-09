#R code to demonstrate Variable Selection: stepwise and all possible
#will perform stepwise (forward, backward, stepwise)
#and all possible regressions  k=7 so 2**7 = 128 possible regressions

#this site below has a useful tutorial on Variable Selection in R
#https://rpubs.com/davoodastaraky/subset

library(faraway)  #this command brings in a library of regression functions
#Exercise 6.8 (CLERICAL), page 352, 8th edition which is Exercise 6.6, page 340 7th edition

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex6_8 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 04 11FEB2020/CLERICAL.csv",header = TRUE)
ex6_8   #ignore DAY variable

lmod <- lm(Y ~ X1+X2+X3+X4+X5+X6+X7,data=ex6_8)
summary(lmod)

#you may need to install leaps if you do not have this package on your computer 
#install.packages("leaps") 

require(leaps) #be sure to bring in the package leaps into your current session
#help(leaps) #performs all-subsets regression

#regsubsets is a function available in leaps 
#help(regsubsets) #Model selection by exhaustive search, forward or backward stepwise, or sequential replacement

##run stepwise regression on CLERICAL data##

##Example showing adjusted R2 and R2 for Full Model 
full <- regsubsets(Y ~ X1+X2+X3+X4+X5+X6+X7,nvmax=7,data=ex6_8,intercept=TRUE)
summary.full <- summary(full)

names(summary.full)  #shows what measures are available

summary.full$rsq #note the increase in R2 as variables are entered into model
summary.full$adjr2  #note the decrease in the last adjr2

#generate the best 3 models 
#choices for method are "backward","forward",or "seqrep"
varselection1 <- regsubsets(Y ~ X1+X2+X3+X4+X5+X6+X7,nbest=3,nvmax=7,
    data=ex6_8,intercept=TRUE,
    method="backward")  
show <- summary(varselection1) #the best models are quantified using RSS
show
names(show)
show$cp  #show Cp criterion

#generate the best 3 models 
#choices for method are "backward","forward",or "seqrep"
varselection2 <- regsubsets(Y ~ X1+X2+X3+X4+X5+X6+X7,nbest=3,nvmax=7,
    data=ex6_8,intercept=TRUE,
    method="seqrep")  
show <- summary(varselection2) #the best models are quantified using RSS
show
names(show)
show$rss  #show Residual Sums of Squares criterion

##---------------------------------------------------------------------------#
##now review a function that uses AIC to choose best subsets in a stepwise process##
##you might have to install the MASS package
#install.packages("MASS")

require(MASS)
stepAIC(lmod,direction="both")  #both performs sequential stepwise

##note that "None" represents the current model - no action##
