function [img1] = myImageFilter(img0, h)
img0=double(img0);
[a,b] = size(img0);
h = rot90(h, 2);
center = floor((size(h)-1)/2);
Mid = padarray(img0,center);
ColMid = im2col(Mid, size(h));
k = h(:);
MultMid = bsxfun(@times, ColMid, k); 
%MultMid=ColMid.*k;
img1 = reshape(sum(MultMid), a, b);             
end
