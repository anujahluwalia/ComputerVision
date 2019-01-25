function [u,v] = LucasKanadeInverseCompositionalWithCorrection(It, It1, rect,pinitial)
% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u, v] in the x- and y-directions.
It = im2double(It);
It1 = im2double(It1);
x1=double(int16(rect(1)));
y1=double(int16(rect(2)));
x2=double(int16(rect(3)));
y2=double(int16(rect(4)));
%x_input=linspace(min(x1,x2),max(x1,x2),size(It,1));
%y_input=linspace(min(y1,y2),max(y1,y2),size(It,2));
[x_template,y_template] = meshgrid(min(x1,x2):max(x1,x2),min(y1,y2):max(y1,y2));
%[x_template,y_template] = meshgrid(x_input,y_input);
T = interp2(It,x_template,y_template);
[Tx,Ty] = gradient(T);
steep = [Tx(:),Ty(:)];
H = steep' * steep;
threshold = 0.01;
p = pinitial;
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