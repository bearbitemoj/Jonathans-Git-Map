function T = calc_orientationTensor(filter_size,sigma,fx,fy)
% CALC_ORIENTATIONTENSOR
%
%    function T = calc_orientationTensor(filter_size,sigma,fx,fy)
%    filter_size is an integer.
%    sigma is a double.
%    fx is a MxN gradient matrix.
%    fy is a MxN gradient matrix.

T=zeros(size(fx,1),size(fx,2),3);
T(:,:,1)=fx.*fx;
T(:,:,2)=fx.*fy;
T(:,:,3)=fy.*fy;

lp=exp(-0.5*([-filter_size:filter_size]/sigma).^2);
lp=lp/sum(lp); %Normalised Gaussian Filter

T(:,:,1) = conv2(lp',lp,T(:,:,1),'same');
T(:,:,2) = conv2(lp',lp,T(:,:,2),'same');
T(:,:,3) = conv2(lp',lp,T(:,:,3),'same');
end

