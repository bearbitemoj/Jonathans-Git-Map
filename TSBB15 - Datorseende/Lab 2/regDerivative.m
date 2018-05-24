function [fx fy] = regDerivative(filter_size, sigma,im1,im2)
% REGDERIVATIVE
%
%   [fx fy] = regDerivative(filter_size, sigma,im1,im2)

lp=exp(-0.5*([-filter_size:filter_size]/sigma).^2);
lp=lp/sum(lp); %Normalised Gaussian Filter

dfx= -1/sigma^2*[-filter_size:filter_size].*lp;
dfy = -1/sigma^2*[-filter_size:filter_size].*lp;

im = (im1+im2)./2;

fx = conv2(lp',dfx,im,'same');
fy = conv2(dfy,lp,im,'same');
end

