############
############
############

library(neuralnet)
set.seed(1234567890)

Var = runif(50, 0, 10)
trva = data.frame(Var, Sin=sin(Var))
tr = trva[1:25,] # Training
va = trva[26:50,] # Validation

MSE.nn.va = vector(length=10)
MSE.nn.tr = vector(length=10)

# Random initializaiton of the weights in the interval [-1, 1]
set.seed(1234567890)
winit = runif(31,-1,1)
  for(i in 1:10) {
    nn = neuralnet(Sin~Var,tr,threshold=i/1000, hidden = 10, startweights = winit) 
    
    predict.nn = compute(nn,va[,1]) # Prediction for validation data
    predict.nn_ = predict.nn$net.result*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    va.r = (va$Sin)*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    MSE.nn.va[i] = sum((va.r - predict.nn_)^2)/nrow(va)
    
    predict.nn = compute(nn,tr[,1]) # Prediction for training data
    predict.nn_ = predict.nn$net.result*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    tr.r = (tr$Sin)*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    MSE.nn.tr[i] = sum((tr.r - predict.nn_)^2)/nrow(tr)
    # Your code here
  }
plot(MSE.nn.va,type="b",col="blue",ylim=c(0,0.005))
points(MSE.nn.tr,type="b",col="red")
legend("bottomright", legend=c("Training Data","Validation Data"), lty=c(1,1),col=c("red","blue"),bg="white",lwd=1)

plot(nn <- neuralnet(Sin~Var,trva,threshold=which.min(MSE.nn.va)/1000,hidden = 10,startweights = winit))
  
# Plot of the predictions (red dots) and the data (green dots)
plot(prediction(nn)$rep1,col="red",type='b')
points(trva, col = "green")
legend("bottomright", legend=c("Prediction Data","Actual Data"), lty=c(1,1),col=c("red","green"),bg="white",lwd=1)
