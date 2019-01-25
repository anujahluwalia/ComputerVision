function [points] = getHarrisPoints(I, alpha, k)
% Finds the corner points in an image using the Harris Corner detection algorithm
% Input:
%   I:                      grayscale image
%   alpha:                  number of points
%   k:                      Harris parameter
% Output:
%   points:                    point locations
%
    % -----fill in your implementation here --------
    dx = [1 1 1; 1 1 1; 1 1 1]; 
    sigma = 2;
    if (length(size(I))==2)
      I1=I;
    else
      I1=rgb2gray(I);
    end
    center = floor((size(dx)-1)/2);
    
    [Gradx,Grady]=imgradientxy(I1(:,:));
    
    %%%%%% 
    Ix = conv2(Gradx(:,:), dx, 'same');   
    Iy = conv2(Grady(:,:), dx, 'same');
 
    %%%%% 
    Ix2 = conv2(Ix.^2, dx, 'same'); 
    Iy2 = conv2(Iy.^2, dx, 'same');
    Ixy = conv2(Ix.*Iy, dx,'same');

 %%%%%%%%%%%%%%
    h = size(I,1);
    w = size(I,2);
    R11 = (Ix2.*Iy2 - Ixy.^2) - k*(Ix2 + Iy2).^2;
    [sort_values,sort_index] = sort(R11(:),'descend');
    max_index = sort_index(1:alpha);
    [rows,cols] = ind2sub([h,w],max_index);
    points = [rows,cols];
    % ------------------------------------------

end
