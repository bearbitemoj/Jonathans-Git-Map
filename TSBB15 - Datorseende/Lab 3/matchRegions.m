function [indexPairs] = matchRegions(regionL,regionR)
% Calculate a distance matrix between the regions and take a joint min to
% find index pairs.

distanceMatrix = zeros(size(regionL,1),size(regionL,2));

for i=1:size(regionL,2)
    for j=1:size(regionR,2)        
        distanceMatrix(i,j) = norm(regionL(:,i)-regionR(:,j));
    end
end

[Y,IND1,IND2]= joint_min(distanceMatrix);
indexPairs = [IND1, IND2];

end
