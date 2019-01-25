function R = rodrigues(r)
% rodrigues:

% Input:
%   r - 3x1 vector
% Output:
%   R - 3x3 rotation matrix

R = [];
if norm(r) == 0
    R = eye(3);
else
    skew = [0,-r(3),r(2);r(3),0,-r(1);-r(2),r(1),0];
    R = eye(3) + (skew/norm(r)) * sin(norm(r)) + (skew^2/norm(r)^2) * (1-cos(norm(r)));
end
R=R';
end
