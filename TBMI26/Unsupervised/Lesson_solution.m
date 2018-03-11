%% Lesson 8 Problem 8.7)
clc

X = [-1 -1 -1 1 1 1; -1 0 1 -1 0 1];
P = [-0.5 0.5; 0 0];
C1 = eye(2);
C2 = C1;
C = zeros(2,2,2);
C(:,:,1) = C1;
C(:,:,2) = C2;

k_means(P,X,2)
mixture_of_gaussian(P,X,C,2)