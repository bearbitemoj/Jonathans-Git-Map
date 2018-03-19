function [indexPairs] = matchRegions(regionL,regionR,pointsLeft,pointsRight)
% Every row in points matches every column in region

distanceMatrix = zeros(size(regionL,1),size(regionL,2));

for i=1:size(regionL,2)
    for j=1:size(regionR,2)        
        distanceMatrix(i,j) = norm(regionL(:,i)-regionR(:,j));
    end
end

[Y,IND1,IND2]= joint_min(distanceMatrix);
indexPairs = [IND1, IND2];

end
