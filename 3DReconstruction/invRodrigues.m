function r = invRodrigues(R)
% invRodrigues
% Input:
%   R: 3x3 rotation matrix
% Output:
%   r: 3x1 vector
A = (R - R')/2;
rho = [A(3,2), A(1,3), A(2,1) ]';
s = norm(rho);
c = (trace(R) - 1)/2;
if s == 0 && c == 1
    r = [0;0;0];
elseif s == 0 && c == -1
    t = R + eye(3);
    [~,index] = max(diag(t));
    v = t(:,index);
    u = v/norm(v);
    r = pi.*u;
    if (norm(r) == pi) && (((r(1)==0) && (r(2)==0) && (r(3)<0)) || (((r(1)==0) && (r(2)<0))||(r(1)<0)))
        r = -r;
    end
else
    theta = 0;
    if c > 0
        theta = atan(s/c);
    elseif c < 0
        theta = pi + atan(s/c);
    elseif c == 0 && s > 0
        theta = pi/2;
    elseif c == 0 && s < 0
        theta = -pi/2;
    end
    u = rho/s;
    r = theta*u;
end
r = r';
end
