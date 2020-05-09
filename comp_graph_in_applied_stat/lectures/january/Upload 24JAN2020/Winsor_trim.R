#Trimming and Winsorizing of outliers in data

#install.packages("psych")
library(psych)

options (digits=5)

#diameters of ball bearings n=10
diameter <- c(.017 ,.018, .023, .031, .031, .033, .036, .070, .079, .200)  #data 

trim1 <- describe(diameter,trim=0.0)
print(trim1,digits=5)

trim2 <- describe(diameter,trim=0.1)
print(trim2,digits=5)

trim3 <- describe(diameter,trim=0.2)
print(trim3,digits=5)

#Winsorizing
if (FALSE)
{"
Winsorizing function -  The top and bottom trim values are given values of the trimmed and 1- trimmed quantiles. 
winsor(x, trim = 0.2, na.rm = TRUE)
winsor.mean(x, trim = 0.2, na.rm = TRUE)
winsor.means(x, trim = 0.2, na.rm = TRUE)  
winsor.sd(x, trim = 0.2, na.rm = TRUE)  
winsor.var(x, trim = 0.2, na.rm = TRUE)  
x - A data vector, matrix or data frame
trim - Percentage of data to move from the top and bottom of the distributions
na.rm	 -Missing data are removed 
"}

quantile(diameter, prob = c(0.10, 0.90)) #obtain the .10 and .90 quantile of diameter

y <- winsor(diameter, trim=.1) 
diameter
y

winsor.mean(diameter, trim=.1) #Winsorized mean
print(trim2,digits=5)  #compare trimmed mean (0.1) with Winsorized mean (0.1)


