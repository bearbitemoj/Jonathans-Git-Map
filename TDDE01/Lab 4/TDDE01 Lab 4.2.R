
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


############
###Step 3###
############
library(fastICA)
set.seed(12345)
#See 4a PPT. 28-31

# a)
a = fastICA(data, 2, alg.typ = "parallel", fun = "logcosh", alpha = 1,
        method = "R", row.norm = FALSE, maxit = 200, tol = 0.0001, verbose = TRUE) #ICA
W_dot = a$K %*% a$W
plot(W_dot[,1], main="Traceplot of W'")
plot(W_dot[,2], main="Traceplot of W'")

# b)
plot(a$S[,2], a$S[,1],ylab="PC2",xlab="PC1") 


############
###Step 4###
############
library(pls)
pcr.fit=pcr(Viscosity~., data=data, validation="CV")
summary(pcr.fit)
validationplot(pcr.fit,val.type="MSEP")






