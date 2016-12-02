
############
###Step 1###
############
data = read.csv2('creditscoring.csv')
n=dim(data)[1]
set.seed(12345)
id=sample(1:n, floor(n*0.5))
train=data[id,]
id1=setdiff(1:n, id)
set.seed(12345)
id2=sample(id1, floor(n*0.25))
valid=data[id2,]
id3=setdiff(id1,id2)
test=data[id3,] 

############
###Step 2###
############
library(tree)
tree_model = tree(good_bad~.,data=train)

plot(tree_model)
text(tree_model,pretty=0)

summary(tree_model) #Missclassification error rate = 0.2105

missclass=function(X,X1){
  n = length(X)
  return(1-sum(diag(table(X,X1)))/n)
}

tree_pred = predict(tree_model,test,type="class")
missclass(tree_pred,test[,20]) #Missclassification error rate = 0.268


############
###Step 3###
############
trainScore=rep(0,15)
validScore=rep(0,15)
for(i in 2:15) {
  prunedTree=prune.tree(tree_model,best=i)
  pred=predict(prunedTree, newdata=valid,
               type="tree")
  trainScore[i]=deviance(prunedTree)
  validScore[i]=deviance(pred)
}
plot(2:15, trainScore[2:15], type="b", col="red",xlab="Number of Leaves",ylab="Deviance",ylim=c(270,560))
legend("topright", legend=c("Training Data","Validation Data"), lty=c(1,1),col=c("red","blue"),bg="white",lwd=1)
par(new=TRUE)
plot(2:15, validScore[2:15], type="b", col="blue", ylim=c(270,560),xlab="",ylab="")

## Pruning at 5/6 or 8
finalTree=prune.tree(tree_model, best=4)
Yfit=predict(finalTree, newdata=valid,
             type="class")
table(valid$good_bad,Yfit)

plot(finalTree)
text(finalTree,pretty=0)

summary(finalTree)

tree_pred = predict(finalTree,test,type="class")
missclass(tree_pred,test[,20]) #Missclassification error rate = 0.256

############
###Step 4###
############
library(MASS)
library(e1071)
naive_model=naiveBayes(good_bad~., data=train)
naive_model
Yfit=predict(naive_model, newdata=train)
missclass(Yfit,train[,20]) #Missclassification error rate = 0.3
naiveTableTrain = table(train$good_bad, Yfit)
Yfit=predict(naive_model, newdata=test)
missclass(Yfit,test[,20]) #Missclassification error rate = 0.316
naiveTableTest = table(test$good_bad,Yfit)


############
###Step 5###
############
naive_model2=naiveBayes(good_bad~., data=train)
Yfit=predict(naive_model2, newdata=train, type="raw")    #Our C

Ypred = vector(length=dim(Yfit)[1])
for(i in 1:dim(Yfit)[1]){
  c.bad = Yfit[i,1]*1 + Yfit[i,2]*0
  c.good = Yfit[i,1]*0 + Yfit[i,2]*10
  if(c.good <= c.bad){
    Ypred[i] = "good"
  }else{
    Ypred[i] = "bad"
  }
}

naiveTableTrain2 = table(train$good_bad,Ypred)
missclass(Ypred,train[,20]) #Missclassification error rate = 0.726

Yfit=predict(naive_model2, newdata=test, type="raw")
Ypred = vector(length=dim(Yfit)[1])
for(i in 1:dim(Yfit)[1]){
  c.bad = Yfit[i,1]*1 + Yfit[i,2]*0
  c.good = Yfit[i,1]*0 + Yfit[i,2]*10
  if(c.good <= c.bad){
    Ypred[i] = "good"
  }else{
    Ypred[i] = "bad"
  }
}

naiveTableTest2 = table(test$good_bad,Ypred)
missclass(Ypred,test[,20]) #Missclassification error rate = 0.712



