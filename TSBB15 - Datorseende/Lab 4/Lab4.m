initcourse TSBB15

%% Anisotropic Diffusion
clear all
close all
clc

% Set parameters
%testCircle;
filter_size = 9;
sigma = 1;
filter_size2 = 15;
sigma2 = 4;

iterations = 50;
K = 0.01;
deltaS = 0.1;

img = im2double(imread('cameraman.tif'));
v = var(img(:));
SNR = 5;
imgNoise = imnoise(img,'gaussian',0,v/10^(SNR/10)); % additive noise
imgNoise2 = imnoise(img,'speckle',v/10^(SNR/10)); % multiplicative noise

u = imgNoise;

% Iterate
for(i=1:iterations)
    
% Compute orientation tensor
[fx fy] = regDerivative(filter_size,sigma,u);
T = calc_orientationTensor(filter_size2,sigma2,fx,fy);

% Calculate eigenvalues
trT = T(:,:,1)+T(:,:,3);
detT = T(:,:,1).*T(:,:,3) - T(:,:,2).^2;

lambda1 = sqrt((trT./2).^2 - detT) + trT./2;
lambda2 = -sqrt((trT./2).^2 - detT) + trT./2;

% Calculate eigenvectors
eigenVectors1(:,:,1) = T(:,:,2);
eigenVectors1(:,:,2) = lambda1 - T(:,:,1);

norm = sqrt(eigenVectors1(:,:,1).^2 + eigenVectors1(:,:,2).^2);
eigenVectors1(:,:,1) = eigenVectors1(:,:,1)./norm;
eigenVectors1(:,:,2) = eigenVectors1(:,:,2)./norm;

eigenVectors2(:,:,1) = T(:,:,2);
eigenVectors2(:,:,2) = lambda2 - T(:,:,1);

norm2 = sqrt(eigenVectors2(:,:,1).^2 + eigenVectors2(:,:,2).^2);
eigenVectors2(:,:,1) = eigenVectors2(:,:,1)./norm2;
eigenVectors2(:,:,2) = eigenVectors2(:,:,2)./norm2;

% Modify eigenvalues => D
modLambda1 = exp(-lambda1/K);
modLambda2 = exp(-lambda2/K);

D(:,:,1) = modLambda1.*eigenVectors1(:,:,1).^2 + modLambda2.*eigenVectors2(:,:,1).^2;
D(:,:,2) = modLambda1.*eigenVectors1(:,:,1).*eigenVectors1(:,:,2) + modLambda2.*eigenVectors2(:,:,1).*eigenVectors2(:,:,2);
D(:,:,3) = modLambda1.*eigenVectors1(:,:,2).^2 + modLambda2.*eigenVectors2(:,:,2).^2;

% Compute Hessian Hu
[Fxx Fxy Fyy] = hessianDerivative(u);
Hu(:,:,1) = Fxx;
Hu(:,:,2) = Fxy;
Hu(:,:,3) = Fyy;

% Update u
DHu(:,:,1) = D(:,:,1).*Hu(:,:,1) + D(:,:,2).*Hu(:,:,2);
DHu(:,:,2) = D(:,:,1).*Hu(:,:,2) + D(:,:,2).*Hu(:,:,3);
DHu(:,:,3) = D(:,:,2).*Hu(:,:,2) + D(:,:,3).*Hu(:,:,3);

trDHu = DHu(:,:,1) + DHu(:,:,3);

u = u + deltaS*trDHu;

end

figure(2);
str = sprintf('Noisy Image, additive noise, SNR = %i dB',SNR);
str2 = sprintf('Noisy Image, multiplicative noise, SNR = %i dB',SNR);
subplot(1,2,1);imagesc(imgNoise); title(str); colorbar; colormap gray;
subplot(1,2,2);imagesc(u); title('Anisotropic Diffusion'); colorbar; colormap gray;

%% SNR
clear all
close all
clc

img = im2double(imread('cameraman.tif'));
v = var(img(:));
SNR = 5;
imgNoise = imnoise(img,'gaussian',0,v/10^(SNR/10)); % additive noise
imgNoise2 = imnoise(img,'speckle',v/10^(SNR/10)); % multiplicative noise

figure(2323);
subplot(1,3,1);imshow(img);title('Original Image');
str = sprintf('Noisy Image, additive noise, SNR = %i dB',SNR);
subplot(1,3,2);imshow(imgNoise);title(str);
str = sprintf('Noisy Image, multiplicative noise, SNR = %i dB',SNR);
subplot(1,3,3);imshow(imgNoise2);title(str);

%% Inpainting via Total Variation
clear all
close all
clc

% Set parameters
filter_size = 10;
sigma = 1;
alpha = 0.05; % Learning rate
lambda = 0.01;
iterations = 800;
eps = 10^(-6);

img = im2double(imread('cameraman.tif'));
img = imresize(img, 2);

g = img;
g(1:2:end,1:2:end) = 0;
u = g;

Xomega = g;
Xomega(Xomega>0) = 1;

% Iterate
for(i=1:iterations)
    % Get derivatives
    [fx fy] = regDerivative(filter_size,sigma,u);
    
    % Compute Hessian Hu
    [Fxx Fxy Fyy] = hessianDerivative(u);
    Hu(:,:,1) = Fxx;
    Hu(:,:,2) = Fxy;
    Hu(:,:,3) = Fyy;
    
    u = u - alpha*(Xomega.*(u-g)-lambda*(Fxx.*(fy).^2 - 2*Fxy.*fx.*fy + Fyy.*(fx).^2)./(sqrt(fx.^2 + fy.^2).^3+eps));
    u(isnan(u)) = 0;
end

figure(3);
subplot(1,2,1);imagesc(img); title('Original Image'); colorbar; colormap gray;
subplot(1,2,2);imagesc(g); title('Damaged Image'); colorbar; colormap gray;

figure(4);
imagesc(u, [0 1]); title('Resulting Image'); colorbar; colormap gray;










