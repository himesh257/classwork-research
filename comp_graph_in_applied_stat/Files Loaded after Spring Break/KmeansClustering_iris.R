#install.packages(c("cluster", "rattle","NbClust","psych"))
library(datasets)
library(ggplot2)
library(cluster)
library(rattle)
library(NbClust)
library(psych)

#based on Iris Dataset - Clustering using K means
#by Ananya Dutta

#save graphs in pdf
windows(7,7)
  pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/KmeansClustering_iris_Figure.pdf")

head(iris)
str(iris)
describe(iris)

sapply(iris[,-5], var)  #obtain s^2 for each numeric variable

iris_scale <- scale(iris[,1:4])  #compute z scores

library(ggplot2)
ggplot(iris,aes(x = Sepal.Length,y = Sepal.Width, color= Species)) + geom_point()

ggplot(iris,aes(x = Petal.Length,y = Petal.Width, color = Species)) + geom_point()

set.seed(1423)
k.max <- 10
wss<- sapply(1:k.max,function(k){kmeans(iris_scale[,3:4],k,nstart = 20,iter.max = 20)$tot.withinss})
wss
plot(1:k.max,wss, type= "b", xlab = "Number of clusters(k)", ylab = "Within cluster sum of squares")  #scree plot
#choose k=3 based on the scree plot

#another choice for number of clusters is to use the NbClust library which runs
# many experiments and gives a distribution of potential number of clusters

library(NbClust)
#NbClust package provides 26 (documentation says 30) indices for determining the number of clusters and proposes
# to user the best clustering scheme from the different results obtained by varying
# all combinations of number of clusters, distance measures, and clustering methods

nc <- NbClust(iris_scale, min.nc=2, max.nc=15, method="kmeans")

#The final model is built using kmeans and k = 3. The nstartvalue has also been defined as 20 
#which means that R will try 20 different random starting assignments 
#and then select the one with the lowest within cluster variation.

irisCluster <- kmeans(iris_scale[,3:4], 3, nstart = 20)
table(irisCluster$cluster,iris$Species)

clusplot(pam(iris_scale[,3:4],3))

dev.off()