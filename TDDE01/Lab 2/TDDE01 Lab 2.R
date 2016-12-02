
############
###Step 1###
############
#linear regression
mylin=function(X,Y,Xpred){
  Xpred1=cbind(1,Xpred)     #Do this to be able to multiply with our constant in the model
  X = cbind(1,X)
  #MISSING: check formulas for linear regression and compute beta
  beta = solve(t(X)%*%X)%*%t(X)%*%Y
  Res=Xpred1%*%beta         #We multiply with Xpred1 because we want the predicted values
  return(Res)
}

myCV=function(X,Y,Nfolds){
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
  
  #we assume 5 features.
  
  for (f1 in 0:1)
    for (f2 in 0:1)
      for(f3 in 0:1)
        for(f4 in 0:1)
          for(f5 in 0:1){
            model= c(f1,f2,f3,f4,f5)
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
              
              #MISSING: implement cross-validation for model with features in "model" and iteration i.
              index = seq(1:5)*model
              testDataX = as.matrix(testDataX[,index])
              trainDataX = as.matrix(trainDataX[,index])
             
              #MISSING: Get the predicted values for fold 'k', Ypred, and the original values for fold 'k', Yp.
              Ypred = mylin(trainDataX,trainDataY,testDataX)
              Yp = testDataY
              SSE=SSE+sum((Ypred-Yp)^2)
            }
            curr=curr+1
            MSE[curr]=SSE/n
            Nfeat[curr]=sum(model)
            Features[[curr]]=model
            
          }
  
  #MISSING: plot MSE against number of features
  plot(Nfeat,MSE)
  i=which.min(MSE)
  return(list(CV=MSE[i], Features=Features[[i]]))
  #return(X1)
}

############
###Step 2###
############
cross = myCV(as.matrix(swiss[,2:6]), swiss[[1]], 5) #Sends in X, Y and Nfolds

