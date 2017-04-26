############
###Step 1###
############

data = read.csv('crx.csv')
#str(data) #Used to see data structure for each object
data$Class = as.factor(data$Class)
n=dim(data)[1]
set.seed(12345)
id=sample(1:n, floor(n*0.8))
train=data[id,]
id1=setdiff(1:n, id)
set.seed(12345)
test=data[id1,]

library(tree)
tree_model = tree(Class~.,data=train)
plot(tree_model)
text(tree_model,pretty=0)

# Removes the second observation from the data before fitting and plotting the tree model again
newtrain = train[2:552,]
newtrain[1,] = train[1,]
tree_model2 = tree(Class~.,data=newtrain)
plot(tree_model2)
text(tree_model2,pretty=0)

############
###Step 2###
############
cv.tree_model = cv.tree(tree_model)
best.size = cv.tree_model$size[which(cv.tree_model$dev==min(cv.tree_model$dev))]
cv.tree_model.pruned = prune.tree(tree_model, best=best.size)

plot(cv.tree_model)
plot(cv.tree_model.pruned) # A4, A6, A9, A10 are the variables choosen for the optimal tree
text(cv.tree_model.pruned,pretty=0)

############
###Step 3###
############
library(glmnet)
x_train = model.matrix( ~ .-1, train[,-16])
x_test = model.matrix( ~ .-1, test[,-16])

set.seed(12345)
model=cv.glmnet(x_train,train$Class, alpha=1,family="binomial")
bestlam = model$lambda.min #0.009447
plot(model)
coef(model, s="lambda.min") #23 variables

############
###Step 4###
############
E=function(X,Y){
  error = 0
  for (i in 1:length(Y)) {
    p_hat = predict(X,Y[i,])
    Y_i = as.numeric(as.character(Y[i,]$Class))
    
    if(Y_i == 1 && p_hat[2] != 0){
      error = error + log(p_hat[2])
    }else if(p_hat[2] != 1){
      error = error + log(1-p_hat[2])
    }
    
  }
 
  return(error)
}

# Not sure how it should work for lasso, seems weird
E_Lasso = function(X,Y,Ydata){
  error=0
  probOfY = predict(X,s=bestlam,newx=Y,type="response")
  for(i in 1:length(Ydata)){
    p_hat = probOfY[i]
    Y_i = as.numeric(as.character(Ydata[i,]$Class))
    
    if(Y_i == 1 && p_hat != 0){
      error = error + log(p_hat)
    }else if(p_hat != 1){
      error = error + log(1-p_hat)
    }
    
  }
  return(error)
}

error1 = E(tree_model,test)
error2 = E(tree_model2,test)
error3 = E(cv.tree_model.pruned,test)
error4 = E_Lasso(model,x_test,test)


if(error1<error2){
  'First model is Best'
}else if(error2<error3){
  'Second model is Best'
}else if(error3<error4){
  'Third model is Best'
}else{
  'Fourth model is Best'
}







