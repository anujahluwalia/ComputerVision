im1_in = imread('../data/cv_cover.jpg');
im2_in = imread('../data/cv_desk.png');
im3_in = imread('../data/hp_cover.jpg');

im1 = im1_in;
im2 = im2_in;
im3 = im3_in;
if (size(im1_in,3)==3)
  im1=rgb2gray(im1_in);
end
if (size(im2_in,3)==3)
  im2=rgb2gray(im2_in);
end
if (size(im3_in,3)==3)
  im3=rgb2gray(im3_in);
end
im1 = im2double(im1);
im2 = im2double(im2);
im3 = im2double(im3);
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

[matches] = briefMatch(desc1, desc2);

p1 = locs1(matches(:,1),:);
p2 = locs2(matches(:,2),:);
[bestH] = computeH_ransac(p2, p1);

numrows = size(im1,1);
numcols = size (im1,2);
im3_resize = imresize(im3_in,[numrows numcols]) ;

warp_im = warpH(im3_resize,bestH,[size(im2,1),size(im2,2)]);
warp_im = im2double(warp_im);

im2_in = im2double(im2_in);
composite_img = compositeH(bestH, warp_im, im2_in );
composite_img = im2double(composite_img);
imshow(composite_img)
bestH2 = bestH * (1/bestH(3,3))
