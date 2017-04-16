############
###Step 1###
############
library(mboost)
bf <- read.csv2("bodyfatregression.csv")

set.seed(1234567890)
m <- blackboost(Bodyfat_percent~Waist_cm+Weight_kg, data=bf)
mstop(m)
cvf <- cv(model.weights(m), type="kfold")
cvm <- cvrisk(m, folds=cvf, grid=1:100)
plot(cvm)
mstop(cvm)

############
##Step 2-3##
############
library(kernlab)
data = read.csv('spam.csv')
index <- sample(1:dim(data)[1])
train <- data[index[1:floor(dim(data)[1]/2)], ]
test <- data[index[((ceiling(dim(data)[1]/2)) + 1):dim(data)[1]], ]

missclass=function(X,X1){
  n = length(X)
  return(1-sum(diag(table(X,X1)))/n)
}

innerCV=function(X,Y,choice){
  miss = 0
  
  if(choice==1){
    filter1 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.01),C=1,cross=2)
    mailtype1 <- predict(filter1,test[,-58])
    miss = missclass(mailtype1,test$type)
  }else if(choice==2){
    filter2 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.05),C=1,cross=2)
    mailtype2 <- predict(filter2,test[,-58])
    miss = missclass(mailtype2,test$type)
  }else if(choice==3){
    filter3 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.05),C=5,cross=2)
    mailtype3 <- predict(filter3,test[,-58])
    miss = missclass(mailtype3,test$type)
  }else if(choice==4){
    filter4 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.01),C=5,cross=2)
    mailtype4 <- predict(filter4,test[,-58])
    miss = missclass(mailtype4,test$type)
  }else if(choice==5){
    filter5 <- ksvm(type~.,data=train,kernel="vanilladot",C=1,cross=2)
    mailtype5 <- predict(filter5,test[,-58])
    miss = missclass(mailtype5,test$type)
  }else if(choice==6){
    filter6 <- ksvm(type~.,data=train,kernel="vanilladot",C=5,cross=2)
    mailtype6 <- predict(filter6,test[,-58])
    miss = missclass(mailtype6,test$type)
  }
  
  return(miss)
  
}

nestedCV=function(X,Y,Nfolds){
  n=length(Y)
  set.seed(12345)
  ind=sample(n,n)    #Permute the observations randomly
  X1=X[-ind,]
  Y1=Y[ind,] 
  
  totalerror = array(data=0,dim=6)
  
  folds = cut(seq(1,nrow(X1)),breaks=Nfolds,labels=FALSE)      #Create folds
  for(i in 1:6){
    for (k in 1:Nfolds){
      testIndexes = which(folds==k,arr.ind=TRUE)
      trainData = X1[testIndexes, ]
      testData = Y1[testIndexes, ]
      
      error = innerCV(trainData,testData,i)
      totalerror[i] = totalerror[i] + error
    }
  }
  
  m=which.min(totalerror)
  #Returns the optimal model and the error 
  return(list(i,totalerror[m]/Nfolds))
}

cross = nestedCV(train, test, 5) #Sends in X, Y, and Nfolds

############
##Step 4-5##
############
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
# Initialize weights
V <- runif(11, -1, 1)
W = matrix(runif(20,-1,1),10)

ite = 5000

trainMSE = numeric(ite)
testMSE = numeric(ite)

for(j in 1:ite){
  trainingError = 0
  validationError = 0
  
  for (i in 1:nrow(tr)){
    
    result = backprop(W,V,tr[i,1],tr[i,2],0.005)
    
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

