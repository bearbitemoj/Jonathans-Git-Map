############
###Step 1###
############
data = read.csv2('tecator.csv')

Moisture = data$Moisture
Protein = data$Protein

plot(Moisture,Protein)

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

fit1 = vector(length=6)

for(i in 1:N){
  xnam <- paste0("I(Protein^", 1:i,")")
  fmla[i] <- (paste("Moisture ~ ", paste(xnam, collapse= "+")))
}

mseMatrix = matrix(nrow=N,ncol=2)

for(i in 1:N){
  fit1 = lm(formula(fmla[i]),data = train)
  sumfit = summary(fit1)

  mseMatrix[i,1] = mse(sumfit)
}

for(i in 1:N){
  fit1 = lm(formula(fmla[i]),data = valid)
  sumfit = summary(fit1)
  
  mseMatrix[i,2] = mse(sumfit)
}

plot(seq(1,6,1),mseMatrix[,1], type="l",col="blue",xlab="Mi",ylab="Validation Data",ylim=c(30.5,34))
plot(seq(1,6,1),mseMatrix[,2], type="l",col="red", xlab="Mi",ylab="Test Data",ylim=c(30.5,34))


############
###Step 4###
############





