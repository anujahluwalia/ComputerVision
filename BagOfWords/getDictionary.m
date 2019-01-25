function [dictionary] = getDictionary(imgPaths, alpha, K, method)
% Generate the filter bank and the dictionary of visual words
% Inputs:
%   imgPaths:        array of strings that repesent paths to the images
%   alpha:          num of points
%   K:              K means parameters
%   method:         string 'random' or 'harris'
% Outputs:
%   dictionary:         a length(imgPaths) * K matrix where each column
%                       represents a single visual word
    % -----fill in your implementation here --------
l = length(imgPaths);
filterBank = createFilterBank();
pixelResponses=zeros(alpha*l,3*size(filterBank,1));
for i = 1:l
    img = imread(strcat('../data/',imgPaths{i}));
    img1 = double(img)/255;
    filterResponses=extractFilterResponses(img1,filterBank);
    if method == 'random'
        points=getRandomPoints(img1,alpha);
    else
        points=getHarrisPoints(img1,alpha,0.04);
    end 
    for j=1:alpha
        pixelResponses((j + alpha*(i-1)),:)=filterResponses(points(j,1),points(j,2),:); 
    end  
end
tic;
[~, dictionary] = kmeans(pixelResponses, K, 'EmptyAction', 'drop', 'MaxIter',400);
toc
    % ------------------------------------------
    
end
