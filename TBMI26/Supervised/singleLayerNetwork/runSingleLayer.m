function [ Y, L ] = runSingleLayer(X, W)
%RUNSINGLELAYER Summary of this function goes here
%   Inputs:
%               X  - Features to be classified (matrix)
%               W  - Weights of the neurons (matrix)
%
%   Output:
%               Y = Output for each feature, (matrix)
%               L = The resulting label of each feature, (vector) 


Y = W.*X;
Y = Y(1,:)+Y(2:end,:);

% Calculate classified labels
[~, L] = max(Y,[],1);
L = L(:);
end

