function result = poisson_blend(source, mask, target)
mask_im = mask == 0;
mask_final = not(mask_im);
mask = mask_final;
source = padarray(source, [1,1], 'symmetric');
target = padarray(target, [1,1], 'symmetric');
mask = padarray(mask, [1,1]);
c = size(source,1);
r = size(source,2);
tot = length(find(mask));
[MY,MX] = find(mask);
ind = zeros(c,r);
m = 1;
for i = 1:tot
   ind(MY(i),MX(i)) = m;
   m = m + 1;
end
A = sparse(tot,tot);
b = zeros(tot,3);
num = 0;
for x = 1:r
    for y = 1:c        
        if mask(y,x) == 1
            num = num + 1;
            A(num,num) = 4;
            b(num,1) = b(num,1) + 4*double(source(y,x,1)) - double(source(y,x+1,1)) - double(source(y,x-1,1)) - double(source(y+1,x,1)) - double(source(y-1,x,1));
            b(num,2) = b(num,2) + 4*double(source(y,x,2)) - double(source(y,x+1,2)) - double(source(y,x-1,2)) - double(source(y+1,x,2)) - double(source(y-1,x,2));
            b(num,3) = b(num,3) + 4*double(source(y,x,3)) - double(source(y,x+1,3)) - double(source(y,x-1,3)) - double(source(y+1,x,3)) - double(source(y-1,x,3));
        if mask(y-1,x) == 1
            A(num,ind(y-1,x)) = -1;
               %     disp("We are here")
                %    disp(index)
                 %   disp(num)
        else
            b(num,1) = b(num,1) + double(target(y-1,x,1));
            b(num,2) = b(num,2) + double(target(y-1,x,2));
            b(num,3) = b(num,3) + double(target(y-1,x,3));
        end            
        if mask(y+1,x) == 1
            A(num,ind(y+1,x)) = -1;
        else
            b(num,1) = b(num,1) + double(target(y+1,x,1));
            b(num,2) = b(num,2) + double(target(y+1,x,2));
            b(num,3) = b(num,3) + double(target(y+1,x,3));
        end            
        if mask(y,x-1) == 1
            A(num,ind(y,x-1)) = -1;
                 %   disp("We are here")
                 %   disp(index)
                 %   disp(num)
        else
            b(num,1) = b(num,1) + double(target(y,x-1,1));
            b(num,2) = b(num,2) + double(target(y,x-1,2));
            b(num,3) = b(num,3) + double(target(y,x-1,3));
        end            
        if mask(y,x+1) == 1
            A(num,ind(y,x+1)) = -1;
        else
            b(num,1) = b(num,1) + double(target(y,x+1,1));
            b(num,2) = b(num,2) + double(target(y,x+1,2));
            b(num,3) = b(num,3) + double(target(y,x+1,3));
         end
        end
    end
end

result = double(target);
channel(:,1) = A \ b(:,1);
channel(:,2) = A \ b(:,2);
channel(:,3) = A \ b(:,3);

for m = 1:3
    for k = 1:tot
        result(MY(k),MX(k),m) = channel(k,m);
    end
end
result = uint8(result);
result = result(:,1:size(target,2),:);
end