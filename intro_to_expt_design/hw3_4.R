## Create the two-blocking factor and treatment levels and enter the data 
row = factor(rep(1:5, each = 5))  
col = factor(rep(1:5, times = 5))  
trt = factor(c(1,2,4,3,5,3,5,1,4,2,2,1,3,5,4,4,3,5,2,1,5,4,2,1,3)) 
y   = c(8, 7, 1, 7, 3, 
        11,2, 7, 3, 8,
        4, 9, 10, 1, 5, 
        6, 8, 6, 6, 10,
        4, 2, 3, 8, 8)
ls5by5 = data.frame(row, col, trt, y)


ls5by5    # Check if the data is correct

str(ls5by5)

attach(ls5by5)

trt.means = tapply(y,trt,mean)     # these are the means for each treatment level 

trt.means

# Now we fit the latin square model
ls.fit = lm(y ~ row + col + trt)
plot(resid(ls.fit))
qqnorm(rstandard(ls.fit))
plot(ls.fit)
anova(ls.fit) 
