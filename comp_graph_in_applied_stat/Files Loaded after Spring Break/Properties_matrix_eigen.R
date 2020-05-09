#properties of eigenvalues/eigenvectors

A <- matrix(c(1.34,-0.16,0.19,-0.16, 0.62, -0.13,0.19,-0.13,1.49), 3, 3, byrow=TRUE)
A
eval <- eigen(A)  #extract principal components
eval$values

(evec <- eval$vectors)  #show eigenvectors

#Show some properties of eigenvalues/eigenvectors
library(matlib)

#1. Orthogonality
crossprod(evec)
(t(evec)%*%evec)  #matrix(eigenvectors)'matrix(eigenvectors)


#2. trace(A) = sum of diagonal elements of A = sum of eigenvalues
sum(eval$values)
tr(A)

#3. determinant (A) = product of eigenvalues (A)
prod(eval$values)
det(A) 

#4. rank (A) = number of non-zero eigenvalues(A)
sum(eval$values != 0)
R(A)
