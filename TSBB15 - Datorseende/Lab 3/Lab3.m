%% Add path
initcourse TSBB15

%% Estimate F using RANSAC and Gold standard Algorithm
clear all
close all
clc

im1 = rgb2gray(imread('img1.png'));
im2 = rgb2gray(imread('img2.png'));

figure(1);
subplot(1,2,1);imshow(im1);
subplot(1,2,2);imshow(im2);

% Compute interest points in each image
[H1,dIm] = harris(im1,5,1);
[H2,dIm2] = harris(im2,5,1);

figure(2);
subplot(1,2,1);imshow(H1);
subplot(1,2,2);imshow(H2);

% Threshold the harris points
H1(H1<1.64*10^3) = 0;
H2(H2<1*10^3) = 0;

Im1_supp = non_max_suppression(H1,3);
Im2_supp = non_max_suppression(H2,3);

figure(3);
subplot(1,2,1); imshow(Im1_supp);
subplot(1,2,2); imshow(Im2_supp);

mask = zeros(size(Im1_supp,1),size(Im1_supp,2));
mask(Im1_supp>0) = 1;
mask = logical(mask);
[row col] = find(mask);
pointsLeft = [col row]; %row = y-coords, col = x-coords

mask = zeros(size(Im2_supp,1),size(Im2_supp,2));
mask(Im2_supp>0) = 1;
mask = logical(mask);
[row col] = find(mask);
pointsRight = [col row]; %row = y-coords, col = x-coords


% Compute a set of interest point matches based on proximity and simliarity
% of their intensity neighbourhood
figure(4);
subplot(1,2,1);imagesc(im1); axis image;
hold on
show_regions(pointsLeft(:,1),pointsLeft(:,2),9);
hold off

subplot(1,2,2);imagesc(im2); axis image;
hold on
show_regions(pointsRight(:,1),pointsRight(:,2),9);
hold off

regionL = cut_out_rois(im1,pointsLeft(:,1),pointsLeft (:,2),11);
regionR = cut_out_rois(im2,pointsRight(:,1),pointsRight(:,2),11);

indexPairs = matchRegions(regionL,regionR,pointsLeft,pointsRight);

% Show correspondences
figure(5);
hold on
show_corresp(im1,im2,pointsLeft',pointsRight',indexPairs');colormap gray;
hold off

%RANSAC robust estimation
[F,numOfInliers,sampleLeft,sampleRight,samplePairs,ransacStd, ransacResid, inlierRatio] = RANSAC(pointsLeft,pointsRight,indexPairs,15000);
close all

figure(6);
subplot(1,2,2);imshow(im2);
hold on
plot_eplines(F,pointsRight,[1 size(im1,1) 1 size(im1,2)]);
hold off

subplot(1,2,1);imshow(im1);
hold on
plot_eplines(F,pointsLeft,[1 size(im1,1) 1 size(im1,2)]);
hold off

% Show correspondences
figure(7);
hold on
show_corresp(im1,im2,pointsLeft',pointsRight',samplePairs');colormap gray;
hold off

% Non-linear least-squares and the Gold Standard algorithm
[F_gs,goldResid,goldStd] = goldStandard(F,sampleLeft,sampleRight);

%% Plot F_gs

figure(8);
subplot(1,2,2);imshow(im2);
hold on
plot_eplines(F_gs,pointsRight,[1 size(im1,1) 1 size(im1,2)]);
hold off

subplot(1,2,1);imshow(im1);
hold on
plot_eplines(F_gs,pointsLeft,[1 size(im1,1) 1 size(im1,2)]);
hold off


%% MATLAB Functions to get matching points
I1 = rgb2gray(imread('img1.png'));
I2 = rgb2gray(imread('img2.png'));

points1 = detectHarrisFeatures(I1);
points2 = detectHarrisFeatures(I2);

[features1,valid_points1] = extractFeatures(I1,points1);
[features2,valid_points2] = extractFeatures(I2,points2);

indexPairs = matchFeatures(features1,features2);

matchedPoints1 = valid_points1(indexPairs(:,1),:);
matchedPoints2 = valid_points2(indexPairs(:,2),:);

figure; showMatchedFeatures(I1,I2,matchedPoints1,matchedPoints2);









