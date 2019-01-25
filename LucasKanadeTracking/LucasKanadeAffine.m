function M = LucasKanadeAffine(It, It1)
% input - image at time t, image at t+1
% output - M affine transformation matrix
It = im2double(It);
It1 = im2double(It1);
p = zeros(6,1);
[x_template,y_template] = meshgrid(1:size(It,2),1:size(It,1));
T = interp2(It,x_template,y_template);
[Tx,Ty] = gradient(T);
steep = [Tx(:).*x_template(:),Ty(:).*x_template(:),Tx(:).*y_template(:),Ty(:).*y_template(:),Tx(:),Ty(:)];
T1 = [x_template(:)';y_template(:)';ones(1,length(T(:)))];
threshold = 0.2;
delta = ones(6,1);
while norm(delta) > threshold    
    M = [1+p(1),p(3),p(5);p(2),1+p(4),p(6);0,0,1];    
    img_warp = M * T1;    
    i = ((img_warp(1,:) >=1) & (img_warp(1,:) <= size(T,2))) & ((img_warp(2,:) >= 1) &  (img_warp(2,:) <= size(T,1)));
    x_image = img_warp(1,:);
    y_image = img_warp(2,:);    
    steep_new = steep(i,:);
    H = steep_new' * steep_new;    
    I = interp2(It1,x_image(:),y_image(:));    
    error = I - T(:);
    error = error(i);
    delta = inv(H) * (steep_new' * error(:));
    p = p - delta;     
end
M = [1+p(1),p(3),p(5);p(2),1+p(4),p(6);0,0,1];  
end