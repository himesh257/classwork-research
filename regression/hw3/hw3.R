library(faraway)  #this command brings in a library of regression functions
#Exercise 6.8 (CLERICAL), page 352, 8th edition which is Exercise 6.6, page 340 7th edition

file1 <- read.csv(file="C:/Users/buchh/OneDrive/Desktop/regression/hw3/HW03_data.csv",header = TRUE)
file1
lmod1 <- lm(y ~ x1+x2,data=file1)
summary(lmod1)

lmodreduced <- lm(y ~ x1,data=file1)
summary(lmodreduced)

lmodreduced1 <- lm(y ~ x1^2+x2^2,data=file1)
summary(lmodreduced1)
