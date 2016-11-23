
############
###Step 1###
############
data = read.csv2('NIRspectra.csv')
data1 = data
data1$Viscosity=c()
res=prcomp(data1) #Perform PCA on the data matrix
lambda=res$sdev^2 #eigenvalues

#proportion of variation
sprintf("%2.3f",lambda/sum(lambda)*100)
screeplot(res)

U=res$rotation #Rotation of the PCA:s
head(U) 

plot(res$x[,1], res$x[,2],ylab="PC2",xlab="PC1") #a plot of the scores in the coordinates (PC1, PC2)

############
###Step 2###
############
plot(U[,1],main="Traceplot, PC1",ylab = "PC1")
plot(U[,2],main="Traceplot, PC2",ylab = "PC2")
plot(U[,3],main="Traceplot, PC3",ylab = "PC3")


############
###Step 3###
############
library(fastICA)
set.seed(12345)

#See 4a PPT. 28
