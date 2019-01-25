% buildRecognitionSystem.m
% This script loads the visual word dictionary (in dictionaryRandom.mat or dictionaryHarris.mat) and processes
% the training images so as to build the recognition system. The result is
% stored in visionRandom.mat and visionHarris.mat.
function buildRecognitionSystem()
load('../data/traintest.mat','train_imagenames','mapping');
load('../data/traintest.mat','train_labels','mapping');
l = length(train_imagenames);
load('dictionaryHarris.mat');
dictionary=dictionary;
target = '../data/';
dictionarySize=size(dictionary,1);
trainFeatures=[];
for i=1:l
        wordMapStruct=load([target, strrep(train_imagenames{i},'.jpg','.mat')],'wordMap');
        trainFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
end
filterBank = createFilterBank();
save('visionHarris.mat','dictionary','filterBank','trainFeatures','train_labels');

load('dictionaryRandom.mat');
dictionary=dictionary;
dictionarySize=size(dictionary,1);
trainFeatures=[];
target = '../data_random/';
for i=1:l
        wordMapStruct=load([target, strrep(train_imagenames{i},'.jpg','.mat')],'wordMap');
        trainFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
end
save('visionRandom.mat','dictionary','filterBank','trainFeatures','train_labels');

end
