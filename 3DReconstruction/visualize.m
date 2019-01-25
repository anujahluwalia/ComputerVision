% Q4.2:
% Integrating everything together.
% Loads necessary files from ../data/ and visualizes 3D reconstruction
% using scatter3
im1=imread('../data/im1.png');
im2=imread('../data/im2.png');
load('../data/some_corresp.mat');
M=max(size(im1,1),size(im1,2));
F = eightpoint( pts1, pts2, M );
load('../data/templeCoords.mat');
for i=1:size(x1,1)
    [x2(i,1),y2(i,1)]= epipolarCorrespondence( im1, im2, F, x1(i,1), y1(i,1));
end
p1=[x1,y1];
p2=[x2,y2];
load('../data/intrinsics.mat');
E=essentialMatrix(F,K1,K2);
M2s=camera2(E);
M1=[eye(3),zeros(3,1)];
C1=K1*M1;
for i=1:size(M2s,3)
    [P,~]=triangulate(C1,p1,K2*M2s(:,:,i),p2);
    if all(P(:,3)>=0)
        P_corr=P;
        M2=M2s(:,:,i);
        C2=K2*M2;
    end
end
scatter3(P_corr(:,1),P_corr(:,2),P_corr(:,3));
save('./q4_2.mat','F','M1','M2','C1','C2');

