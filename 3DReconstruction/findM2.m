% Q3.3:
%       1. Load point correspondences
%       2. Obtain the correct M2
%       3. Save the correct M2, C2, p1, p2, R and P to q3_3.mat
img1 = imread('../data/im1.png');
M = max(size(img1, 1),size(img1, 2));
load('../data/some_corresp.mat');
load('../data/intrinsics.mat');
F = eightpoint(pts1,pts2,M);
E = essentialMatrix(F,K1,K2);
P = zeros(size(pts1,1),3); 
M2s = camera2(E);
M2 = M2s(:,:,1);   
M1 = [eye(3), zeros(3, 1)];
C1 = K1 * M1;
for i = 1: 4
    C2 = K2 * M2s(:,:,i);
    [p, ~] = triangulate(C1, pts1, C2, pts2);
    if all(p(:, 3) > 0)
        M2 = M2s(:,:,i);
        P = p;
        break;
    end   
end
save('q3_3.mat', 'M2', 'C2', 'pts1', 'pts2', 'P');
