function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases 
% output - movement vector, [u,v] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);
x1=double(int16(rect(1)));
y1=double(int16(rect(2)));
x2=double(int16(rect(3)));
y2=double(int16(rect(4)));
[x_template,y_template] = meshgrid(min(x1,x2):max(x1,x2),min(y1,y2):max(y1,y2));
T = interp2(It,x_template,y_template);
[Tx,Ty] = gradient(T);
steep = [Tx(:),Ty(:)];
num_basis = size(bases,3);
for i=1:num_basis
    base_curr = bases(:,:,i);
    t = base_curr(:)' * steep;
    t1 = t' * base_curr(:)';
    steep = steep - t1'; 
end
H = steep' * steep;
threshold = 0.01;
p = [0;0];
delta = [5;5];
while norm(delta) > threshold
    [x_image,y_image] = meshgrid(min(x1,x2)+p(1):max(x1,x2)+p(1),min(y1,y2)+p(2):max(y1,y2)+p(2));
    I = interp2(It1,x_image,y_image);
    error = I - T;
    delta = inv(H) * (steep' * error(:));
    p = p - delta;
end
u = p(1);
v = p(2);
end
