function [V C] = LK_equation_multiscale(filter_size,window_size,sigma1,sigma2,I,J,numberOfScales)

tempJ = J;
V = 0;
for n = numberOfScales:-1:1
sc = 2^(n-1);
[Vn,Cn] = LK_equation(sc*filter_size,sc*window_size,sc*sigma1,sc*sigma2,I,tempJ);

Vn(:,:,1) = medfilt2(Vn(:,:,1));
Vn(:,:,2) = medfilt2(Vn(:,:,2));

V = V + Vn;

tempJ = interpolation(J,V);
end

C = Cn;

end

