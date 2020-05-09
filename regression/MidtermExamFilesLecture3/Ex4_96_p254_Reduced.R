library(faraway)  #this command brings in a library of regression functions

#Exercise 4.96 (quasars), page 254, 8th edition which is Exercise 4.11, page 186 7th edition
#Reduced versus Full Model Approach
#Part (f) of exercise asks to test H0: B1=B2=B3=B4=0

#read in the data which is in a csv file
#change the directory below to your directory
#note header=TRUE below tells R that the first row of the csv file contains variable names
ex496 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 03 04FEB2020/QUASAR.csv",header = TRUE)
ex496

#See page 232 of text  F-Test for Comparing Nested Models
#There is a function in R that performs Reduced vs Full Model testing
#Preview for part f - Full model contains all Xs  Reduced model is model restricted to H0 of interest

#Full model (also known as the Complete model)
lmodfull <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)
summary(lmodfull)

#Reduced model under H0: B1=B2=B3=B4=0 (write model following H0)
lmodreduced <- lm(RFEWIDTH ~ ABSMAG,data=ex496)

anova(lmodfull)
anova(lmodreduced)
anova(lmodreduced,lmodfull)  #place the reduced model first and the full model second
#computation: F*= ((SSEReduced - SSEFull)/(ErrordfReduced - ErrordfFull)) /MSE(Full)
#which under H0 ~ F with numerator df = (ErrordfReduced - ErrordfFull) and denominator df=n-p=df for Full Model
# F*=((33836 - 4750)/(23-19))/(4750/19)  = (29086/4)/250 = 29.086 compared to F(4,19)

#Some more examples

####Global test H0: B1=B2=B3=B4=B5=0
lmodreduced <- lm(RFEWIDTH ~ 1, data=ex496)
anova(lmodreduced, lmodfull)

rss0 <- deviance(lmodreduced)
rss1 <- deviance(lmodfull)

(df0 <- df.residual(lmodreduced))
(df1 <- df.residual(lmodfull))

(fstat <- ((rss0-rss1)/(df0-df1))/(rss1/df1))
1-pf(fstat, df0-df1, df1)

####Testing one variable (or predictor)
lmodreduced <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+AB1450, data=ex496)
#Test H0:B5=0  coefficient of ABSMAG is equal to 0
anova(lmodreduced,lmodfull)

#interpret the test for the coefficeint of ABSMAG
summary(lm(RFEWIDTH ~ ABSMAG, data=ex496))  #note - ABSMAG by itself is significant

####Testing a pair of variables or predictors####
##Test HO:B1=B2=0
lmodreduced <- lm(RFEWIDTH ~ LUMINOSITY+AB1450+ABSMAG, data=ex496)
anova(lmodreduced, lmodfull)

####Testing a subspace (a pair of predictors have equal Bs)####
##Test H0:B4=B5
lmodreduced <- lm(RFEWIDTH ~ REDSHIFT+LINEFLUX+LUMINOSITY+I(AB1450+ABSMAG),data=ex496)

#note the function I() can be used to bracket those portions of a model formula where 
#the operators are used in their arithmetic sense. For example, in the 
#formula y ~ a + I(b+c), the term b+c is to be interpreted as the sum of b and c. 

anova(lmodreduced, lmodfull)

####Testing a single predictor equal to a given value####
##Test H0:B1=100
lmodreduced <- lm(RFEWIDTH ~ offset(100*REDSHIFT)+LINEFLUX+LUMINOSITY+AB1450+ABSMAG,data=ex496)
anova(lmodreduced,lmodfull)
coefficients(lmodfull)  

tstat <- (113.71050-100)/102.19  #this is just (B1hat - 100)/std err of B1hat from the Full model
2*(1-pt(tstat,19))  #  2 x tail probability of the observed tstat
tstat^2  #t-squared is the same as an F

##------End Inference------##
