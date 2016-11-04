
loglike=function(x, theta){
  result = log(theta*exp(-theta*x))
}

bayesmodel=function(x, theta, lambda=10){
  result = log(theta*exp(-theta*x)*lambda*exp(-lambda*theta))
}

data = read.csv2('machines.csv')
x = as.vector(data)
L = loglike(x, theta=1)


y = x[1:6,1]
Ly = loglike(y,theta = 1)

plot(L)
par(new = TRUE)
plot(Ly, axes = FALSE,xlab = "", ylab = "")

B = bayesmodel(x, theta=pi/2)

plot(B)
