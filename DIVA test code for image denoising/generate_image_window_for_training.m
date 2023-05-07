% Prepare training data set

% First put the training data folder inside data folder before runningn the code. This folder should contain 2D image files for training.

% This code will generate 2D windows from that big 2D images. This generated 2D windows will be used for training.

clear all;
close all;
clc;

% Directories for input images and output images
inputDir = '.\data\training_set\';
output_Dir = '.\data\training_set_windows\';

% Get all image files in the directory
imageFiles = dir(strcat(inputDir, '*.png'));

% if output directory does not exist then create it
if(exist(output_Dir, 'dir') == 0)
    mkdir(output_Dir);
end

display('Begin preparing training data...');
tic;

% Run through all images
nImages = length(imageFiles);

% creat space for the patch
window_size = 150;
stride = 50;
j = 1;

for i = 1 : nImages
   
    % Read image and convert to a grayscale and double matrix
    imageName =  imageFiles(i).name;
    image = imread(strcat(inputDir, imageName));
    
    if size(image,3) == 3
        image = rgb2gray(image);
        image = im2double(image);
    else
        image = im2double(image);
    end
    
    % normalized the image if needed
    % image = image/max(image(:));
    
    % find image size
    [h, w] = size(image);
    for k = 0: (fix( (h-window_size)/stride) )
        for l = 0: (fix( (w-window_size)/stride) )
            img(:,:) = image( (1+k*stride):(window_size+k*stride), ...
                           (1+l*stride):(window_size+l*stride) );            
            
            j = j + 1;
            % save image window
            images_Name = strcat(output_Dir, 'training_',num2str(j),'.png');
            imwrite(img, images_Name)
        end
    end
    
    
end
toc
display('finished process..');
