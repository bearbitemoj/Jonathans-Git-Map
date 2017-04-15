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
#data = read.csv('spam.csv')
data(spam)
data = spam
index <- sample(1:dim(data)[1])
train <- data[index[1:floor(dim(data)[1]/2)], ]
test <- data[index[((ceiling(dim(data)[1]/2)) + 1):dim(data)[1]], ]

missclass=function(X,X1){
  n = length(X)
  return(1-sum(diag(table(X,X1)))/n)
}

innerCV=function(X,Y,type){
  if(type==1){
    filter1 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.01),C=1,cross=2)
    mailtype1 <- predict(filter1,test[,-58])
    miss = missclass(mailtype1,test$type)
  }else if(type==2){
    filter2 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.05),C=1,cross=2)
    mailtype2 <- predict(filter2,test[,-58])
    miss = missclass(mailtype2,test$type)
  }else if(type==3){
    filter3 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.05),C=5,cross=2)
    mailtype3 <- predict(filter3,test[,-58])
    miss = missclass(mailtype3,test$type)
  }else if(type==4){
    filter4 <- ksvm(type~.,data=train,kernel="rbfdot",
                    kpar=list(sigma=0.01),C=5,cross=2)
    mailtype4 <- predict(filter4,test[,-58])
    miss = missclass(mailtype4,test$type)
  }else if(type==5){
    filter5 <- ksvm(type~.,data=train,kernel="vanilladot",C=1,cross=2)
    mailtype5 <- predict(filter5,test[,-58])
    miss = missclass(mailtype5,test$type)
  }else{
    filter6 <- ksvm(type~.,data=train,kernel="vanilladot",C=5,cross=2)
    mailtype6 <- predict(filter6,test[,-58])
    miss = missclass(mailtype6,test$type)
  }
  
  return(miss)
  
}

myCV=function(X,Y,Nfolds,type){
  n=length(Y)
  p=ncol(X)
  set.seed(12345)
  ind=sample(n,n)    #Permute the observations randomly
  X1=X[ind,]
  Y1=Y[ind]
  #sF=floor(n/Nfolds)
  MSE=numeric(2^p-1)
  Nfeat=numeric(2^p-1)
  Features=list()
  curr=0
  
  if (sum(model)==0) next()
  SSE=0
  
  folds = cut(seq(1,nrow(X1)),breaks=Nfolds,labels=FALSE)      #Create folds
  for (k in 1:Nfolds){
    #MISSING: compute which indices should belong to current fold
    testIndexes = which(folds==k,arr.ind=TRUE)
    testDataX = X1[testIndexes, ]
    testDataY = Y1[testIndexes]
    trainDataX = X1[-testIndexes, ]
    trainDataY = Y1[-testIndexes]
    
    #MISSING: Get the predicted values for fold 'k', Ypred, and the original values for fold 'k', Yp.
    Ypred = innerCV(trainDataX,trainDataY,testDataX, type)
    Yp = testDataY
    SSE=SSE+sum((Ypred-Yp)^2)
  }
  curr=curr+1
  MSE[curr]=SSE/n
    
  #MISSING: plot MSE against number of features
  i=which.min(MSE)
  return(list(CV=MSE[i], Features=Features[[i]]))
}

cross = myCV(train, test, 5,1) #Sends in X, Y,Nfolds and type

