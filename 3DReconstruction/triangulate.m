function [ P, err ] = triangulate( C1, p1, C2, p2 )
% triangulate:
%       C1 - 3x4 Camera Matrix 1
%       p1 - Nx2 set of points
%       C2 - 3x4 Camera Matrix 2
%       p2 - Nx2 set of points

%       P - Nx3 matrix of 3D coordinates
%       err - scalar of the reprojection error

% Q4.2:
%       Implement a triangulation algorithm to compute the 3d locations
%
P = zeros(size(p1,1), 3);
p1 = [p1 ones(size(p1,1),1)];
p2 = [p2 ones(size(p2,1),1)];

for i = 1:size(p1,1)
   A = [p1(i,2)*C1(3,:)-C1(2,:);C1(1,:)-p1(i,1)*C1(3,:);p2(i,2)*C2(3,:)-C2(2,:);C2(1,:)-p2(i,1)*C2(3,:)];
   [~, ~, V] = svd(A);
    v = V(:, 4); 
    P(i, :) = v(1:3)' ./ v(4);  
end 

P_hom = [P'; ones(1, size(p1,1))];
p1_projected = C1 * P_hom;
p2_projected = C2 * P_hom;
p1_projected = p1_projected';
p2_projected = p2_projected';
p1_projected = p1_projected./p1_projected(:,3);
p2_projected = p2_projected./p2_projected(:,3);

error1 = sum(sum((p1 - p1_projected) .^ 2));
error2 = sum(sum((p2 - p2_projected) .^ 2));
err = error1 + error2;
end
