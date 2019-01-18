function [Im Io Ix Iy] = myEdgeFilter(img, sigma)
%Your implemention
[h, w] = size(img);
hsize=2*ceil(3*sigma)+1;
filter = fspecial('gaussian',hsize,sigma);
I_mid=myImageFilter(img,filter);
Sx = [1 0 -1;2 0 -2;1 0 -1];
Sy = [1 2 1; 0 0 0;-1 -2 -1];
Iy=myImageFilter(I_mid,Sx);
Ix=myImageFilter(I_mid,Sy);
[c,d] = size(Ix);
for a = 1:c
    for b = 1:d
        Im(a,b) = sqrt(abs(Ix(a,b)).^2 + abs(Iy(a,b)).^2);
    end
end

for a = 2 : h-2
    for b = 2 : w-2
      Io(a,b) = rad2deg(atan2(Iy(a,b),Ix(a,b)));
        if (Io(a,b)<0)
            Io(a,b)=Io(a,b)+180;
        end
        if ((Io(a,b) >= 0) && (Io(a,b) <= 22.5)  || (Io(a,b) > 157.5))
            round_Io(a,b) = 0;
        end;
        
        if ((Io(a,b) >= 22.5) && (Io(a,b) <= 67.5))
            round_Io(a,b) = 45;
        end;
        
        if ((Io(a,b) >= 67.5) && (Io(a,b) <= 112.5))
            round_Io(a,b) = 90;
        end;
        
        if ((Io(a,b) >= 112.5) && (Io(a,b) <= 157.5))
            round_Io(a,b) = 135;
        end;
            if (round_Io(a,b) == 0)
               % if (Im(a, b) < Im(a-1, b) || Im(a, b) < Im(a+1, b))
               if (Im(a, b) < Im(a-1, b) || Im(a, b) < Im(a+1, b))
            %    if (Im(a, b) < Im(a, b+1) || Im(a, b) < Im(a, b-1))
                    outimg(a,b) = 0;
                else outimg(a,b)= Im(a,b);
                end; 
            end;
                
            
            if (round_Io(a,b) == 45)
                if (Im(a, b) < Im(a-1, b-1) || Im(a,b) < Im(a+1, b+1))
             %   if (Im(a, b) < Im(a+1, b-1) || Im(a, b) < Im(a-1, b+1))
                    outimg(a,b) = 0;
                else outimg(a,b)= Im(a,b);
                end;
            end;
                
            
            if (round_Io(a,b) == 90)
                if (Im(a, b) < Im(a, b+1) || Im(a, b) < Im(a, b-1))
            %    if (Im(a,b) < Im(a, b-1) || Im(a, b) < Im(a, b+1))
           % if (Im(a, b) < Im(a-1, b) || Im(a, b) < Im(a+1, b))
                    outimg(a,b) = 0;
                else outimg(a,b)= Im(a,b);
                end;
            end;
               
            if (round_Io(a,b) == 135)
            %    if (Im(a, b) < Im(a-1, b-1) || Im(a,b) < Im(a+1, b+1))
                if (Im(a, b) < Im(a+1, b-1) || Im(a, b) < Im(a-1, b+1))
                    outimg(a,b) = 0;
                else outimg(a,b) = Im(a,b);
                end ;
            end;
                
    end
end   
Im=outimg;
end
         