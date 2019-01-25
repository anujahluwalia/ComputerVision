function [wordMap] = getVisualWords(I, dictionary, filterBank)
% Convert an RGB or grayscale image to a visual words representation, with each
% pixel converted to a single integer label.   
% Inputs:
%   I:              RGB or grayscale image of size H * W * C
%   filterBank:     cell array of matrix filters used to make the visual words.
%                   generated from getFilterBankAndDictionary.m
%   dictionary:     matrix of size 3*length(filterBank) * K representing the
%                   visual words computed by getFilterBankAndDictionary.m
% Outputs:
%   wordMap:        a matrix of size H * W with integer entries between
%                   1 and K

    % -----fill in your implementation here --------
    img1=double(I);
    filterResponses=extractFilterResponses(img1,filterBank);
    h=size(filterResponses,1);
    w=size(filterResponses,2);
    c=size(filterResponses,3);
    filterResponses2=reshape(filterResponses,[(h*w),c]);
    wordMap2=pdist2(filterResponses2,dictionary);
    [wordMapMin,minIndex]=min(wordMap2');
    wordMap=reshape(minIndex,[h,w]);
    rgbMap=label2rgb(uint8(wordMap));
    % ------------------------------------------
end
