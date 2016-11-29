
############
###Step 1###
############
data = read.csv2('State.csv')
reorderedData = data[order(data$MET),]

plot(reorderedData$MET,reorderedData$EX,pch=21, bg="orange",xlab="MET",ylab="EX")

############
###Step 2###
############
library(tree)
set.seed(12345)
tree_model = tree(EX~MET,data=reorderedData,control = tree.control(48, minsize=8))
cv.tree_model = cv.tree(tree_model)

best.size = cv.tree_model$size[which(cv.tree_model$dev==min(cv.tree_model$dev))]
cv.tree_model.pruned = prune.tree(tree_model, best=best.size)

plot(cv.tree_model.pruned)
text(cv.tree_model.pruned,pretty=0)

datafit = predict(cv.tree_model.pruned,newdata=reorderedData)

plot(reorderedData$MET,reorderedData$EX,pch=21, bg="orange",xlab="MET",ylab="EX")
points(reorderedData$MET,datafit,type="l")

residualdata = residuals(cv.tree_model.pruned)

resmatrix = data.matrix(residualdata)
hist(resmatrix, plot = TRUE, col = "blue", main="Histogram of Residuals",xlab="Residual")

############
###Step 3###
############
library(boot)
# computing bootstrap samples
f=function(data, ind){
  data1=data[ind,] # extract bootstrap sample
  res=tree(EX~MET, data=data1) #fit tree model
  
  #predict values for all MET values from the original data
  EXP=predict(res,newdata=reorderedData)
  return(EXP)
}
res=boot(reorderedData, f, R=1000) #make bootstrap

e=envelope(res) #compute confidence bands

fit=cv.tree_model.pruned
EXP=predict(fit)

plot(reorderedData$MET, reorderedData$EX, pch=21, bg="orange",xlab="MET",ylab="EX", ylim=c(150,460))
points(reorderedData$MET,EXP,type="l") #plot fitted line

#plot cofidence bands
points(reorderedData$MET,e$point[2,], type="l", col="blue")
points(reorderedData$MET,e$point[1,], type="l", col="blue")

############
###Step 4###
############
#mle=lm(EX~MET, data=reorderedData)
mle = cv.tree_model.pruned
rng=function(data, mle) {
  data1=data.frame(EX=data$EX,MET=data$MET)
  n=length(data$EX)
  
  #generate new EX
  data1$EX=rnorm(n,predict(mle, newdata=data1),sd(residuals(mle)))
  return(data1)
}

f1=function(data1){
  res=tree(EX~MET, data=data1) #fit tree model
  
  #predict values for all MET values from the original data
  EXP=predict(res,newdata=reorderedData)
  n=length(reorderedData$EX)
  predictedEXP=rnorm(n,EXP, sd(residuals(mle)))
  return(predictedEXP)
}

res=boot(reorderedData, statistic=f1, R=10000, mle=mle,ran.gen=rng, sim="parametric") #make bootstrap
res2=boot(reorderedData, statistic=f, R=1000, mle=mle,ran.gen=rng, sim="parametric") #make bootstrap

e=envelope(res) #compute prediction bands
e2=envelope(res2) #compute confidence bands

fit=cv.tree_model.pruned
EXP=predict(fit)

plot(reorderedData$MET, reorderedData$EX, pch=21, bg="orange",xlab="MET",ylab="EX", ylim=c(150,460))
points(reorderedData$MET,EXP,type="l") #plot fitted line

#plot prediction bands
points(reorderedData$MET,e$point[2,], type="l", col="blue")
points(reorderedData$MET,e$point[1,], type="l", col="blue")

plot(reorderedData$MET, reorderedData$EX, pch=21, bg="orange",xlab="MET",ylab="EX", ylim=c(150,460))
points(reorderedData$MET,EXP,type="l") #plot fitted line

#plot confidence bands
points(reorderedData$MET,e2$point[2,], type="l", col="blue")
points(reorderedData$MET,e2$point[1,], type="l", col="blue")




