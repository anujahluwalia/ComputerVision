function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q5.1:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using eightpoint
%          - using ransac

%     In your writeup, describe your algorithm, how you determined which
%     points are inliers, and any other optimizations you made

N = size(pts1, 1);
t = 0.03;
count = 0;
while (count < 0.75*N)
    rand_points=randperm(N,7);
    pts1_1 = pts1(rand_points, :);
    pts2_2 = pts2(rand_points, :);
    F_seven = sevenpoint(pts1_1,pts2_2,M);
    for i=1:3
        F=F_seven{i};
        inlier=[];
        count = 0;
        for j = 1:N
           x1 = pts1(j, 1);
           y1 = pts1(j, 2);
           x2 = pts2(j, 1);
           y2 = pts2(j, 2);
           lin = F * [x1; y1; 1]; 
           d = [x2 y2 1] * lin / sqrt(sum(lin.*lin));
           if abs(d) < t
             count = count + 1;
             inlier=[inlier;j];
           end
        end
    end
end
inlier_final=inlier;
F=eightpoint(pts1(inlier_final,:),pts2(inlier_final,:),M);
save('q5_1.mat', 'F', 'pts1_1', 'pts2_2');
end