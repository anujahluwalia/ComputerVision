function [panoImg] = imageStitching_noClip(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image
%
% To prevent clipping at the edges, we instead need to warp both image 1 and image 2 into a common third reference frame 
% in which we can display both images without any clipping.

%%%
width = 1500;
r = size(img2,1);
c = size(img2,2);
corner = [1, c, 1, c;1,   1, r, r;1,   1,  1,  1];
warp_c = H2to1 * corner;
warp_c = ceil(warp_c./[warp_c(3,:);warp_c(3,:);warp_c(3,:)]);


if min(warp_c(2,:)) < 1
    row_ll = min(warp_c(2,:));
else
    row_ll = 1;
end

if min(warp_c(1,:)) < 1
    col_ll = min(warp_c(1,:));
else
    col_ll = 1;
end

if max(warp_c(2,:)) > size(img1,1)
    row_ul = max(warp_c(2,:));
else
    row_ul = size(img1,1);
end

if max(warp_c(1,:)) > size(img1,2)
    col_ul = max(warp_c(1,:));
else
    col_ul = size(img1,2);
end

scale = (col_ul - col_ll)/(row_ul - row_ll);

height = width/scale;
height = round(height);
out_size = [height,width];

s = width/(col_ul - col_ll);
M = [s 0 0;0 s -row_ll;0 0 1];

warp_im1 = warpH(img1, M, out_size);
warp_im2 = warpH(img2, M*H2to1, out_size);
panoImg = max(warp_im1,warp_im2);
imwrite(warp_im2,'./q4_2.jpg');

end