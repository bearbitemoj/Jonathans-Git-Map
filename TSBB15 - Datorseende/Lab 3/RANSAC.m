function [bestF,bestNumOfInliers,bestSampleLeft,bestSampleRight,bestSamplePairs, bestStd,bestDistance,bestInlierRatio] = RANSAC(pointsLeft,pointsRight,indexPairs,iterations)
% Ransac robust estimation
% N is number of samples
bestNumOfInliers = 0;
bestF = 0;
bestStd = 0;

for i=1:iterations
    % Select random samples
    sample = randperm(size(indexPairs,1),10)';
    samplePairs = indexPairs(sample,:);

    sampleLeft = pointsLeft(samplePairs(:,1),:);
    sampleRight = pointsRight(samplePairs(:,2),:);

    % Use 8-point algorithm to compute F
    F = fmatrix_stls(sampleLeft',sampleRight');

    % Calculate distance d_i for each putative correspondence
    distanceAll = fmatrix_residuals(F,pointsLeft(indexPairs(:,1),:)',pointsRight(indexPairs(:,2),:)');

    % Compute the number of inliers consistent with F by the number of
    % correspondences for which d_i < t pixels
    distance = distanceAll(abs(distanceAll)<1);
    
    if(bestNumOfInliers < length(distance) || (bestNumOfInliers == length(distance) && std(distance) < bestStd))
        bestF = F;
        bestNumOfInliers = length(distance);
        bestStd = std(distance);
        bestSampleLeft = sampleLeft;
        bestSampleRight = sampleRight;
        bestSamplePairs = samplePairs;
        bestDistance = distance;
        bestInlierRatio = length(distance)/(size(distanceAll,1)*size(distanceAll,2));
    end
end
    
end

