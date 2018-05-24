function cH = calcHarris(T,k)
%CALCHARRIS
%
%   cH = calcHarris(T,k)
%   T is a structure tensor.
%   

cH = T(:,:,1).*T(:,:,3)-T(:,:,2).^2-k.*(T(:,:,1)+T(:,:,3)).^2;

end

