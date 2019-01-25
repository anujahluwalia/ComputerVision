function [H2to1] = computeH_norm(p1, p2)
% inputs:
% p1 and p2 should be 2 x N matrices of corresponding (x, y)' coordinates between two images
%
% outputs:
% H2to1 - a 3 x 3 matrix encoding the homography that best matches the linear equation

%%%
N1 = size(p1,2);
origin1 = [(sum(p1(1,:))./N1);(sum(p1(2,:)./N1))];

Trans1 = p1-origin1*ones(1,N1);
dist = Trans1.^2;
d = zeros(1,N1);
for i = 1:N1
    d(i) = sqrt(dist(1,i)+dist(2,i));
end

dmean = sum(d)./N1;
scale1 = sqrt(2)./dmean;
T1 = [scale1 0 -scale1*origin1(1);0 scale1 -scale1*origin1(2);0 0 1];
p1 = ([p1; ones(1, N1)]);
NormP1 = T1 * p1;

N2 = size(p2,2);
origin2 = [(sum(p2(1,:))./N2);(sum(p2(2,:)./N2))];
Trans2 = p2-origin2*ones(1,N2);
dist = Trans2.^2;
dis = zeros(1,N2);
for i = 1:N2
    dis(i) = sqrt(dist(1,i)+dist(2,i));
end

dismean = sum(dis)./N2;
scale2 = sqrt(2)./dismean;
T2 = [scale2 0 -scale2*origin2(1);0 scale2 -scale2*origin2(2);0 0 1];
p2 = ([p2; ones(1, N2)]);
NormP2 = T2 * p2;
NormH2to1=computeH(NormP1([1 2],:),NormP2([1 2],:))
%H2to1=inv(T1) * NormH2to1 * T2';
H2to1=NormH2to1;


end