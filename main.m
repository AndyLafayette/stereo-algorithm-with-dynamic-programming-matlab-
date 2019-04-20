clear; close all; clc

%% Read the leaf and right images from "cones" or "teddy" directory: commenting the other when one of them is used
%% Save im2.ppm and im6.ppm into im_l and im_r respectively
%% cd teddy 
cd cones
filenames = dir('*.ppm');
filenames = sort({filenames.name});
im_l = imread(filenames{3});
im_r = imread(filenames{7});
cd ..

%% test whether the images have been saved
%imshowpair(im_l, im_r, 'montage');

%% show the edge in the image
ref = rgb2gray(im_r);
ref = edge(ref, 'prewitt');
%% read the image and normalisation
im_l_temp = single(im_l);
im_r_temp = single(im_r);
im_l_temp = im_l_temp ./ 255;
im_r_temp = im_r_temp ./ 255;
%% save the size of DSI (size(im_r, 2) * size(im_r, 2))
sizeOfDSI = size(im_r, 2) - 2;

%% Calculate matching cost along ith scanline
%% In this section the shiftable window and window with varable size are used
%% The initial window size is 3x3 starts at (2,2) on the image
%% var_threshold: the varience of right image, used as threshold to determine whether edge is on homogenous region
varThreshold = var(reshape(im_r_temp, [1, size(im_r, 1) * size(im_r, 2) * size(im_r, 3)]));

%% Initialize the disparity map and costMap for DP
disparityMap = zeros(size(im_l, 1)-2, size(im_l, 2)-2) - 1;

for i = 2: size(im_r, 1) - 1
    disp(['Calculate on ', num2str(i), 'the scanline:']);
    %% Draw the DSI for i th scanline, the position on the DSI is (j,k)
    %% Initialize the DSI
    %% The main idea of DSI used here is from A.Bobick Large Occlusion Stereo 1999
    %% Create a matrix filled with -1 then replace -1 with matching cost (SSD)
    %% -1 indicates 'out of bounds' 
    DSI = zeros(sizeOfDSI, sizeOfDSI) - 1;
    pathMap = zeros(sizeOfDSI, sizeOfDSI) - 1;
    for j = 2: size(im_r, 2) - 1
        disp(['    Scanline starts at ', '(', num2str(i), ',', num2str(j), ') on the left image...']);
        %% (i, j) is the start position on the left image
        %% Before adapting the size of window by whether edge exists, initializ it to 3
        %% dis is the increment of value of j, which is the disparity
        for k = j: size(im_r, 2) - 1
            %% the position on the left image is (i, k)
            %% the position on the right image is (i, 2+k-j)
            x_l = i; y_l = k;
            x_r = i; y_r = 2+k-j;
            %% Deciding the size of window by the edge_map
            if max([ref(x_r - 1, y_r - 1), ref(x_r - 1, y_r), ref(x_r - 1, y_r + 1)
                    ref(x_r,     y_r - 1), ref(x_r,     y_r), ref(x_r,     y_r + 1)
                    ref(x_r + 1, y_r - 1), ref(x_r + 1, y_r), ref(x_r + 1, y_r + 1)]) == 1
                if var([im_r_temp(x_r - 1, y_r - 1, :), im_r_temp(x_r - 1, y_r, :), im_r_temp(x_r - 1, y_r + 1, :)
                        im_r_temp(x_r,     y_r - 1, :), im_r_temp(x_r,     y_r, :), im_r_temp(x_r,     y_r + 1, :)
                        im_r_temp(x_r + 1, y_r - 1, :), im_r_temp(x_r + 1, y_r, :), im_r_temp(x_r + 1, y_r + 1, :)]) > varThreshold
                    windowSize = 2;
                else
                    windowSize = 3;
                end
            else
                windowSize = 5;
            end
            %% According to th windowsize, calculate the best matching cost
            switch windowSize
                case 2
                    %% get the best mtching cost 
                    mc = calculateMatchingCost(im_l_temp, im_r_temp, x_l, y_l, x_r, y_r, windowSize);
                case 3
                    %% test whether the bound has been touched 
                    if x_r - 2 < 1
                        x_r = x_r + 1;
                    elseif x_r + 2 > size(im_r, 1)
                        x_r = x_r - 1;
                    end
                    if y_r - 2 < 1
                        y_r = y_r + 1;
                    elseif y_r + 2 > size(im_r, 2)
                        y_r = y_r - 1;
                    end
                    mc = calculateMatchingCost(im_l_temp, im_r_temp, x_l, y_l, x_r, y_r, windowSize);
                case 5
                    %% test whether the window on the right image touched the bound 
                    if x_r - 4 < 1
                        x_r = 5;
                    elseif x_r + 4 > size(im_r, 1)
                        x_r = size(im_r, 1) - 4;
                    end
                    if y_r - 4 < 1
                        y_r = 5;
                    elseif y_r + 4 > size(im_r, 2)
                        y_r = size(im_r, 2) - 4;
                    end
                    %% test whether the window on the left window touched the bound
                    if x_l - 2 < 1
                        x_l = x_l + 1;
                    elseif x_l + 2 > size(im_l, 1)
                        x_l = x_l - 1;
                    end
                    if y_l - 2 < 1
                        y_l = y_l + 1;
                    elseif y_l + 2 > size(im_l, 2)
                        y_l = y_l - 1;
                    end
                    mc = calculateMatchingCost(im_l_temp, im_r_temp, x_l, y_l, x_r, y_r, windowSize);
            end
            % Assign the value to DSI
            DSI(j - 1, k - 1) = mc;
        end   
    end
    %%imshow(DSI);
    %% got the pathMap for specific DSI
    [pathMap, cost] = DynamicProgramming(DSI, pathMap, 0, 0, 0); 
    %% got a row of disparity for each pixel from pathMap and draw it on the disparity map
    pathMap = GreedyAlgorithm(pathMap, 0, 0);
    disparityMap(i-1, :) = getIthRowForDisparityMap(pathMap);
end  

%% Show the disparityMap
imshow(uin8(disparityMap .* 4))
imwrite(uin8(disparityMap .* 4), 'test.ppm')