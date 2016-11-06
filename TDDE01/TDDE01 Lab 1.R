knearest <- function(data, K, newdata){ #data = training, newdata = test
  M = 1370
  Xhat = matrix(nrow=M,ncol=48)
  Yhat = matrix(nrow=M,ncol=48)
  Xmatrix = as.matrix(data)
  Ymatrix = as.matrix(newdata)
  X = matrix(nrow=1,ncol=48)
  Y = matrix(nrow=1,ncol=48)
  
  for(i in 1:M){
    X[1,1:48] = Xmatrix[i,1:48]                
    Xhat[i,] = X/sqrt(rowSums(X^2))
    
    Y[1,1:48] = Ymatrix[i,1:48]
    Yhat[i,] = Y/sqrt(rowSums(Y^2))
  }
  C = Xhat%*%t(Yhat)
  D = 1-C

  #for(i in 1:M){
  #  
  #  if(Ki/K > 0.5){
  #    Yhat = 1;
  #  }else{
  #    Yhat = 0
  #  }
  #}
  
}

myfunction=function(X){
  a=X^2
  b=X+rnorm(1)
  return(list(a,b))
}

missclass=function(X,X1){
  n = length(X)
  return(1-sum(diag(table(X,X1)))/n)
}

############
###Step 1###
############
data = read.csv2('spambase.csv')
n=dim(data)[1]
set.seed(12345)
id=sample(1:n, floor(n*0.5))
train=data[id,]
test=data[-id,]

############
##Step 2-3##
############

nearest<-knearest(data = train, K=5, newdata = test)
#nearest

############
###Step 5###
############
model = kknn(formula(train), train, test, k=5)
model$prob




