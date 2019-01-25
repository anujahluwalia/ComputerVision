function briefRotTest
im = imread('../data/model_chickenbroth.jpg');
num = zeros(1,37);

if size(im,3) == 3
    im = rgb2gray(im);
end
im = im2double(im);
[locs1, desc1] = briefLite(im);

for i = 0:36
    im_rot = imrotate(im,i*10);
    [locs2, desc2] = briefLite(im_rot);
    [matches] = briefMatch(desc1, desc2);    
    p1 = locs1(matches(:,1),:);
    p2 = locs2(matches(:,2),:);
    if (size(p2,1) > 4)
    [ ~, inliers] = computeH_ransac( p1, p2);    
    num(1,i+1) = sum(inliers);
    end
end
bar(0:10:360,num);
xlabel('Degree');
ylabel('Correct Matches');

end
