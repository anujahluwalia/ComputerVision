function [h] = getImageFeatures(wordMap, dictionarySize)
% Convert an wordMap to its feature vector. In this case, it is a histogram
% of the visual words
% Input:
%   wordMap:            an H * W matrix with integer values between 1 and K
%   dictionarySize:     the total number of words in the dictionary, K
% Outputs:
%   h:                  the feature vector for this image


	% -----fill in your implementation here --------
    r=size(wordMap,1);
    c=size(wordMap,2);
    for i=1:dictionarySize
        h(i)=0;
        for j=1:r
            for k=1:c
                if (wordMap(j,k) == i)
                    h(i)=h(i)+1;
                end
            end
        end
    end
    h = h/sum(h);                    

    % ------------------------------------------

end
