function [idf] = computeIDF()
% Convert an wordMap to its feature vector. In this case, it is a histogram
% of the visual words
% Input:
%   wordMap:            an H * W matrix with integer values between 1 and K
%   dictionarySize:     the total number of words in the dictionary, K
% Outputs:
%   h:                  the feature vector for this image
load('../data/traintest.mat','train_imagenames','mapping');
l = length(train_imagenames);
load('dictionaryRandom.mat');
dictionary=dictionary;
target = '../data_random/';
dictionarySize=size(dictionary,1);
load('visionRandom.mat','trainFeatures');

for i=1:dictionarySize
    h(i)=0;
    h(i)=sum(trainFeatures(:,i) > 0);
    idf(i)=log(l/h(i));
end
save('IDFRandom.mat','idf');

load('dictionaryHarris.mat');
dictionary=dictionary;
target = '../data/';
dictionarySize=size(dictionary,1);
load('visionHarris.mat','trainFeatures');

for i=1:dictionarySize
    h(i)=0;
    h(i)=sum(trainFeatures(:,i) > 0);
    idf(i)=log(l/h(i));
end
size(idf)
save('IDFHarris.mat','idf');
end
