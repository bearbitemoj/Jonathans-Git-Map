library(kernlab)
data(spam)

features = spam[,-58]
y = spam[,-(1:57)]

missClass = function(X1,X2){
  missclass = ( 1 - sum ( diag ( table ( X1,X2 )))/ length ( X1 ))
}

spam = spam[sample(nrow(spam)),]

innerCross = ksvm(type~.,data= spam, kernel="rbfdot", C=5, kpar = list(sigma= 0.01), cross = 2)

nested = function(data, c ,w, K){
  
  
  
  foldsize = nrow(data)%/%K
  temp = 1
  totalerror = 0
  
  for(i in 1:K){
    if(i != K){
      
      test = data[temp:(i*foldsize),]
      train = data[-(temp:(i*foldsize)),]
      
      
    }else{
      
      test = data[temp:nrow(data),]
      train = data[-(temp:nrow(data)),]
    }
    
    innerCross = ksvm(type~.,data= train, kernel="rbfdot", C=c, kpar = list(sigma= w), cross = 2)
    mailtype = predict(innerCross,test[,-58])
    t = table(mailtype,test[,58])
    error = missClass(mailtype,test[,58])
    totalerror = totalerror + error
    temp = (i*foldsize) + 1
    
    
  }
  result = totalerror/K
  
}

test = nested(spam,1,0.1,5)



## NN


run = function(We, Ve, X, t){
  
  X2 = cbind(1,X)
  a = numeric(10)
  z = numeric(11)
  deltaJ = numeric(11)
  
  
  y = 0
  
  for( i in 1:length(a)){
    for (j in 1:ncol(X2)){
      a[i] = a[i] + X2[j]*We[i,j]
      
    }
  }
  
  a2 = cbind(1,a)
  
  for(i in 1:length(z)){
    z[i] = tanh(a2[i])
  }
  
  for (j in 1:length(z)){
    
    y = y + Ve[j]*z[j]
    
  }
  
  deltaK = y - t
  return(deltaK)

}



backprop = function(We, Ve, X, t, learningrate){
  
  
  ## Add the bias
  X2 = cbind(1,X)
  a = numeric(10)
  z = numeric(11)
  deltaJ = numeric(11)
  We = We
  Ve = Ve

  
  y = 0
  
  for( i in 1:length(a)){
    for (j in 1:ncol(X2)){
        a[i] = a[i] + X2[j]*We[i,j]
      
    }
  }
  
  ## Add the bias for the hiddenlayer
  a2 = cbind(1,a)
  
  for(i in 1:length(z)){
    z[i] = tanh(a2[i])
  }
  
  for (j in 1:length(z)){
    
    y = y + Ve[j]*z[j]

  }

  deltaK = y - t
  
  for(k in 1:length(a)){
    deltaJ[k] = (1-z[k]^2)*Ve[k]*deltaK
    
  }
  
  for (i in 1:length(Ve)){
    dEdve = deltaK * z[i]
    Ve[i] = Ve[i] - learningrate * dEdve
  }

  for( i in 1:length(a)){
    for (j in 1:ncol(X2)){
          dEdwe = deltaJ[i]*X2[j]
          We[i,j] = We[i,j] - learningrate * dEdwe
    
      }
    }
    
  returnList = list("We"= We, "Ve" = Ve)
  return(returnList)
    
}

set.seed(1234567890)
Var <- runif(50, 0, 10)
trva <- data.frame(Var, Sin=sin(Var))
tr <- trva[1:25,] # Training
va <- trva[26:50,] # Validation
V <- runif(11, -1, 1)
W = matrix(runif(20,-1,1),10)

ite = 5000

trainMSE = numeric(ite)
testMSE = numeric(ite)

for(j in 1:ite){
  trainingError = 0
  validationError = 0

for (i in 1:nrow(tr)){
  
  result = backprop(W,V,tr[i,1],tr[i,2],0.05)
  
  W = result$We
  V = result$Ve

  
}
  
  for (k in 1:nrow(tr)){
    err = run(W,V,tr[k,1],tr[k,2])
    trainingError = trainingError + err^2
    
  }
  
  for (k in 1:nrow(va)){
    vaErr = run(W,V,va[k,1],va[k,2])
    validationError = validationError + vaErr^2
  }
  
  trainMSE[j] = trainingError / nrow(tr)
  testMSE[j] = validationError / nrow(va)
  
}

plot(trainMSE)
plot(testMSE)


