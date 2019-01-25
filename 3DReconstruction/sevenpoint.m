function [F] = 	sevenpoint( pts1, pts2, M )
% sevenpoint:
%   pts1 - 7x2 matrix of (x,y) coordinates
%   pts2 - 7x2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.2:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save recovered F (either 1 or 3 in cell), M, pts1, pts2 to q2_2.mat

%     Write recovered F and display the output of displayEpipolarF in your writeup
F = cell(1,3);
n_pts1 = pts1 ./ M;
n_pts2 = pts2 ./ M;
x1 = n_pts1(:, 1);
y1 = n_pts1(:, 2);
x2 = n_pts2(:, 1);
y2 = n_pts2(:, 2);
U = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(size(pts1,1),1)];
[~, ~, V] = svd(U);
F1 = reshape(V(:,9), 3, 3);
F2 = reshape(V(:,8), 3, 3);
syms a;
S = double(solve(det(a*F1 + (1-a)*F2)));
T = [1/M 0 0; 0 1/M 0; 0 0 1];
for i = 1: 3
    F{i} = S(i)*F1 + (1-S(i))*F2;
    F{i} = T'*F{i}*T;
end
save('./q2_2.mat','F','M','pts1','pts2');
end

