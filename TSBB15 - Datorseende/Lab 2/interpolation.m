function out = interpolation(J,V)
% INTERPOLATION
%
%   out = INTERPOLATION(J,V)

[X,Y] = meshgrid(1:size(J,2),1:size(J,1));
out = interp2(X,Y,J,X+V(:,:,1),Y+V(:,:,2),'linear',0);
end

