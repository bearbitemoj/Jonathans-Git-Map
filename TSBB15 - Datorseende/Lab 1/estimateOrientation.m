function z = estimateOrientation(gradX,gradY)
% ESTIMATEORIENTATION
%
%   z = estimateOrientation(gradX,gradY)

Jx = gradX;
Jy = gradY;
z1 = Jx.*Jx;
z2 = Jx.*Jy;
z3 = Jy.*Jy;
z1 = sum(sum(z1));
z2 = sum(sum(z2));
z3 = sum(sum(z3));
z = [z1 z2; z2 z3];
end

