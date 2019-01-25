function [locs, desc] = computeBrief(im, locs, compareX, compareY)
% Compute the BRIEF descriptor for detected keypoints.
% im is 1 channel image, 
% locs are locations
% compareX and compareY are idx in patchWidth^2
% Return:
% locs: m x 2 vector which contains the coordinates of the keypoints
% desc: m x nbits vector which contains the BRIEF descriptor for each
%   keypoint.

row = size(im,1);
col = size(im,2);
patchWidth = 9;
%take care of edges
patchby2 = floor(patchWidth./2);
locs = locs(locs(:,1)>patchby2,:);
locs = locs(locs(:,1)<=(col-patchby2),:);
locs = locs(locs(:,2)>patchby2,:);
locs = locs(locs(:,2)<=(row-patchby2),:);

%compute desc
desc = zeros(size(locs,1),length(compareX));
for m = 1:size(locs,1)
    x = int16(locs(m,1));
    y = int16(locs(m,2));
    if (x > 4) & (y>4)
      patch = im(y-4:y+4,x-4:x+4);
      for n = 1:length(compareX)
        compx = compareX(n);
        compy = compareY(n);
        if patch(compx) < patch(compy)
            desc(m,n) = 1;
        else
            desc(m,n) = 0;
        end
      end
    end
end

end