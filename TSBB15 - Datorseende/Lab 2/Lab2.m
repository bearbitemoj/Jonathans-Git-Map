%% Add path
clear all
addpath(genpath('TSBB15-course-functions'));
addpath(genpath('Lab 2'));

%%
close all
clc

%[I J dTrue] = getCameraman();
I = im2double(imread('forwardL0.png'));
J = im2double(imread('forwardL1.png'));
figure(1)
subplot(1,2,1);imagesc(I);axis image;colorbar;
subplot(1,2,2);imagesc(J);axis image;colorbar;

%[V C] = LK_equation(20,40,2,10,I,J);

[V C] = LK_equation_multiscale(20,40,2,10,I,J,4);

figure(2)
%gopimage(V)
quiver(V(:,:,1),V(:,:,2))

%Check error difference, should be error > error2
error = sum(sum(abs(I-J)))
interp = interpolation(J,V);
%interp(isnan(interp)) = 0;

figure(3)
subplot(1,2,1);imagesc(imfuse(I,interp));axis image;
subplot(1,2,2);imagesc(imfuse(I,J));axis image;

error2 = sum(sum(abs(I-interp)))

figure(4)
subplot(1,2,1);imagesc(V(:,:,1));axis image;
subplot(1,2,2);imagesc(V(:,:,2));axis image;
