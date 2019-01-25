function im3 = generatePanorama(im1, im2)
im1_in=im1;
im2_in=im2;
if (size(im1,3)==3)
  im1=rgb2gray(im1);
end
if (size(im2,3)==3)
  im2=rgb2gray(im2);
end
im1 = im2double(im1);
im2 = im2double(im2);
[locs1, desc1] = briefLite(im1);
[locs2, desc2] = briefLite(im2);

[matches] = briefMatch(desc1, desc2);

p1 = locs1(matches(:,1),:);
p2 = locs2(matches(:,2),:);
[bestH] = computeH_ransac(p1, p2);

[im3]=imageStitching_noClip(im1_in,im2_in,bestH);

imwrite(im3,'./q4_3.jpg');
end