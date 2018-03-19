function [F_gs,bestResid, bestStd] = goldStandard(F,sampleLeft,sampleRight)

% Compute an initial estimate of the subsidiary variables {x'_i, x_i}
% Choose camera matrices
[C1,C2]=fmatrix_cameras(F); % camera matrix C1=[(e')x*F e'] and C2=[I 0] 

% Estimate 3D points using triangulation
for i=1:size(sampleLeft,1)
    Dpoints(:,i) = triangulate_optimal(C1,C2,sampleLeft(i,:)',sampleRight(i,:)');
    Dpoints(:,i) = Dpoints(:,i)/Dpoints(4,i);
end

Dpoints = Dpoints(1:3,:);

bestResid2 = fmatrix_residuals_gs([C1(:); Dpoints(:)],sampleLeft',sampleRight');
bestStd2 = std(bestResid2(:));

% Minimize the cost to get the "optimal" F
lsqResult = lsqnonlin(@(x) fmatrix_residuals_gs(x,sampleLeft',sampleRight'),[C1(:); Dpoints(:)]);
C1_gs = reshape(lsqResult(1:(3*4)),[3,4]);
Dpoints_gs = reshape(lsqResult((3*4)+1:end),[3,10]);

bestResid = fmatrix_residuals_gs(lsqResult,sampleLeft',sampleRight');
bestStd = std(bestResid(:));
F_gs = fmatrix_from_cameras(C1_gs,C2);

end

