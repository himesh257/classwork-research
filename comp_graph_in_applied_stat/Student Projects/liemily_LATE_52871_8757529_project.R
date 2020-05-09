library(faraway)
library(psych)
data(epilepsy, package='faraway')

epilepsy
epilepsy$seizures
range(epilepsy$seizures)
mean(epilepsy$seizures)
median(epilepsy$seizures)
#mean and median vary greatly

epilepsy$age
range(epilepsy$age)
mean(epilepsy$age)
median(epilepsy$age)
#mean and median are quite similar

boxplot(epilepsy$seizures, main="boxplot of seizures")
boxplot(epilepsy$age, main="boxplot of age")

######
#trim mean of seizures
mean(epilepsy$seizures, trim = .05)
mean(epilepsy$seizures,trim = .1)
winsor.mean(epilepsy$seizures, trim=.05)
winsor.mean(epilepsy$seizures, trim=.1)

sd(epilepsy$seizures)
winsor.sd(epilepsy$seizures, trim=.05)
winsor.sd(epilepsy$seizures,trim=.1)

#trim mean of age
mean(epilepsy$age, trim = .05)
mean(epilepsy$age,trim = .1)
winsor.mean(epilepsy$age, trim=.05)
winsor.mean(epilepsy$age, trim=.1)
####
describe(epilepsy)
quantile(epilepsy$seizures, prob = c(0.10, 0.90)) #obtain the .10 and .90 quantile of epilepsy

####
outliers <- boxplot(epilepsy$seizures,plot=FALSE)$out

x<-epilepsy
x<-x[-which(x$seizures %in% outliers),]
x
describe(x)
boxplot(x$seizures, main="boxplot of seizures, trimmed")

