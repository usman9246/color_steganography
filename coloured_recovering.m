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

%% Getting the input image
disp('Provide the image...')
[img_file, img_path] = uigetfile({'*.png'});
img = imread([img_path,img_file]);

%% Recovering the concealed image
disp('Recovering the concealed image')
[r,c,l] = size(img);
recovered_img = img;
for i=1:r
    for j=1:c
        for k=1:3
            recovered_img(i,j,k) = bitshift(img(i,j,k),5);
        end
    end
end

imwrite(recovered_img,'recovered.png');
disp('Done')