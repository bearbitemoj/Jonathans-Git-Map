############
###Step 1###
############
data = read.csv2('tecator.csv')

Moisture = data$Moisture
Protein = data$Protein

plot(Protein,Moisture)

############
##Step 2-3##
############
mse <- function(sm) { #Mean Square Error
  mean(sm$residuals^2)
}

n=dim(data)[1]
set.seed(12345)
id=sample(1:n, floor(n*0.5))
train=data[id,]

id1 = setdiff(1:n,id)
set.seed(12345)
id2=sample(id1, floor(n*0.5))
valid = data[id2,]
  
N = 6
fmla = vector(length=N)

for(i in 1:N){
  xnam <- paste0("I(Protein^", 1:i,")")
  fmla[i] <- (paste("Moisture ~ ", paste(xnam, collapse= "+")))
}

mseMatrix = matrix(nrow=N,ncol=2)

for(i in 1:N){
  fit1 = lm(formula(fmla[i]),data = train)
  sumfit = summary(fit1)
  mseMatrix[i,1] = mse(sumfit)
  
  pred = predict(fit1,valid)
  mseMatrix[i,2] = mean((valid$Moisture-pred)^2)
}



plot(seq(1,N,1),mseMatrix[,1], type="l",col="blue",xlab="Mi",ylab="MSE",ylim=c(31,35))
par(new=TRUE)
plot(seq(1,N,1),mseMatrix[,2], type="l",col="red", xlab="Mi",ylab="MSE",ylim=c(31,35))


############
###Step 4###
############
N = 100

myvars <- names(data) %in% c("Sample","Fat","Protein","Moisture") 
newdata <- data[!myvars]
xnam <- paste0("I(Channel", 1:N,")")
fmla2 <- (paste("Fat ~ ", paste(xnam, collapse= "+")))

fit2 = lm(as.formula(fmla2),data=data)
library(MASS)
step = stepAIC(fit2,direction="both") #63 variables

############
###Step 5###
############
X = as.matrix(newdata)
Y = as.matrix(data$Fat)

library(glmnet)
ridge = glmnet(X,Y,alpha=0,family="gaussian")
plot(ridge,xvar="lambda",label=TRUE)

############
###Step 6###
############
lasso = glmnet(X,Y,alpha=1,family="gaussian")
plot(lasso,xvar="lambda",label=TRUE)


############
###Step 7###
############
model=cv.glmnet(X,Y, alpha=1,family="gaussian")
model$lambda.min
plot(model)
coef(model, s="lambda.min")









