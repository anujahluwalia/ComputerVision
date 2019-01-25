function [ x2, y2 ] = epipolarCorrespondence( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q4.1:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line
%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q4_1.mat
%
%           Explain your methods and optimization in your writeup
line1 = F*[x1; y1; 1];
line1 = line1/sqrt(line1(1)^2 + line1(2)^2);
line2=[-line1(2) line1(1) line1(2)*x1-line1(1)*y1]';
projected=round(cross(line1,line2));
windowsize=10;
p1 = double(im1((y1-windowsize):(y1+windowsize), (x1-windowsize):(x1+windowsize)));
gaussian_size = 2*windowsize+1;
weight = fspecial('gaussian', [gaussian_size gaussian_size], 3);
err_min=1200;
for i=projected(1)-(2*windowsize):1:projected(1)+(2*windowsize)
    for j=projected(2)-(2*windowsize):1:projected(2)+(2*windowsize) 
           p2=double(im2(j-windowsize:j+windowsize,i-windowsize:i+windowsize));
           error = norm(weight.*(p1-p2)); 
           if error<err_min
                x2=i;
                y2=j;
                err_min=error;
           end   
    end
end
end

