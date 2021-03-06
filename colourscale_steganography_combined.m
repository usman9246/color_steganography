%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%   LSB 3-bit COLOURED-SCALE STEGANOGRAPHY

%   Author                   Usman Iqbal
%   Email                    usmaniqbal0001@gmail.com
%   Contact                  +923355251592
%   Last Modified            July 27, 2018

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

%% Conditioning of images
%checking for unequal sizes of both images
[r1,c1,l1] = size(img1);
[r2,c2,l2] = size(img2);
r = min(r1,r2);
c = min(c1,c2);
img1 = imresize(img1,[r c]);
img2 = imresize(img2,[r c]);

%% Performing steganography
disp('Performing steganography')
final_img = img1;
for i=1:r
    for j=1:c
        for k=1:3
            num1 = bitand(img1(i,j,k),248);
            num2 = bitshift(img2(i,j,k),-5);
            final_img(i,j,k) = bitor(num1,num2);
        end
    end
end

%% Recovering the concealed image
disp('Recovering the concealed image')
recovered_img = final_img;
for i=1:r
    for j=1:c
        for k=1:3
            recovered_img(i,j,k) = bitshift(final_img(i,j,k),5);
        end
    end
end

%% Displaying images
figure;
subplot(221)
imshow(img1)
title('MAIN IMAGE')
subplot(222)
imshow(img2)
title('IMAGE TO BE CONCEALED')
subplot(223)
imshow(final_img)
title('CONCEALED IMAGE')
subplot(224)
imshow(recovered_img)
title('RECOVERED IMAGE')

disp('Done')