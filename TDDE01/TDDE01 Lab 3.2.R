
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
trainScore=rep(0,9)
testScore=rep(0,9)
for(i in 2:9) {
  prunedTree=prune.tree(tree_model,best=i)
  pred=predict(prunedTree, newdata=valid,
               type="tree")
  trainScore[i]=deviance(prunedTree)
  testScore[i]=deviance(pred)
}
plot(2:9, trainScore[2:9], type="b", col="red",xlab="Number of Leaves",ylab="Deviance",ylim=c(270,560))
legend("topright", legend=c("Training Data","Test Data"), lty=c(1,1),col=c("red","blue"),bg="white",lwd=1)
par(new=TRUE)
plot(2:9, testScore[2:9], type="b", col="blue", ylim=c(270,560),xlab="",ylab="")

## Pruning at 5/6 or 8
finalTree=prune.tree(tree_model, best=8)
Yfit=predict(finalTree, newdata=valid,
             type="class")
table(valid$good_bad,Yfit)

plot(finalTree)
text(finalTree,pretty=0)

summary(finalTree)

tree_pred = predict(finalTree,test,type="class")
missclass(tree_pred,test[,20]) #Missclassification error rate = 0.288

############
###Step 4###
############
library(MASS)
library(e1071)
naive_model=naiveBayes(good_bad~., data=train)
naive_model
Yfit=predict(naive_model, newdata=train)
missclass(Yfit,train[,20]) #Missclassification error rate = 0.3
naiveTableTrain = table(Yfit,train$good_bad)
Yfit=predict(naive_model, newdata=test)
missclass(Yfit,test[,20]) #Missclassification error rate = 0.316
naiveTableTest = table(Yfit,test$good_bad)


############
###Step 5###
############
loss=matrix(c(0,10,1,0),nrow=2,ncol=2)
naive_model2=naiveBayes(good_bad~., data=train, threshold=loss[1,2]/loss[2,1])
Yfit=predict(naive_model2, newdata=train)
naiveTableTrain2 = table(Yfit,train$good_bad)
Yfit=predict(naive_model2, newdata=test)
naiveTableTest2 = table(Yfit,test$good_bad)










