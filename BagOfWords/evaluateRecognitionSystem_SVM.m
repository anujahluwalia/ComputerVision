% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix
function evaluateRecognitionSystem_SVM()
load('../data/traintest.mat','test_imagenames','mapping');
load('../data/traintest.mat','test_labels','mapping');
l = length(test_imagenames);

%Harris
load('dictionaryHarris.mat');
dictionary=dictionary;
target = '../data/';
dictionarySize=size(dictionary,1);
load('visionHarris.mat','trainFeatures');
load('visionHarris.mat','train_labels');
t=templateSVM('KernelFunction','rbf');
classifier = fitcecoc(trainFeatures,train_labels,'Learners',t);
save('visionSVMHarris.mat','classifier');
correct=0;
incorrect=0;
CHarris=zeros(8,8);
for i=1:l
        wordMapStruct=load([target, strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
        testFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
        outputLabel=predict(classifier,testFeatures);
        CHarris(test_labels(i),outputLabel(i))=CHarris(test_labels(i),outputLabel(i))+1;
        if (outputLabel(i)==test_labels(i))
            correct=correct+1;
        else
            incorrect=incorrect+1;
        end
end
total=correct+incorrect;
accuracyHarris=correct/total
disp(CHarris);

%Random
load('dictionaryRandom.mat');
dictionary=dictionary;
target = '../data_random/';
dictionarySize=size(dictionary,1);
load('visionRandom.mat','trainFeatures');
load('visionRandom.mat','train_labels');
t=templateSVM('KernelFunction','rbf');
classifier = fitcecoc(trainFeatures,train_labels,'Learners',t);
save('visionSVMRandom.mat','classifier');
correct=0;
incorrect=0;
CRandom=zeros(8,8);
for i=1:l
        wordMapStruct=load([target, strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
        testFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
        outputLabel=predict(classifier,testFeatures);
        CRandom(test_labels(i),outputLabel(i))=CRandom(test_labels(i),outputLabel(i))+1;
        if (outputLabel(i)==test_labels(i))
            correct=correct+1;
        else
            incorrect=incorrect+1;
        end
end
total=correct+incorrect;
accuracyRandom=correct/total
disp(CRandom);

end