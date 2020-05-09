#perform k-means Clustering following this RPubs publication
#  https://rpubs.com/violetgirl/201598 by Maria P. Frushicheva  11AUG2016

#install.packages(c("cluster", "rattle","NbClust","psych"))
library(cluster)
library(rattle)
library(NbClust)
library(psych)

data(wine, package="rattle")
head(wine,3L)
str(wine)

#Remove the first column from the data and scale it using the scale() function
df <- scale(wine[,-1])  #compute z scores

head(wine,1L)
head(df,1L)
describe(wine)

(14.23-13.00)/0.81  #check z score for Alcohol observation #1

#save graph in pdf
 pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/Output/KmeansClustering_Figure.pdf")

#A plot of the total within-groups sums of squares against the number
# of clusters in a K-means solution can be helpful. A bend in the graph
# can suggest the appropriate number of clusters.
# wss is the within groups sum of squares

wssplot <- function(data, nc=15, seed=1234){
           wss <- (nrow(data)-1)*sum(apply(data,2,var))
                  for (i in 2:nc){
                  set.seed(seed)
                    wss[i] <- sum(kmeans(data, centers=i)$withinss)}
              plot(1:nc, wss, type="b", xlab="Number of Clusters",
                  ylab="Within groups sum of squares")
              wss
       }

wssplot(df)

#How many clusters does this method suggest?
#Why does this method work? What’s the intuition behind it?
#Look at the code for wssplot() and figure out how it works

#plot suggests the use of 3 clusters

#another choice for number of clusters is to use the NbClust library which runs
# many experiments and gives a distribution of potential number of clusters

library(NbClust)
#NbClust package provides 26 (documentation says 30) indices for determining the number of clusters and proposes
# to user the best clustering scheme from the different results obtained by varying
# all combinations of number of clusters, distance measures, and clustering methods

set.seed(1234)
nc <- NbClust(df, min.nc=2, max.nc=15, method="kmeans")

#there are 26 criteria that are used by NbClust - table them 
table(nc$Best.n[1,])

set.seed(1234)
fit.km <- kmeans(df, centers=3,  nstart=25)
fit.km$size

table(fit.km$cluster,wine$Type)

#clusplot uses PCA to draw the data. It uses the first two principal
# components to explain the data 
clusplot(pam(df,3))


dev.off()

