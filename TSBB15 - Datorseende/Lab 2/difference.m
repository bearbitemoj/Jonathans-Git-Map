function [e1 e2] = difference(I,J,gx,gy,lp)
% DIFFERENCE
%
%   [e1 e2] = DIFFERENCE(I,J,gx,gy,lp)

e1 = (I-J).*gx;
e2 = (I-J).*gy;
e1 = conv2(lp',lp,e1,'same');
e2 = conv2(lp',lp,e2,'same');
end

