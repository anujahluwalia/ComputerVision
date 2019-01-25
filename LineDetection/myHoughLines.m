function [rhos, thetas] = myHoughLines(H, nLines)
%Your implemention here
[hr,hc]=size(H);
rhos=zeros(nLines,1);
thetas=zeros(nLines,1);
Hout=zeros(hr,hc);
for r = 2:hr-1
    for c=2:hc-1
        if H(r,c) < H(r+1,c) || H(r,c) < H(r+1,c+1) || H(r,c) < H(r,c+1) || H(r,c) < H(r-1,c) || H(r,c) < H(r-1,c-1) || H(r,c) < H(r,c-1) || H(r,c) < H(r-1,c+1) || H(r,c) < H(r+1,c-1)
            Hout(r,c)=0;
        else
            Hout(r,c)=H(r,c);
        end
    end
end
[sort_values,sort_index]=sort(Hout(:),'descend');
max_index=sort_index(1:nLines);
[rhos,thetas]=ind2sub([hr,hc],max_index);
end
        