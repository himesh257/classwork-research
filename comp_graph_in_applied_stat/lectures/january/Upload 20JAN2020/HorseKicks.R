#the statement starting with 'sink' directs output to poissonness.txt.
#The output is NOT appended, a new file is created. output is also sent to the monitor. 
sink("C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/poissonness.txt",append=FALSE,split=TRUE) 
 
#install.packages("vcd") #install the vcd package if not already installed on your computer
library(vcd) 
## Real data example ##
data("HorseKicks")
HorseKicks
head(HorseKicks)

#will now generate Poissonness plot
#send graphics output to a window sized 5 units x 5 units
windows(5,5) 

#note lambda=the average number of HorseKicks per rider
#is equal to (109*0 + 65*1 + 22*2 + 3*3 1*4 )/200  which is equal to 0.61

#graphics output can be directed to only one location, so now save graphics output in pdf
pdf(file="C:/Users/jmard/Desktop/Computing and Graphics in Applied Statistics2020/graph_horsekicks.pdf") 

distplot(HorseKicks,type="poisson",ylim=c(-4,1),main="Poissonness Plot")

dev.off() #closes pdf file
sink() #redirects output to graphics window of console

#note the statement below can also be used to close the pdf file and return
#output to the graphics window of console
#graphics.off( )   
