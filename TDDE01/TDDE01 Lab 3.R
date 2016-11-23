
############
###Step 1###
############
data = read.csv('australian-crabs.csv')
## Enhanced Scatter Plot
library(car) 
scatterplot(RW ~ CL | sex, data=data, main="Scatter Plot", labels=row.names(data),reg.line=FALSE, smoother=FALSE,pch = c(1, 1))

############
##Step 2-3##
############

disc_fun=function(label, S){
  X1=X[Y==label,]
  #MISSING: compute LDA parameters w1 (vector with 2 values) and w0 (denoted here as b1)
  mu0 = mean(X1[,2])
  mu1 = mean(X1[,3])
  mu = vector(length=2)
  mu[1] = mu0
  mu[2] = mu1
  pi0 = length(X1[,2])/dim(X)[1]
  
  b1 = -1/2*t(mu)%*%solve(S)%*%mu+log(pi0)
  w1 = solve(S)%*%mu
  return(c(w1[1], w1[2], b1[1,1]))
}
myvars <- names(data) %in% c("species","index","FL","CW","BD") 
X <- data[!myvars]
Y = data$sex

X1=X[Y=="Male",]
X2=X[Y=="Female",]

S=cov(X1[,2:3])*dim(X1[,2:3])[1]+cov(X2[,2:3])*dim(X2[,2:3])[1]
S=S/dim(X)[1]

#discriminant function coefficients
res1=disc_fun("Male",S)
res2=disc_fun("Female",S)

# MISSING: use these to derive decision boundary coefficients 'res'
res = res1-res2

# classification
d=res[1]*X[,2]+res[2]*X[,3]+res[3]
Yfit=(d>0)
plot(X[,3], X[,2], col=Yfit+1, xlab="CL", ylab="RW",main="Scatter Plot with LDA",panel.first = 
       c(abline(h=seq(0,20,2), v=seq(0,50,5), col="azure3")))

#MISSING: use 'res' to plot decision boundary. 
slope=-res[2]/res[1]
intercept = -res[3]/res[1]  #Think y = mx + b, where m = slope and b = intercept
abline(intercept,slope)


############
###Step 4###
############
glmfit = glm(formula = sex ~ RW + CL,data=data, family = binomial())
slopeGlm = -glmfit$coefficients[3]/glmfit$coefficients[2]
interceptGlm = -glmfit$coefficients[1]/glmfit$coefficients[2]
dGlm = predict(glmfit,data=data)
#dGlm=glmfit$coefficients[2]*X[,2]+glmfit$coefficients[3]*X[,3]+glmfit$coefficients[1]
YfitGlm = (dGlm>0)
plot(X[,3], X[,2], col=YfitGlm+1, xlab="CL", ylab="RW",main="Scatter Plot with logistic regression",panel.first = 
       c(abline(h=seq(0,20,2), v=seq(0,50,5), col="azure3")))
abline(interceptGlm,slopeGlm)



