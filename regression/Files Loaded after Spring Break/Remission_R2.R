#Multiple Logistic Regression in R
if (FALSE)
{"
The data, taken from Lee (1974), consist of patient characteristics and
whether or not cancer remission occurred, and are saved in the data set
Remission. The variable remiss is the cancer remission indicator variable
with a value of 1 for remission and a value of 0 for nonremission.  The other
six variables are the risk factors thought to be related to cancer remission.
"}

library(faraway)

#read in the data which is in a csv file
remission <- read.csv("C:/Users/jmard/OneDrive/Desktop/RegressionMethodsSpring2020/Lecture 12 14APR2020/remission.csv",header = TRUE)
head(remission,3L)

logistic <- glm(remiss ~ cell + smear + infil + li + blast + temp, family=binomial(logit), data=remission)
summary(logistic) 
anova(logistic, test="Chisq") 

library(DescTools) #install package if needed
PseudoR2(logistic,which="all")

if (FALSE)
{"
McFadden pseudo-R2
McFadden adjusted pseudo-R2
Cox and Snell pseudo-R2 (also known as ML pseudo-R2)
Nagelkerke pseudoR2 (also known as CraggUhler R2)
AldrichNelson AldrichNelson pseudo-R2
VeallZimmermann pseudo-R2
McKelvey and Zavoina pseudo-R2
Efron pseudo-R2
Tjur’s pseudo-R2
Akaike’s information criterion
log-Likelihood for the fitted model (by maximum likelihood)
log-Likelihood for the null model. The null model will include the offset, and an intercept if there is one in the model.
G2 - difference of the null deviance - model deviance
"}

remission2_7 <-cbind(remission$cell,remission$smear,remission$infil,remission$li,remission$blast,remission$temp)
HosmerLemeshowTest(fit = fitted(logistic), obs = remission[,1], X = remission2_7)
