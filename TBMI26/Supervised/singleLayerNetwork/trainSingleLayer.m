function [Wout, trainingError, testError ] = trainSingleLayer(Xt,Dt,Xtest,Dtest, W0,numIterations, learningRate )
%TRAINSINGLELAYER Trains the network (Learning)
%   Inputs:
%               X* - Trainin/test features (matrix)
%               D* - Training/test desired output of net (matrix)
%               W0 - Weights of the neurons (matrix)
%
%   Output:
%               Wout - Weights after training (matrix)
%               trainingError - The training error for each iteration
%                               (vector)
%               testError - The test error for each iteration
%                               (vector)

% Initiate variables
trainingError = nan(numIterations+1,1);
testError = nan(numIterations+1,1);
Nt = size(Xt,2);
Ntest = size(Xtest,2);
Wout = W0;

% Calculate initial error
Yt = runSingleLayer(Xt, W0);
Ytest = runSingleLayer(Xtest, W0);
trainingError(1) = sum(sum((Yt - Dt).^2))/Nt;
testError(1) = sum(sum((Ytest - Dtest).^2))/Ntest;

for n = 1:numIterations
    Y = Wout.*Xt;
    Y = Y(1,:)+Y(2:end,:);
    grad_w = (Y-Dt).*Xt(2:end,:);
    
    Wout = [Wout(1,:); Wout(2:end,:) - learningRate*grad_w];
    Y = Wout.*Xt;
    Y = Y(1,:)+Y(2:end,:);
    Ytest = Wout.*Xtest;
    Ytest = Ytest(1,:)+Ytest(2:end,:);
    trainingError(1+n) = sum(sum((Y - Dt).^2))/Nt;
    testError(1+n) = sum(sum((Ytest - Dtest).^2))/Ntest;
end
end

