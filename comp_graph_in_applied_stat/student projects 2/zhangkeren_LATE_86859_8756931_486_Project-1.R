##################486 project by Keren Zhang, Ailin Zhang, Zihan Jin#########################

library(ggplot2)
library(forcats)
library(reshape2)
library(RColorBrewer)
turnip<-read.csv("Turnips Prices.csv")
turnip3<-read.csv("Turnips Prices3.csv")
turnip4<-read.csv("Turnips Prices4.csv")


#line chart
Time<-c("Sun AM","Mon AM","Mon PM","Tues AM","Tues PM","Wed AM","Wed PM","Thur AM","Thur PM","Fri AM","Fri PM","Sat AM","Sat PM")
Turnip.1<-c(turnip$Turnips.1)
Turnip.2<-c(turnip$Turnips.2)
Turnip.3<-c(turnip$Turnips.3)
Turnip.4<-c(turnip$Turnips.4)
Turnip.5<-c(turnip$Turnips.5)
Turnip.6<-c(turnip$Turnips.6)
Turnip.7<-c(turnip$Turnips.7)
Turnip.8<-c(turnip$Turnips.8)
Turnip.9<-c(turnip$Turnips.9)
Turnip.10<-c(turnip$Turnips.10)
Turnip.11<-c(turnip$Turnips.11)
Turnip.12<-c(turnip$Turnips.12)
Turnip.13<-c(turnip$Turnips.13)
Turnip.14<-c(turnip$Turnips.14)
Turnip.15<-c(turnip$Turnips.15)



a<-ggplot() + 
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.1,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.2,group=1,color='blue'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.3,group=1,color='green'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.4,group=1,color='#fb9791'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.5,group=1,color='pink'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.6,group=1,color='black'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.7,group=1,color='#999999'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.8,group=1,color='#E69F00'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.9,group=1,color='#56B4E9'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.10,group=1,color='yellow'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.11,group=1,color='brown'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.12,group=1,color='#f67280'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.13,group=1,color='#9acd32'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.14,group=1,color='#c0ff3e'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.15,group=1,color='#9bcd9b'),size=1)+xlab("Time")+ylab("Price")+ggtitle("Price Trend")+theme(plot.title = element_text(size = 30, face = "bold"))+
  scale_color_discrete(name = "Turnips#", labels = c("Turnip1", "Turnip2","Turnip3","Turnip4","Turnip5","Turnip6","Turnip7","Turnip8","Turnip9","Turnip10","Turnip11","Turnip12","Turnip13","Turnip14","Turnip15"))

a




##box plot

str(turnip3)
plot(turnip3$Time,turnip3$Price,col = rainbow(13)[x],main="Turnips distribution over a week")



##Hist&density
summary(turnip4)
hist(turnip4$Price,col=rainbow(13)[x],main="Price density",xlab="Price",ylab="Density",border="black",prob = TRUE,breaks=30)
axis(1, at = seq(10, 90, by = 10), las=1)
lines(density(turnip4$Price),lwd = 2,col = "black")
mean(turnip3$Price)



     
     
##Classify
b<-ggplot() + 
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.1,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.2,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.3,group=1,color='green'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.4,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.5,group=1,color='pink'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.6,group=1,color='green'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.7,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.8,group=1,color='pink'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.9,group=1,color='#56B4E9'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.10,group=1,color='red'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.11,group=1,color='#56B4E9'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.12,group=1,color='green'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.13,group=1,color='pink'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.14,group=1,color='pink'),size=1)+
  geom_line(aes(x=fct_inorder(turnip$Time),y=turnip$Turnips.15,group=1,color='green'),size=1)+xlab("Time")+ylab("Price")+ggtitle("Price Trend")+theme(plot.title = element_text(size = 30, face = "bold"))+
  scale_color_discrete(name = "Trend", labels = c("Decreasing", "Large Spike","Small Spike","Fluctuation"))

b
     
     
     
     
     
     
     
     
     
     
     
     
     
     
     