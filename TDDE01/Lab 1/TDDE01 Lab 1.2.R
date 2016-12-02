############
##Step 1-2##
############
loglike=function(x, theta){
  n = length(x)
  result = n*log(theta)-theta*sum(x)
  return(result)
}

data = read.csv2('machines.csv')
Xdata = t(as.vector(data))
Ydata = (as.vector(Xdata[1:6]))
Xdata = t(Xdata)
Xindex = matrix(nrow=201, ncol=2)
i = 1

for(theta in seq(0,2,0.01)){
  Xindex[i,2] = theta
  Xindex[i,1]= (loglike(Xdata,theta))
  i = i + 1
}

optThetaX = Xindex[which.max(Xindex[,1]),2]

plot(Xindex[,2],Xindex[,1], type="l", col="blue", xlab="theta", ylab="Value"
     ,main="Dependence of Log-likelihood on theta for the entire data") #Theta = 0.02 is optimal
abline(v=optThetaX,col="green")
############
###Step 3###
############

Xindex = matrix(nrow=200, ncol=2)
Yindex = matrix(nrow=200, ncol=2)
i = 0
for(theta in seq(0,2,0.01)){
  Xindex[i,2] = theta
  Xindex[i,1]= (loglike(Xdata,theta))
  Yindex[i,2] = theta
  Yindex[i,1]= (loglike(Ydata,theta))
  i = i + 1
}

optThetaY = Yindex[which.max(Yindex[,1]),2]

plot(Xindex[1:i-1,2],Xindex[1:i-1,1], type="l", col="blue", xlab="theta", ylab="Value",xlim=c(0,2)
     ,ylim=c(-60,0)) #Theta = 0.02 is optimal
abline(v=optThetaX ,col="green")
par(new=TRUE)
plot(Yindex[1:i-1,2],Yindex[1:i-1,1], type="l", col="orange", xlab = "", ylab = "",xlim=c(0,2)
     ,ylim=c(-60,0),main="Dependence of Log-likelihood on theta") #Theta = 1.79 is optimal
abline(v=optThetaY,col="red")



############
###Step 4###
############
bayesmodel=function(theta){
  lambda=10
  
  X = loglike(Xdata,theta)
  Y = loglike(theta,lambda)
  result = X+Y
  return(result)
  }
#thetaIndex = array(1000)
index2 = matrix(nrow=101, ncol=2)

j = 1
for(theta in seq(0,1,0.01)){
  index2[j,2] = theta
  index2[j,1]= bayesmodel(theta)
  j = j + 1
}
optTheta = index2[which.max(index2[,1]),2]
plot(index2[,2],index2[,1], type = "l", col="blue", xlab="theta", ylab="Value"
     , main="Dependence of L(theta)") #Theta = 0.02 is optimal
abline(v=optTheta,col="green")

############
###Step 5###
############
theta = optThetaX
set.seed(12345)
newData = rexp(50,theta)

oldData = data.matrix(data)
newData = data.matrix(newData)

oldHist = hist(oldData, plot = TRUE, col = "blue", xlab="Length"
               ,main="Histogram of Old data",xlim = c(0,7),ylim= c(0,35))
newHist = hist(newData, plot = TRUE, col="orange", xlab="Length"
               ,main="Histogram of New data",xlim = c(0,7),ylim= c(0,35))





