############
############
############

library(neuralnet)
set.seed(1234567890)

Var = runif(50, 0, 10)
trva = data.frame(Var, Sin=sin(Var))
tr = trva[1:25,] # Training
va = trva[26:50,] # Validation

MSE.nn = vector(length=10)

# Random initializaiton of the weights in the interval [-1, 1]
winit = runif(31,-1,1) # Your code here
  for(i in 1:10) {
    nn = neuralnet(Sin~Var,tr,threshold=i/1000, hidden = 10, startweights = winit) # Your code here in the paranthesis
    
    predict.nn = compute(nn,va[,1]) # Prediction for validation data
    
    predict.nn_ = predict.nn$net.result*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    va.r = (va$Sin)*(max(trva$Sin)-min(trva$Sin))+min(trva$Sin)
    
    MSE.nn[i] = sum((va.r - predict.nn_)^2)/nrow(va)
    # Your code here
  }

plot(nn <- neuralnet(Sin~Var,va,threshold=which.min(MSE.nn)/1000,hidden = 10,startweights = winit)) # Your code here in the paranthesis
  
# Plot of the predictions (black dots) and the data (red dots)
plot(prediction(nn)$rep1,col="blue")
points(trva, col = "red")
