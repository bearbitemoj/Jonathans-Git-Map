knearest <- function(data, K, newdata){ #data = training, newdata = test
  M = 1370
  Xhat = matrix(nrow=M,ncol=48)
  Yhat = matrix(nrow=M,ncol=48)
  Xmatrix = as.matrix(data)
  Ymatrix = as.matrix(newdata)
  X = matrix(nrow=1,ncol=48)
  Y = matrix(nrow=1,ncol=48)
  xsum = sqrt(rowSums(Xmatrix[,1:48]^2))
  ysum = sqrt(rowSums(Ymatrix[,1:48]^2))
  
  for(i in 1:M){
    Xhat[i,] = Xmatrix[i,1:48]/xsum[i]
    Yhat[i,] = Ymatrix[i,1:48]/ysum[i]
  }
  C = Xhat%*%t(Yhat)
  D = 1-C
  
  #####Probability of Spam########
  tempD = D
  count = 1
  indexK = array(dim=K)
  indexK = 10
  probVector = vector(length=M)
  Ki = 0
  for(i in 1:M){ #Loop through every column
    for(j in 1:K){ #Check K values that are min for each col
      indexK[count] = which.min(tempD[,i])
      tempD[indexK[count],i] = 10
      count = count + 1
    }
    count = 1
    
    for(w in 1:K){
      if(Xmatrix[indexK[w],49] > 0){
        Ki = Ki + 1
      }
    }
    probVector[i] = Ki/K
    Ki = 0
  }
  result = probVector
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
setClassif=function(prob,lim){
  if(prob > lim){
    pred = 'Spam'
  }else{
    pred = 'email'
  }
}

#### K = 5
nearest<-knearest(data = train, K=5, newdata = test)
pred = vector(length = length(nearest))

for(i in 1:length(nearest)){
  pred[i] = setClassif(nearest[i],0.5) 
}

table1 = table(test$Spam,pred)
missclass1 = missclass(test$Spam,pred)

#### K = 1
nearest2<-knearest(data = train, K=1, newdata = test)
pred2 = vector(length = length(nearest))

for(i in 1:length(nearest2)){
  pred2[i] = setClassif(nearest2[i], 0.5) 
}

table2 = table(test$Spam,pred2)
missclass2 = missclass(test$Spam,pred2)

############
###Step 5###
############
model = kknn(as.factor(Spam)~., train, test, k=5)
kknnPred = model$prob

for(i in 1:length(kknnPred)){
  kknnPred[i] = setClassif(kknnPred[i], 0.5) 
}

table3 = table(test$Spam,kknnPred[,2])
table3t = table(train$Spam,kknnPred[,2])
missclass3 = missclass(test$Spam,kknnPred[,2])
############
###Step 6###
############
N = 19
kknnROC = matrix(nrow=length(nearest),ncol=N)
nearestROC = matrix(nrow=length(nearest),ncol=N)
count = 1;
kknnPred2 = model$prob

ssnearest = matrix(nrow = N, ncol = 2)
sskknn = matrix(nrow = N, ncol = 2)

for(i in seq(0.05,0.95,0.05)){
  for(j in 1:length(nearest)){
    kknnROC[j,count] = setClassif(kknnPred2[j,2], i) 
    nearestROC[j,count] = setClassif(nearest[j], i) 
  }
  temp = table(test$Spam,kknnROC[,count])
  sskknn[count,1] = temp[1,2]/sum(temp[1,])
  sskknn[count,2] = temp[2,2]/sum(temp[2,])
  temp = table(test$Spam,nearestROC[,count])
  ssnearest[count,1] = temp[1,2]/sum(temp[1,])
  ssnearest[count,2] = temp[2,2]/sum(temp[2,])
  count = count + 1
}

testTable = table(test$Spam,kknnROC[,10])
testTable2 = table(test$Spam,nearestROC[,10])

plot(ssnearest[,1],ssnearest[,2], type="o", col="blue", xlab="False Positive Rate", 
     ylab="True Positive Rate",xlim=c(0,1),ylim=c(0,1))
par(new=TRUE)
plot(sskknn[,1],sskknn[,2], type="o", col="orange", xlab="False Positive Rate", 
     ylab="True Positive Rate",xlim=c(0,1),ylim=c(0,1))
par(new=TRUE)
abline(0, 1,lty=2,col="red") 

