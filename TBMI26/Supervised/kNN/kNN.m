function [ labelsOut ] = kNN(X, k, Xt, Lt)
%KNN Your implementation of the kNN algorithm
%   Inputs:
%               X  - Features to be classified
%               k  - Number of neighbors
%               Xt - Training features
%               Lt - Correct labels of each feature vector [1 2 ...]'
%
%   Output:
%               LabelsOut = Vector with the classified labels

n = size(X,2);
labelsOut  = zeros(n,1); % Predicted class vector
classes = unique(Lt); % Unique classes
numClasses = length(classes);  % How many classes are there

% Calculate the euclidian distance for each feature
d = pdist2(X',Xt'); % Distance matrix

% For every feature in X, calculate the class from the k-nearest neighbours
for i=1:n
    featureDistance = d(i,:);
    [~,index] = sort(featureDistance,'ascend');

    % Retrieve the k-nearest neighbours
    k_nearest = zeros(k,1);
    for j=1:k
       k_nearest(j) = Lt(index(j));
    end
    
    % Calculate the number of nearest neighbours for a specific class
    count = zeros(numClasses,1);
    for l=1:numClasses
        count(l) = sum(k_nearest==l);
    end
    [~,label] = max(count); % Chose the label with the most nearest neighbours
    labelsOut(i) = label; % Predicted label
end

end

