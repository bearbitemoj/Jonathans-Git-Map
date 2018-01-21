function [k] = cross_validation(f,Xt,Lt)
%CROSS_VALIDATION Calculates the cross validation of a data set
%   Inputs:
%               f  - number of folds
%               Xt - Cell arrays of features
%               Lt - Cell arrays of correct labels of each feature vector [1 2 ...]'
%
%   Output:
%               k = optimal number of nearest neighbours

n = size(Xt{1},1);
m = size(Xt{1},2);
k_vector = [1 2 3 4 5]; % A vector with different k values to be tested
accuracy_matrix = zeros(length(k_vector),f); % The accuracy for each permutation of folds
X_train = zeros(n,m);
L_train = zeros(length(Lt{1}),1);
first_run = 1;

for i=1:f
    X_test = Xt{i}; % Set a fold to test data
    L_test = Lt{i};
    
    % Set the other folds as training data
    for j=1:f        
        if(i ~= j)
            if(first_run == 1)
                X_train(:,:) = Xt{j};
                L_train(:) = Lt{j};
                first_run = 2;
            else
                X_train = [X_train Xt{j}];
                L_train = [L_train; Lt{j}];
            end
        end
    end
    
    % Cacluate the kNN for different k:s, calculate the accuracy and add it
    % to a matrix
    for a=1:length(k_vector)
        LkNN = kNN(X_test, k_vector(a), X_train, L_train);
    
        cM = calcConfusionMatrix( LkNN, L_test);
        accuracy_matrix(a,i) = calcAccuracy(cM);
    end
end

[~,I]=max(mean(accuracy_matrix,2));

k = k_vector(I);

end

