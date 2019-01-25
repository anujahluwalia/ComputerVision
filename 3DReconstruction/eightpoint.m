function [ F ] = eightpoint( pts1, pts2, M )
% eightpoint:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.1:
%     Implement the eightpoint algorithm
%     Generate a matrix F from some '../data/some_corresp.mat'
%     Save F, M, pts1, pts2 to q2_1.mat

%     Write F and display the output of displayEpipolarF in your writeup
n_pts1 = pts1 ./ M;
n_pts2 = pts2 ./ M;
x1 = n_pts1(:, 1);
y1 = n_pts1(:, 2);
x2 = n_pts2(:, 1);
y2 = n_pts2(:, 2);
U = [x1.*x2, x1.*y2, x1, y1.*x2, y1.*y2, y1, x2, y2, ones(size(pts1,1),1)];
[~, ~, V] = svd(U);
F_norm = reshape(V(:,9), 3, 3)';
[U_Fnorm, S_Fnorm, V_Fnorm] = svd(F_norm);
S_Fnorm(3,3) = 0;
F_norm = U_Fnorm*S_Fnorm*V_Fnorm';
T = [1/M 0 0; 0 1/M 0; 0 0 1];
F = T' * F_norm * T;
save('./q2_1.mat','F','M','pts1','pts2');
end

