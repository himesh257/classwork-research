library(faraway)
if (FALSE)
{"
data on 38 driver measurements regarding seat positioning.  
age(yr), weight(lb), height(cm), height in shoes(cm), seated height,
arm length, thigh length, lower leg length, hipcenter - horizontal distance of the midpoint
of the hips from a fixed location in the car in millimeters
"}

data(seatpos, package="faraway")
head(seatpos)
nrow(seatpos)
seatpos

#save graph in pdf
 pdf(file="C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Ridge_Lasso/collin_seatpos_Figure.pdf")

#Full Model
lmod <- lm(hipcenter ~ ., seatpos)
summary(lmod)
#the results show R2 is fairly high but none of the variables is significant
#is this due to collinearity?

#Look at the pairwise relationship of variables
# Basic Scatterplot Matrix
pairs(~hipcenter+Age+Weight+HtShoes+Ht+Seated+Arm+Thigh+Leg,data=seatpos, 
    main="Simple Scatterplot Matrix")

#now look at the pairwise correlations
round(cor(seatpos[,-9]),2)
#there are some pairwise correlations >= .8

#now look at eigenvalues  Ax=lambda*x
#eigenvalue:  Ax=lambda*x  x is an eigenvector of matrix A and lambda is an eigenvalue of A
x <- model.matrix(lmod)[,-1]
XtX=t(x) %*% x  #X'X
XtX
e <- eigen(t(x) %*% x)  # eigenvalues of X'X
e$val
sqrt(e$val[1]/e$val)
#some of the square roots of the largest eigenvalue to the other eigenvalues (condition number) are large 
#indicates collinearity exists in several linear combinations of the Xs.

#now look at Age regressed on the other Xs and compute VIF(Age)
summary(lm(x[,1] ~ x[,-1]))$r.squared
1/(1-0.49948)

#now look at all the VIFs
require(faraway)
vif(x)  #VIFs  

#measure hipcenter is difficult - see what happens if we add a random perturbation to the size of the response
lmod1 <- lm(hipcenter+10*rnorm(38) ~ ., seatpos)  #adds 10*standard normal to each response
summary(lmod1)
#R2 and SE are similar in the two models but the coefficients change sign due to high collinearity

#consider just the correlations of the length variables
round(cor(x[,3:8]),2)
#choose only 1 of these since they are all highly correlated.  Pick Ht

lmod2 <- lm(hipcenter ~ Age + Weight + Ht, seatpos)
summary(lmod2)
#R2 and adjusted R2 are similar to the Full Model but fewer predictors used

dev.off()