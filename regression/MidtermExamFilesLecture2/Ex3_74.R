if (FALSE)
{"
Perform simple linear regression for Ex3.74 page 153
x=number of FACTORS
y=length of stay
"}

library(faraway)  #this command brings in a library of regression functions

#BE SURE TO CHANGE THE DIRECTORIES BELOW TO YOUR DIRECTORIES
#append=FALSE indicates to build a new file
#split=TRUE indicates to send output to file and to the console window
#write output to a file, append or overwrite, split to file and console window
#sink("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 02 28JAN2020/FACTORS_out.txt",append=FALSE,split=TRUE)

#read in the data which is in a csv file
#change the directory below to your directory
ex374 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 02 28Jan2020/FACTORS.csv",header = TRUE)

head(ex374,10L)
ex374
summary(ex374)

mod <- lm(LOS~ FACTORS, ex374)

windows(7,7)
#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 02 28JAN2020/Ex3_74R_out.pdf")
plot(LOS~ FACTORS,ex374)  #keep in mind - R is case sensitive SAS is not
abline(mod)

plot(LOS~ FACTORS,ex374)  
abline(mod)

#another approach
library(ggplot2)

ggplot(ex374,aes(x=FACTORS,y=LOS)) + geom_point(color="red",size=2) + geom_smooth(method=lm, color="blue")
#the plot shows a 95% confidence interval about the regression line - method lm asks for the least squares line

summary(mod)
anova(mod)

names(mod)  #the names function is used to get or set the names of an object
names(summary(mod))

info_mod <- mod  #save information in mod
summary_mod <- summary(mod)  #save summary information in summary_mod

typeof(info_mod)  #indicates the type of vector info_mod is
typeof(summary_mod)  #indicates the type of vector summary_mod is

info_mod$coefficients
summary_mod$r.squared

cor(ex374$FACTORS,ex374$LOS)
R2=(cor(ex374$FACTORS,ex374$LOS))^2
R2

confint(mod)  #95% confidence interval on regression coefficients

new.dat <- data.frame(FACTORS=231)  #creates an observation where FACTORS=231
new.dat

predict(mod, newdata = new.dat, interval = 'confidence')

predict(mod, newdata = new.dat, interval = 'prediction')

##----------------------------------------------------------------##

dev.off() #closes pdf file)


