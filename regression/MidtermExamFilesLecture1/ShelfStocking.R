library(faraway)  #this command brings in a library of regression functions
if (FALSE)
{"
Perform regression on shelf stocking data - R is case sensitive.
x=number of cases of bottled water that need stocking on shelves in a supermarket
y=time (minute) that it takes to stock the bottled water
"}

#BE SURE TO CHANGE THE DIRECTORIES BELOW TO YOUR DIRECTORIES
#append=FALSE indicates to build a new file
#split=TRUE indicates to send output to file and to the console window
#write output to a file, append or overwrite, split to file and console window
#sink("C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 01 21JAN2020/ShelfStocking.txt",append=FALSE,split=TRUE)

#read in the data which is in a csv file
#change the directory below to your directory
Shelf <- read.csv(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 01 21Jan2020/ShelfStockingdata.csv",header = TRUE)

head(Shelf)
Shelf
summary(Shelf)

lmod <- lm(time_y ~ cases_x, Shelf)
plot(time_y ~ cases_x,Shelf)  
abline(lmod)

windows(7,7)
#save graph in pdf
pdf(file="C:/Users/jmard/Desktop/RegressionMethodsSpring2020/Lecture 01 21JAN2020/ShelfStockingR_out.pdf")
plot(time_y ~ cases_x,Shelf)  
abline(lmod)

summary(lmod)
anova(lmod)
summary(predict(lmod))
summary(residuals(lmod))
ei <-resid(lmod)
summary(ei)
max(ei)
min(ei)

dev.off() #closes pdf file


