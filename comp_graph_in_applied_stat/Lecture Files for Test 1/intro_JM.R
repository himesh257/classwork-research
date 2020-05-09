#this is a comment line in R
#you need to install package faraway onto your computer (just need to do this once for your computer)
#install.packages("faraway")
library(faraway) #loads the library faraway into the current session
if (FALSE)
{"
This syntax can be used to create an entire paragraph as a comment.
Can not include text with quotes
"}

windows(7,7)

#save graphics output in a pdf file
pdf(file="C:/users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Lecture 01 21Jan2020/intro_JMR_out.pdf")
dummy <- rnorm(1000,mean=3, sd=1)
summary(dummy)

#what does the function rnorm do?
help(rnorm)

#list all data sets that are available from packages on your computer
#even from those libraries not loaded
data(package = .packages(all.available = TRUE)) 

#use data(package= "faraway") to list all data sets that are available in the faraway package
data(package= "faraway")

#obtain more information on the AirPassengers data set
#AirPassengers              Monthly Airline Passenger Numbers 1949-1960

head(AirPassengers)  #lists the first 6 observations
summary(AirPassengers)  #provides a 5-number summary

#need help to understand the details of the summary function?
help("summary")

example("summary")  #provide an example of the use of the summary function

#creating a vector - numeric					
gender <- c(1,2,2,1,2,2,1,1,1,2,NA,2)  #NA is Not Available and is used to represent missing data in R 
print(gender)
gender
table (gender)

gender <- c("m","f","f","m","f","f","m","m","m","f",NA,"f") #creating a vector - character
gender
table (gender)

#data frames in R are essentially data sets where 
#the columns are called vectors, variables, or just columns
#The rows are called observations, cases, or just rows

#Example: we will create a data frame (data set) 
#with 6 variables (workshop gender q1 q2 q3 q4) and 8 observations 

workshop <- c(1, 2, 3, 4, 1, 2, 3, 4)
workshop <- factor(workshop,levels = c(1,2,3,4),labels = c("R","SAS","SPSS","Stata"))

gender <- c("f", "f", "f", NA, "m", "m", "m", "m")
gender <- factor(gender) #search for "Factors in R" in www.rseek.org

q1 <- c(1, 2, 2, 3, 4, 5, 5, 4) #responses to Question 1 from attendees of Workshops 
q2 <- c(1, 1, 2, 1, 5, 4, 3, 5) #responses to Question 2 from attendees of Workshops 
q3 <- c(5, 4, 4,NA, 2, 5, 4, 5) #responses to Question 3 from attendees of Workshops 
q4 <- c(1, 1, 3, 3, 4, 5, 4, 5) #responses to Question 4 from attendees of Workshops 

mydata <- data.frame(workshop, gender, q1, q2, q3, q4)
mydata

names(mydata)  #provides variable names/column names
row.names(mydata)  #observations

#creating an 8 x 4 matrix of responses in R using the cbind function
help(cbind)

mymatrix <- cbind(q1, q2, q3, q4)
mymatrix

#now for another example using a dataset in the author library

library(faraway)
data(pima, package="faraway")
head(pima)

nrow(pima)
summary(pima)

newdia <- sort(pima$diastolic)  #places the sorted diastolic observations into new variable newdia
newdia

#assign missing values to impossible values - diastolic of 0 is not possible
pima$diastolic[pima$diastolic == 0]  <- NA
pima$glucose[pima$glucose == 0] <- NA
pima$triceps[pima$triceps == 0]  <- NA
pima$insulin[pima$insulin == 0] <- NA
pima$bmi[pima$bmi == 0] <- NA

pima$test <- factor(pima$test)
summary(pima$test)

levels(pima$test) <- c("negative","positive")
summary(pima)

hist(pima$diastolic,xlab="Diastolic",main="")


hist(pima$diastolic,xlab="Diastolic",main="")

plot(density(pima$diastolic,na.rm=TRUE),main="")  #plot of empirical density 

plot(diabetes ~ diastolic,pima) #scatterplot diabetes measure versus diastolic blood pressure

plot(diabetes ~ test,pima) #generates box plot

boxplot(diabetes~test,data=pima, main="Boxplot Example",xlab="Test", ylab="Diabetes")

#install.packages("ggplot2")  #ggplot2 is a sophisticated plotting library

library(ggplot2)  #loads ggplot2 library into the current session

ggplot(pima,aes(x=diastolic))+geom_histogram(col="red",fill="green")

ggplot(pima,aes(x=diastolic))+geom_density(col="red")

ggplot(data=pima,aes(x=diastolic)) + geom_histogram(aes(y =..density..), 
      breaks=seq(0, 125, by = 5), 
      col="red", 
      fill="green", 
      alpha = .2) + geom_density(col="red") + 
  labs(title="Histogram for Diastolic") +
  labs(x="Diastolic", y="Count")

ggplot(pima,aes(x=diastolic,y=diabetes))+geom_point()

ggplot(pima,aes(x=diastolic,y=diabetes,shape=test))+geom_point()+theme(legend.position = "top", legend.direction = "horizontal")

ggplot(pima,aes(x=diastolic,y=diabetes)) + geom_point(size=1) + facet_grid(~ test)

data(manilius, package="faraway")
head(manilius)
(moon3 <- aggregate(manilius[,1:3],list(manilius$group), sum))
solve(cbind(9,moon3$sinang,moon3$cosang), moon3$arc)
lmod <- lm(arc ~ sinang + cosang, manilius)
coef(lmod)

#I need to find the data set below
#data(GaltonFamilies, package="HistData")
#OK - need to install package HistData

#install.packages("HistData")
require(HistData)  #loads the HistData package into the current session

#simple code to generate a scatter plot and draw a straight line through the data
plot(childHeight ~ midparentHeight, GaltonFamilies)
lmod <- lm(childHeight ~ midparentHeight, GaltonFamilies)
abline(lmod)
coef(lmod)

##--------------------------------------------------------------------##

dev.off