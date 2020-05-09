library(faraway)
data(gala, package="faraway")

#Recall: n=30 islands   Species = number of plant species found on the various Galapagos Islands

#Area - the area of the island (square km)
#Elevation - the highest elevation of the island (m)
#Nearest - the distance from the nearest island (km)
#Scruz - the distance from Santa Cruz island (km)
#Adjacent -the area of the adjacent island (square km)

#see Section 2.6 Example starting on page 17 of 2nd Edition (Section 2.8 Example starting on page 20 of 2nd Edition)
#Peform a multiple regression using the gala data
lmod <- lm(Species ~ Area + Elevation + Nearest + Scruz + Adjacent,data=gala)

summary(lmod)
sumary(lmod)  #uses the sumary function developed by Faraway

#extract X matrix
x <- model.matrix( ~ Area + Elevation + Nearest + Scruz  + Adjacent,gala)  #obtain the X matrix from the model
#print x
x
#note the column of 1s in the X matrix :  Species = B0*1 + B1*Area + B2*Elevation + B3*Nearest + B4*Scruz  + B5*Adjacent + error

#extract y vector
y <- gala$Species
#print y
y

xtx <- (t(x) %*% x)
xtx

xtxi <- solve(t(x) %*% x)
xtxi

betahat <- xtxi %*% t(x) %*% y
betahat

#another way of obtaining betahat
solve(crossprod(x,x),crossprod(x,y))

names(lmod)

lmodsum <- summary(lmod)
names(lmodsum)

lmodsum$residuals

lmodsum$call

sqrt(deviance(lmod)/df.residual(lmod))  #square root of SSE/(df of SSE)
lmodsum$sigma #confirm the number above

xtxi <- lmodsum$cov.unscaled  #find the diagonal elements of inverse of (X'X)

sqrt(diag(xtxi))*60.975   #multiply the square root of each diagonal element of the inverse of (X'X) by sigma_hat

#obtain the estimated standard deviations (standard errors) of the beta coefficients
lmodsum$coef[,2]  #note the use of [ and ] to distinguish from a function that uses ( and )

##--LEAST SQUARES IS ELEGANT--------------------------------------------##

Sys.time()  #time stamps the output

##---------------------------------------------------------------------##
sessionInfo()
Sys.time()