function [H2to1] = computeH(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%
N = size(p1, 2);

p1 = ([p1; ones(1, N)])';
p2 = ([p2; ones(1, N)])';

A = zeros(2 * N, 9);
for i = 1:N
   A(2 * i - 1, :) = [-p2(i,1), -p2(i,2), -1, 0, 0, 0, p1(i,1) * p2(i,1),p1(i,1) * p2(i,2), p1(i,1)];
   A(2 * i, :) = [0, 0, 0, -p2(i,1), -p2(i,2), -1, p1(i,2) * p2(i,1),p1(i,2) * p2(i,2), p1(i,2)];
end

[V, ~] = eig(A' * A);
H2to1 = reshape(V(:,1), 3, 3);
H2to1 = H2to1';
end