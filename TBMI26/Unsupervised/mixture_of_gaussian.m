function P = mixture_of_gaussian(P, X, C, iterations)
%MIXTURE_OF_GAUSSIAN Summary of this function goes here
%   P is a matrix containing all prototypes
%   X is a matrix containing the data set
%   C is a matrix of matrices containing the covariance matrix
%   Iterations is the number of iterations to run
%   Returns the prototype after i iterations

d = size(P,2);


if (nargin < 4)
    iterations = 1;
end

for iteration=1:iterations
    Ctemp = zeros(size(C));
    
    for j=1:d
        for i=size(X,2)
            first_part = 1/((2*pi)^(d/2)*sqrt(det(C(:,:,j))));
            second_part = exp(-1/2*(X(:,i)-P(:,j))'*inv(C(:,:,j))*(X(:,i)-P(:,j)));
            density(j,i) = first_part*second_part;
        end
    end
    
    [~, index] = max(density, [], 1); % Take out the index with max density
    
    for j=1:d
        S = sum(index==j);
        P(:,j) = 1/abs(S)*sum(X(:,index==j),2);
        
        for i=1:size(X,2)
            newC = (X(:,i) - P(:,j))*(X(:,i) - P(:,j))';
            
            Ctemp(:,:,j) = Ctemp(:,:,j) + 1/abs(S)*newC;
            if S == 0
                P(:,j) = 0;
                Ctemp(:,:,j) = 0;
            end
        end
    end
    C = Ctemp;
end


end

