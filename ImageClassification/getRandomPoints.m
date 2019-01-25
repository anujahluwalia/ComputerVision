function [points] = getRandomPoints(I, alpha)
% Generates random points in the image
% Input:
%   I:                      grayscale image
%   alpha:                  random points
% Output:
%   points:                    point locations
%
	% -----fill in your implementation here --------
    h = size(I,1);
    w = size(I,2);
    for i=1:alpha
      points(i,1) = randi([1 h]);
      points(i,2) = randi([1 w]);
    end;
    % ------------------------------------------
end

