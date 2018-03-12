%% Lesson 9 question 9.8
clc

K = [1 0 0; 0 0 0; 0 0 1];

K = K - mean(K,1);
K = K - mean(K,2);
K = K + sum(sum(K))/length(K)^2;

K*length(K)^2