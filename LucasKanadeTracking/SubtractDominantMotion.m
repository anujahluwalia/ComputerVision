function mask = SubtractDominantMotion(image1, image2)
% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size
image1 = im2double(image1);
image2 = im2double(image2);
M = LucasKanadeAffine(image1, image2);
threshold = 0.05;
[x_template,y_template] = meshgrid(1:size(image1,2),1:size(image1,1));
T1 = [x_template(:)';y_template(:)';ones(1,length(x_template(:)))];
img_warp = M * T1;
x_image = img_warp(1,:);
y_image = img_warp(2,:);
image2_interp = interp2(image2,x_image,y_image);
image2_interp = reshape(image2_interp,size(image2));
mask = abs(image2_interp - image1);
for i=1:size(mask,1)
    for j = 1:size(mask,2)
        if mask(i,j) > threshold
            mask(i,j)=1;
        else
            mask(i,j)=0;
        end
    end
end
mask = bwareaopen(mask,50);
dil = strel('disk',6);
mask = imdilate(mask,dil);
end
