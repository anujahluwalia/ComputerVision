function [ bestH2to1, inliers] = computeH_ransac( locs1, locs2)
%COMPUTEH_RANSAC A method to compute the best fitting homography given a
%list of matching points.

N=size(locs1,1);
tol=10;
pref = [locs1(:,1)';locs1(:,2)';ones(1,N)];
pcurr = [locs2(:,1)';locs2(:,2)';ones(1,N)];
inliers = zeros(1,N);
for i = 1:1000
    % Four random correspondences
    randomIndex = randperm(size(locs1,1),4);
    locs1_random = locs1(randomIndex,:);
    locs2_random = locs2(randomIndex,:);
    H0 = computeH(locs1_random',locs2_random');
    d = H0*pcurr;
    d(1,:) = d(1,:)./d(3,:);
    d(2,:) = d(2,:)./d(3,:);
    deter = pref-d;
    deter = sqrt(sum(deter.^2));
    inliers_curr = deter < tol;
    if sum(inliers_curr) > sum(inliers)
        inliers = inliers_curr;
    end
end
  inliers_indices = find(inliers~=0);
  p1_inliers = locs1(inliers_indices,:);
  p2_inliers = locs2(inliers_indices,:);
  bestH2to1 = computeH(p1_inliers',p2_inliers');

end

