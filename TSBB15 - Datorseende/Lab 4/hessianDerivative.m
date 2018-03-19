function [Fxx Fxy Fyy] = hessianDerivative(im)
% function [fx fy] = regDerivative(im)
%

h1 = [0 0 0; 1 -2 1; 0 0 0]/4;
h2 = [0.25 0 -0.25; 0 0 0; -0.25 0 0.25];
h3 = [0 1 0; 0 -2 0; 0 1 0]/4;


Fxx = conv2(im,h1,'same');
Fxy = conv2(im,h2,'same');
Fyy = conv2(im,h3,'same');
end

