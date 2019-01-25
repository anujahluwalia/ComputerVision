function [H, rhoScale, thetaScale] = myHoughTransform(Im, threshold, rhoRes, thetaRes)
% % %Your implementation here
% %Im - grayscale image - 
% %threshold - prevents low gradient magnitude points from being included
% %rhoRes - resolution of rhos - scalar
% %thetaRes - resolution of theta - scalar
 [h,w]=size(Im);
 for v = 1 : w
     for u = 1 : h
         if(Im(u,v) >= threshold)
             Iout(u,v) = Im(u,v);
         end
     end   
 end

im=Im;
size(im);
theta = ((-90:thetaRes:90)./180) .* pi;
D = sqrt(size(im,1).^2 + size(im,2).^2);
rhoTest=-D:rhoRes:D;

H = zeros(numel(rhoTest),numel(theta));

[y,x] = find(im);
y = y - 1;
x = x - 1;

for i = 1: numel(x)
    rho{i} = (x(i).*cos(theta) + y(i).*sin(theta))/rhoRes; 
end
for i = 1:numel(x)
    rho{i} = rho{i} + D/rhoRes; 
    rho{i} = floor(rho{i}) + 1;
    for j = 1:numel(rho{i})
        H(rho{i}(j),j) = H(rho{i}(j),j) + 1;
    end
end
rhoScale=rhoTest;
thetaScale=theta;
end
        
