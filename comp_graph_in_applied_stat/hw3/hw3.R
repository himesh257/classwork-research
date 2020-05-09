poisson <-rpois(1000,2.4)
pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw3/poisson.pdf") 
distplot(poisson, type="poisson")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw3/binomial.pdf") 
distplot(poisson, type="binomial")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw3/nbinomial.pdf") 
distplot(poisson, type="nbinomial")
dev.off()

pdf(file="C:/Users/buchh/OneDrive/Desktop/cmp and graph in stat/hw3/histogram.pdf") 
x <- poisson
h<-hist(x, breaks=10, col="red", xlab=" ", main="Histogram with Normal Curve")
xfit<-seq(min(x),max(x),length=40)
yfit<-dnorm(xfit,mean=mean(x),sd=sd(x))
yfit <- yfit*diff(h$mids[1:2])*length(x)
lines(xfit, yfit, col="blue", lwd=2)
dev.off()