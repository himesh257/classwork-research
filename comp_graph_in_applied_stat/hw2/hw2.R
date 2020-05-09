binom <-rbinom(1000,30,0.2)
library("grid")
library("vcd")
pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw2/poisson.pdf") 
distplot(binom, type="poisson")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw2/binomial.pdf") 
distplot(binom, type="binomial")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw2/nbinomial.pdf") 
distplot(binom, type="nbinomial")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw2/histogram.pdf") 
x <-binom
h<-hist(x, breaks=10, col="red", xlab=" ", main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)
dev.off()




