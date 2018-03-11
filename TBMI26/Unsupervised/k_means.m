function P = k_means(P, X, iterations)
%K_MEANS Performs K-means on a data set
%   P is a matrix containing all prototypes
%   X is a matrix containing the data set
%   Iterations is the number of iterations to run
%   Returns the prototype after i iterations

k = size(P,2);

if (nargin < 3)
    iterations = 1;
end

for iteration=1:iterations
    D = pdist2(P',X'); % Distance matrix
    [~, index]= min(D); % Take out the index of the min distance

    for j=1:k
        S = sum(index==j);
        P(:,j) = 1/abs(S)*sum(X(:,index==j),2);
    end
end

end

