%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   LSB COLOURED-SCALE STEGANOGRAPHY (Comparison)

%   Author                   Usman Iqbal
%   Email                    usmaniqbal0001@gmail.com
%   Contact                  +923355251592
%   Last Modified            July 29, 2018

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;

%% Getting the input images
disp('Provide the main image...')
[img_file1, img_path1] = uigetfile({'*.png'});
img1 = imread([img_path1,img_file1]);
disp('Provide the image to be concealed...')
[img_file2, img_path2] = uigetfile({'*.png'});
img2 = imread([img_path2,img_file2]);
tic;

%% Conditioning of images
%checking for unequal sizes of both images
[r1,c1,l1] = size(img1);
[r2,c2,l2] = size(img2);
r = min(r1,r2);
c = min(c1,c2);
img1 = imresize(img1,[r c]);
img2 = imresize(img2,[r c]);

%% Main Function
for n=1:7
    %performing steganography
    fprintf('\nPerforming %d-bit LSB steganography...\n',n);
    values = [254, 252, 248, 240, 224, 192, 128];
    final_img = img1;
    for i=1:r
        for j=1:c
            for k=1:3
                num1 = bitand(img1(i,j,k),values(n));
                num2 = bitshift(img2(i,j,k),n-8);
                final_img(i,j,k) = bitor(num1,num2);
            end
        end
    end

    %recovering the concealed image
    fprintf('Recovering the image from %d-bit LSB steganography...\n',n);
    recovered_img = final_img;
    for i=1:r
        for j=1:c
            for k=1:3
                recovered_img(i,j,k) = bitshift(final_img(i,j,k),8-n);
            end
        end
    end
    
    %comparison\correlation
    for k=1:3
        one(k,n) = corr2(img1(:,:,k), final_img(:,:,k));
        two(k,n) = corr2(img2(:,:,k), recovered_img(:,:,k));
    end
end

%% Plotting
one(4,:) = mean(one);
two(4,:) = mean(two);
clr_title = {'RED LAYER', 'GREEN LAYER', 'BLUE LAYER', 'AVERAGE OF THREE LAYERS'};

%plotting the correlation values
for i=1:4
    j = 3*i - 2;
    k = 3*i;
    subplot(2,2,i)
    plot(1:7,one(i,:),'-x',1:7,two(i,:),'-x','LineWidth',2)
    xlabel('Steganography Type (bits)')
    ylabel('Correlation with Original Image')
    title(clr_title(i))
    ylim([0.7 1.05])
    legend({'Main Image Correlation','Concealed Image Correlation'},'Location','southwest')
end
fprintf('\n\n');
toc;

disp('Done')