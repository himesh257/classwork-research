if (FALSE)
{"
Perform simple linear regression for Ex3.89 page 160 of text
x=Breast Height Diameter
y=Height
"}

library(faraway)  #this command brings in a library of regression functions

#read in the data which is in a csv file
#change the directory below to your directory
ex389 <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/WHITESPRUCE.csv",header = TRUE)

ex389
summary(ex389)

mod <- lm(HEIGHT ~ DIAMETER, data=ex389)
plot(HEIGHT ~ DIAMETER,data=ex389)  #keep in mind - R is case sensitive SAS is not
abline(mod)

#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Homework/Ex3_89_graph.pdf")
plot(HEIGHT ~ DIAMETER,data=ex389)  
abline(mod)
dev.off() #closes pdf file)

summary(mod)
anova(mod)

new.dat <- data.frame(DIAMETER=20)  #creates an observation where DIAMETER=20
new.dat

predict(mod, newdata = new.dat, interval = 'confidence')

predict(mod, newdata = new.dat, interval = 'prediction')





