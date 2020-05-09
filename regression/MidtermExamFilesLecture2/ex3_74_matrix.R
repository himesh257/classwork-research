library(faraway)  #this command brings in a library of regression functions
if (FALSE)
{"
Perform the matrix approach to a simple linear regression for Ex3.74 page 153
x=number of FACTORS
y=length of stay
"}

#BE SURE TO CHANGE THE DIRECTORIES BELOW TO YOUR DIRECTORIES
#append=FALSE indicates to build a new file
#split=TRUE indicates to send output to file and to the console window
#write output to a file, append or overwrite, split to file and console window
#sink("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 02 28JAN2020/ex374_matrix.txt",append=FALSE,split=TRUE)

#read in the data which is in a csv file
#change the directory below to your directory
ex374 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 02 28Jan2020/FACTORS.csv",header = TRUE)

mod <- lm(LOS ~ FACTORS, ex374)

summary(mod)
anova(mod)

x <- model.matrix( ~ FACTORS,ex374)
head(x,10L)

#or alternatively

x <- as.matrix(cbind(1,ex374$FACTORS)) # the "1" in the first position of cbind creates a column of 1s
head(x,10L)	

y <- ex374$LOS  #create the vector of responses
y

xtx <- (t(x) %*% x) #compute xtx
xtx

xtxi <- solve(t(x) %*% x)  #compute XPX inverse
xtxi

betahat <- xtxi %*% t(x) %*% y
betahat

solve(crossprod(x,x),crossprod(x,y))  #more accurate way to obtain betahat 

names(mod)
modsum <- summary(mod)  
names(modsum)

sigma <- sqrt(deviance(mod)/df.residual(mod))  #estimate sigma
sigma
modsum$sigma

xtxi_compare <- modsum$cov.unscaled  #xtxi inverse can be found as one of the elements of summary(mod)

xtxi_compare
xtxi

sqrt(diag(xtxi))*sigma #should provide the standard errors of the Beta_hat coefficents
summary(mod)






