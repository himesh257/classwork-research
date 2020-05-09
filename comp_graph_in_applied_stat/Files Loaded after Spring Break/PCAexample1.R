#PRINCIPAL COMPONENTS ANALYSIS (PCA)

library(faraway)
library(MASS)

#write output to a file, append or overwrite, split to file and terminal
 sink("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/PCAexample_Out.txt",append=FALSE,split=TRUE)

#save graph(s) in pdf
windows(7,7)
 pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/PCAexample_Figure.pdf")

if (FALSE)
{"
R code from page 161 of Faraway Linear Models with R (2nd edition) used
Data set - fat:  dimensions of the human body as measured in a study of 252 men.
"}

data(fat,package="faraway")
head(fat,1L)
nrow(fat)

pairs( ~ neck + chest + abdom + hip + thigh, data=fat, main="Simple Scatterplot Matrix")

pairs( ~ knee + ankle + biceps + forearm + wrist, data=fat,main="Simple Scatterplot Matrix")

#We see these measures are highly correlated.
#Question - there are 13 predictors in the data set (includes age,weight,height) of which 10 are circumference measurements.
#We have 10 highly correlated predictors - there may be less information to be extracted than the number of predictors might suggest.
#Can we reduce the dimensionality of the 10 variables?
#PCA aims to discover this lower dimension of variability in higher dimensional data

cfat <- fat[,9:18]
head(cfat,1L)

if (FALSE)
{"
Suppose all 10 variables are centered - that is neck - mean(neck) , chest - mean(chest, and so on.
1. Find the u1 such that var (u1'X) is maximized subject to u1'u1 = 1.
                                 X is n by k with the 10 centered variables forming the column vectors
2. Find u2 such that var (u2'X) is maximized subject to u1'u2 = 0 and u2'u2 = 1.  u1'u2=0 => orthogonal (independence)
keep going for u3, u4, . . ., u10 (in this case k=10)
for high dimensional data we can stop when the remaining variation is negligible.
"}

#now perform Principal Component Analysis

prfat <- prcomp(cfat)
dim(prfat$rot) # $rot contains the rotation matrix
prfat$rot
dim(prfat$x)  # principal components are found in prfat$x 
summary(prfat)  #the first principal component explains 0.867 of the variation in the predictor data 

round(prfat$rot[,1],2)  #linear combination describing the first principal component
#chest, abdomen, hip, and thigh measures dominate the first principal component
#however, the data are not normalized so the result may be due to larger measures for these variables

#should center and scale prior to performing PCA  - subtract out the mean and divide by the std dev
prfatc <- prcomp(cfat,scale=TRUE)
summary(prfatc)

round(prfatc$rot[,1],2) #describe what this principal component measures

round(prfatc$rot[,2],2) #describe what this principal component measures

#note that the first principal component is orthogonal to the second principal component
t(prfatc$rot[,1]) %*% prfatc$rot[,2]

#principal components analysis can be very sensitive to outliers
#so need to check for outliers - use Mahalanobis which is a measure of the distance of a point
#from the mean that adjusts for the correlation in the data.

#Mahalanobis distance di=sqrt[(x-mu)'(sigma-1)(x-mu)]  , sigma is a measure of covariance
#Use robust measures of center and covariance — these are provided by the cov.rob() function from the MASS package
#If the data are multivariate normal with dimension m, then we expect d2 to follow a chi2 distribution with m df
#Remove outliers or use robust PCA methods

robfat <- cov.rob(cfat)
md <- mahalanobis(cfat, center=robfat$center, cov=robfat$cov)
n <- nrow(cfat);p <- ncol(cfat)
plot(qchisq(1:n/(n+1),p), sort(md), xlab=expression(paste(chi^2,"quantiles")), ylab="Sorted Mahalanobis distances")
abline(0,1)

#now link the predictors to the response in a regression model using PCA
#instead of using the predictors in their original form use the principal components - known as Principal Component Regression or PCR

#model the percentage of body fat that is described by the variable Brozek.
lmoda <- lm(fat$brozek ~ ., data=cfat)  #the '.' after '~' indicates to include all 10 predictors in the data set
summary(lmoda)

#these regression results are hard to interpret because there is indication of collinearity.
vif(lmoda)
#abdomen circumference has a positive effect while hip circumference has a negative effect??

#now regress on the first two principal components
lmodpcr <- lm(fat$brozek ~ prfatc$x[,1:2])
summary(lmodpcr)
#R2 is lower so lose some predictive power
#two PCs are orthogonal.   

#recall the first two PCs
round(prfat$rot[,1],2)
round(prfat$rot[,2],2)

#since the first two PCs still require measuring all 10 circumference variables, examine the first two PCs for possible variables

lmodr <- lm(fat$brozek ~ scale(abdom) + I(scale(ankle)-scale(abdom)), data=cfat)
summary(lmodr)

#We have a simple model that fits almost as well as the ten-predictor model

#Adjusted R-squared:  0.7241  all 10 circumference measures
#Adjusted R-squared:  0.6726  abdom, ankle

##------------------------THE END-----------------------##


dev.off()