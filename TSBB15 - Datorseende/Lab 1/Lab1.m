%% Add Path
addpath(genpath('S:\Git repos\My Git Map\TSBB15 - Datorseende\TSBB15-course-functions'));

%% 3
clear all
close all
clc

[I J dTrue] = getCameraman();
height = 70;
width = 40;
row = 85;
col = 120;

dtot = 0;
[Jx Jy] = regDerivative(9,1.2,J);

cropI= I(row-height/2:row+height/2,col-width/2:col+width/2);

tempJ = J;
tempJx = Jx;
tempJy = Jy;

for i=1:15
croptempJx = tempJx(row-height/2:row+height/2,col-width/2:col+width/2);
croptempJy = tempJy(row-height/2:row+height/2,col-width/2:col+width/2);
cropJ= tempJ(row-height/2:row+height/2,col-width/2:col+width/2);

Z = estimateOrientation(1.6,croptempJx,croptempJy);

e = difference(cropI,cropJ,croptempJx,croptempJy);

d = inv(Z)*e;

dtot = dtot + d

tempJ = interpolation(J,dtot);
tempJx = interpolation(Jx,dtot);
tempJy = interpolation(Jy,dtot);
end

%% 4
clc

im = im2double(imread('cornertest.png'));

[fx fy] = regDerivative(9,1,im);

T = calc_orientationTensor(15,2,fx,fy);

figure(1)
subplot(1,2,1);image(tens2RGB(T));axis image

cH = calcHarris(T,0.05);

figure(2)
hist(cH)
threshold = cH > 2.56*10^-5;

Imm = ordfilt2(cH,9,ones(3)); 
mask = threshold.*cH==Imm;
index = 10;
mask(1:index,:) = 0;
mask(end-index:end,:) = 0;
mask(:,1:index) = 0;
mask(:,end-index:end) = 0;

[row col] = find(mask);

[vals index] = sort(cH(mask),'descend');

row = row(index(1:30));
col = col(index(1:30));

figure(1)
subplot(1,2,2);imagesc(cH);axis image;colorbar

hold on
plot(col,row,'ro');
hold off

%% 5
close all
clc
for j=1:9
    I = im2double(imread(strcat('chessboard_',num2str(j),'.png')));
    
    if(j< 2)
        [fx fy] = regDerivative(9,1,I);

        T = calc_orientationTensor(15,2,fx,fy);

        figure(1)
        %image(tens2RGB(T));axis image
        imshow(I);axis image
        
        cH = calcHarris(T,0.05);

        %figure(2)
        %hist(cH)
        threshold = cH > 0.000128;

        Imm = ordfilt2(cH,9,ones(3)); 
        mask = threshold.*cH==Imm;
        index = 10;
        mask(1:index,:) = 0;
        mask(end-index:end,:) = 0;
        mask(:,1:index) = 0;
        mask(:,end-index:end) = 0;
        
        [row2 col2] = find(mask)
        
        [vals index] = sort(cH(mask),'descend');

        row2 = row2(index(1:5));
        col2 = col2(index(1:5));
        
        %figure(1)
        %subplot(1,2,2);imagesc(cH);axis image; colorbar

        hold on
        plot(col2,row2,'ro');
        hold off
      
    end
    
    pause(0.2)
    
    j2 = j + 1;
    J = im2double(imread(strcat('chessboard_',num2str(j2),'.png')));
    height = 40;
    width = 40;
    
    dtot = 0;
    [Jx Jy] = regDerivative(9,1.2,J);
    
    for k=1:size(row2,1)
        row = round(row2(k));
        col = round(col2(k));

        cropI= I(row-height/2:row+height/2,col-width/2:col+width/2);
        tempJ = J;
        tempJx = Jx;
        tempJy = Jy;

        for i=1:20
            croptempJx = tempJx(row-height/2:row+height/2,col-width/2:col+width/2);
            croptempJy = tempJy(row-height/2:row+height/2,col-width/2:col+width/2);
            cropJ= tempJ(row-height/2:row+height/2,col-width/2:col+width/2);

            Z = estimateOrientation(1.6,croptempJx,croptempJy);

            e = difference(cropI,cropJ,croptempJx,croptempJy);

            d = inv(Z)*e;

            dtot = dtot + d';

            tempJ = interpolation(J,dtot);
            tempJx = interpolation(Jx,dtot);
            tempJy = interpolation(Jy,dtot);
        end
        
        col2(k) = col2(k) + dtot(1);
        row2(k) = row2(k) + dtot(2);
    end
    
    figure(1);imshow(J);axis image;
    hold on
    plot(col2,row2,'ro');
    hold off
    

end


