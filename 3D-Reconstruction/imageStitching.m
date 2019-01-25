function [panoImg] = imageStitching(img1, img2, H2to1)
%
% input
% Warps img2 into img1 reference frame using the provided warpH() function
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation
%
% output
% Blends img1 and warped img2 and outputs the panorama image

%%%
warp_im = warpH(img2,H2to1,[size(img1,1),size(img1,2)]);
warp_im = im2double(warp_im);
img1 = im2double(img1);
mask_im = warp_im == 0;
mask_final = not(mask_im);
imwrite(warp_im,'q4_1.jpg');
H2to1out = H2to1 * (1/H2to1(3,3));
panoImg = mask_im.*img1 + mask_final.*warp_im;

end