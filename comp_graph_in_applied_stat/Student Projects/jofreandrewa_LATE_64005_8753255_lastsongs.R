library(ggplot2)
library(reshape2)
library(dplyr)
library(tidyverse)
library(treemap)
library(fmsb)
library(reshape)
library(MASS)
library(vcd)
library(wordcloud)
library(SnowballC)
library(RColorBrewer)
library(ggcorrplot)
spotify2019<-read.csv("/users/andrewjofre/downloads/last400songs.csv")
pdf("last400.pdf")
spotify2019$danceability<- spotify2019$danceability
spotify2019$energy<- spotify2019$energy
spotify2019$speechiness<- spotify2019$speechiness
spotify2019$acousticness<- spotify2019$acousticness
spotify2019$instrumentalness<- spotify2019$instrumentalness
spotify2019$liveness<- spotify2019$liveness
spotify2019$valence<- spotify2019$valence



### Graph and Analysis of popular bpms in the Top 100 songs ###

# bpm classification
spotify2019$bpmc[spotify2019$bpm >= 66 & spotify2019$bpm <76] <- "Adagio" 
spotify2019$bpmc[spotify2019$bpm >= 76 & spotify2019$bpm <108] <- "Andante" 
spotify2019$bpmc[spotify2019$bpm >= 108 & spotify2019$bpm <120] <- "Moderato" 
spotify2019$bpmc[spotify2019$bpm >= 120 & spotify2019$bpm <156 ] <- "Allegro" 
spotify2019$bpmc[spotify2019$bpm >= 156 & spotify2019$bpm <176] <- "Vivace" 
spotify2019$bpmc[spotify2019$bpm >= 176 ] <- "Presto" 

spotify2019$tlabel[spotify2019$bpm >= 66 & spotify2019$bpm <76] <-" 66- 76"
spotify2019$tlabel[spotify2019$bpm >=  76 & spotify2019$bpm <108] <- "76-108" 
spotify2019$tlabel[spotify2019$bpm >= 108 & spotify2019$bpm <120] <- "108- 120" 
spotify2019$tlabel[spotify2019$bpm >= 120 & spotify2019$bpm <156 ] <- "120 -156" 
spotify2019$tlabel[spotify2019$bpm >= 156 & spotify2019$bpm <176] <- "156-176" 
spotify2019$tlabel[spotify2019$bpm >= 176 ] <- "> 176" 

bpmC <- group_by(spotify2019, bpmc ,tlabel )
bpmC2 <- dplyr::summarise(bpmC,  count=n())
bpmC2 <- arrange(bpmC2, desc(count))

bpmBar<- ggplot(data=bpmC2, aes(x=bpmc, y=count))+geom_bar(aes(y=count),stat="identity", alpha=0.8,fill="skyblue" )+ ylab("Count")+ xlab("bpm Type")+ggtitle("What is the most popular bpm type? ")+
  geom_text(aes(label=tlabel), vjust=1, color="maroon", size=3.5)+ theme_minimal()
bpmBar


mydata <- spotify2019[, c(4,5,6,7,8,9,10,11,12,13,14)]
head(mydata)
cormat <- round(cor(mydata),2)
head(cormat)

library(reshape2)

melted_cormat <- melt(cormat)
head(melted_cormat)

library(ggplot2)




library(ggplot2)

coord_fixed()

### Bootstrap Correlation Technique ####



assignment2 <- function(mydata,x.index,y.index,nboot,confidence) {
  
  par(mfrow=c(1,1))
  smsp.strcv<-smooth.spline(mydata[[x.index]],mydata[[y.index]])
  smspcv.resid<-mydata[[y.index]]-approx(smsp.strcv$x,smsp.strcv$y,mydata[[x.index]])$y
  sd.resid<-sqrt(sum(smspcv.resid^2)/(length(mydata[[1]]) -smsp.strcv$df))
  stud.resid<-smspcv.resid/sd.resid
  D<-ks.test(stud.resid,pnorm)$statistic
  my.smooth<-approx(smsp.strcv$x,smsp.strcv$y,mydata[[x.index]])$y
  str0 <- list(D=D,raw.resid=smspcv.resid,sd.resid=sd.resid,smooth=my.smooth)
  
  smooth.dist<-NULL
  base.smooth<-str0$smooth
  base.sd<-str0$sd.resid
  base.resid<-str0$raw.resid
  my.bootdata<-mydata
  n1<-length(base.smooth)
  
  for(i in 1:nboot){
    bres<-sample(base.resid,length(base.resid),replace=T)
    boot.dat<-((base.smooth+bres))
    
    my.bootdata[[y.index]]<-boot.dat
    smsp.strcv<-smooth.spline(my.bootdata[[x.index]],(my.bootdata[[y.index]]))
    smspcv.resid<-(my.bootdata[[y.index]])-approx(smsp.strcv$x,smsp.strcv$y,my.bootdata[[x.index]])$y
    sd.resid<-sqrt(sum(smspcv.resid^2)/(length(my.bootdata[[1]]) -smsp.strcv$df))
    stud.resid<-smspcv.resid/sd.resid
    
    D<-ks.test(stud.resid,pnorm)$statistic
    my.smooth<-approx(smsp.strcv$x,smsp.strcv$y,my.bootdata[[x.index]])$y
    bstr0 <- list(D=D,raw.resid=smspcv.resid,sd.resid=sd.resid,smooth=my.smooth)
    boot.smooth<-bstr0$smooth
    smooth.dist<-rbind(smooth.dist,boot.smooth-base.smooth)
  }
  
  # n1 times (Which is the length of the data set - 37, 37 observations in the data)
  n1<-length(smooth.dist[1,])
  alpha<-1-confidence
  LB<-NULL
  UB<-NULL
  
  
  for(i in 1:n1){
    s1<-sort(smooth.dist[,i])
    n2<-length(s1)
    v1<-c(1:n2)/n2
    
    
    bvec<-approx(v1,s1,c(alpha/2,1-alpha/2))$y
    LB<-c(LB,base.smooth[i]-bvec[2]) 
    UB<-c(UB,base.smooth[i]-bvec[1])
  }
  
  
  plot(rep(mydata[[x.index]],4),c(LB,base.smooth,UB,mydata[[y.index]]),xlab="X",ylab="Y",type="n")
  
  
  lines(smooth.spline(mydata[[x.index]],mydata[[y.index]],df=2),col=4)  
  
  points(mydata[[x.index]],mydata[[y.index]])
  
  o1<-order(mydata[[x.index]])
  
  lines(mydata[[x.index]][o1],LB[o1],col=2)
  lines(mydata[[x.index]][o1],UB[o1],col=2)
  
  
  lines(mydata[[x.index]][o1],base.smooth[o1],col=3)
}

# Commands used to generate the correlations between the following factors: 
#Danceability and Energy
assignment2(spotify2019,7,6,1000,0.95)
#Danceability and Loudness
assignment2(spotify2019,7,8,1000,0.95)
#Danceability and Acousticness
assignment2(spotify2019,7,12,1000,0.95)
#Danceability and Valence
assignment2(spotify2019,7,10,1000,0.95)
#Danceability and bpm
assignment2(spotify2019,7,5,1000,0.95)
#Loudness and Energy
assignment2(spotify2019,8,6,1000,0.95)
#Loudness and Liveness
assignment2(spotify2019,8,9,1000,0.95)
#Loudness and Valence
assignment2(spotify2019,8,10,1000,0.95)
#Energy and Acousticness
assignment2(spotify2019,6,12,1000,0.95)
#Energy and Valence
assignment2(spotify2019,6,10,1000,0.95)
#Energy and bpm
assignment2(spotify2019,6,5,1000,0.95)


dev.off()


