% evaluateRecognitionSystem.m
% This script evaluates nearest neighbour recognition system on test images
% load traintest.mat and classify each of the test_imagenames files.
% Report both accuracy and confusion matrix
function evaluateRecognitionSystem_IDF()
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
load('IDFHarris.mat','idf');
correctEuclid=0;
incorrectEuclid=0;
correctChi2=0;
incorrectChi2=0;
CeuclideanHarris=zeros(8,8);
Cchi2Harris=zeros(8,8);
for i=1:l
        wordMapStruct=load([target, strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
        testFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
        distEuclid=getImageDistance(testFeatures(i,:).*idf,trainFeatures.*idf,'euclidean');
        [distMinEuclid,IminEuclid]=min(distEuclid);
        outputLabelEuclid=train_labels(IminEuclid);
        CeuclideanHarris(test_labels(i),train_labels(IminEuclid))=CeuclideanHarris(test_labels(i),train_labels(IminEuclid))+1;
        if (outputLabelEuclid==test_labels(i))
            correctEuclid=correctEuclid+1;
        else
            incorrectEuclid=incorrectEuclid+1;
        end
        distChi2=getImageDistance(testFeatures(i,:).*idf,trainFeatures.*idf,'chisq');
        [distMinChi2,IminChi2]=min(distChi2);
        outputLabelChi2=train_labels(IminChi2);
        Cchi2Harris(test_labels(i),train_labels(IminChi2))=Cchi2Harris(test_labels(i),train_labels(IminChi2))+1;
        if (outputLabelChi2==test_labels(i))
            correctChi2=correctChi2+1;
        else
            incorrectChi2=incorrectChi2+1;
        end
end
totalEuclid=correctEuclid+incorrectEuclid;
accuracyEuclideanHarris=correctEuclid/totalEuclid
disp(CeuclideanHarris);
totalChi2=correctChi2+incorrectChi2;
accuracyChi2Harris=correctChi2/totalChi2
disp(Cchi2Harris);

%Random
load('dictionaryRandom.mat');
dictionary=dictionary;
target = '../data_random/';
dictionarySize=size(dictionary,1);
load('visionRandom.mat','trainFeatures');
load('visionRandom.mat','train_labels');
load('IDFRandom.mat','idf');
correctEuclid=0;
incorrectEuclid=0;
correctChi2=0;
incorrectChi2=0;
CeuclideanRandom=zeros(8,8);
Cchi2Random=zeros(8,8);
for i=1:l
        wordMapStruct=load([target, strrep(test_imagenames{i},'.jpg','.mat')],'wordMap');
        testFeatures(i,:)=getImageFeatures(wordMapStruct.wordMap, dictionarySize);
        distEuclid=getImageDistance(testFeatures(i,:).*idf,trainFeatures.*idf,'euclidean');
        [distMinEuclid,IminEuclid]=min(distEuclid);
        outputLabelEuclid=train_labels(IminEuclid);
        CeuclideanRandom(test_labels(i),train_labels(IminEuclid))=CeuclideanRandom(test_labels(i),train_labels(IminEuclid))+1;
        if (outputLabelEuclid==test_labels(i))
            correctEuclid=correctEuclid+1;
        else
            incorrectEuclid=incorrectEuclid+1;
        end
        distChi2=getImageDistance(testFeatures(i,:).*idf,trainFeatures.*idf,'chisq');
        [distMinChi2,IminChi2]=min(distChi2);
        outputLabelChi2=train_labels(IminChi2);
        Cchi2Random(test_labels(i),train_labels(IminChi2))=Cchi2Random(test_labels(i),train_labels(IminChi2))+1;
        if (outputLabelChi2==test_labels(i))
            correctChi2=correctChi2+1;
        else
            incorrectChi2=incorrectChi2+1;
        end
end
totalEuclid=correctEuclid+incorrectEuclid;
accuracyEuclideanRandom=correctEuclid/totalEuclid
disp(CeuclideanRandom);
totalChi2=correctChi2+incorrectChi2;
accuracyChi2Random=correctChi2/totalChi2
disp(Cchi2Random);

end