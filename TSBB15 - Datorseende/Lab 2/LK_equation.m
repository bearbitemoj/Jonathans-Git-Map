function [V,C] = LK_equation(filter_size,window_size,sigma1,sigma2,I,J)
% LK_EQUATION
%
%   [V,C] = LK_equation(filter_size,window_size,sigma1,sigma2,I,J)

[gx gy] = regDerivative(filter_size,sigma1,I,J);

z1 = gx.*gx;
z2 = gx.*gy;
z3 = gy.*gy;

lp=exp(-0.5*([-window_size:window_size]/sigma2).^2);
lp=lp/sum(lp); %Normalised Gaussian Filter

z1 = conv2(lp',lp,z1,'same');
z2 = conv2(lp',lp,z2,'same');
z3 = conv2(lp',lp,z3,'same');

[ex ey] = difference(I,J,gx,gy,lp);

dx = (1./(z1.*z3-z2.^2)).*(ex.*z3 - ey.*z2);
dy = (1./(z1.*z3-z2.^2)).*(-ex.*z2 + ey.*z1);

C = 0;
V(:,:,1) = dx;
V(:,:,2) = dy;
end

