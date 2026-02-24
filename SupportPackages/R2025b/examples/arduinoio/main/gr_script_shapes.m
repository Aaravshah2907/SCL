%gr_script_shapes
clear
clc
load shapes_training_data.mat

%% Preprocessing
% 119 samples in each frame, 100 frames each
Nframe = 100;

for ind = 1:Nframe
    featureC1(ind,:) = mean(circledata{ind});
    featureC2(ind,:) = std(circledata{ind});

    featureT1(ind,:) = mean(triangledata{ind});
    featureT2(ind,:) = std(triangledata{ind});
end

X = [featureC1,featureC2;
    featureT1,featureT2;
    zeros(size(featureT1)),zeros(size(featureT2))]; % Idle state is all zeros

%labels - 1: circle, 2: triangle, 3: idle
Y = [ones(Nframe,1);2*ones(Nframe,1);3*ones(Nframe,1)];
    
%% Training
% prepare data
rng('default') % For reproducibility
Partition = cvpartition(Y,'Holdout',0.20);
trainingInds = training(Partition); % Indices for the training set
XTrain = X(trainingInds,:);
YTrain = Y(trainingInds);
testInds = test(Partition); % Indices for the test set
XTest = X(testInds,:);
YTest = Y(testInds);

template = templateTree(...
    'MaxNumSplits', 399);
ensMdl = fitcensemble(...
    XTrain, ...
    YTrain, ...
    'Method', 'Bag', ...
    'NumLearningCycles', 20, ...
    'Learners', template, ...
    'ClassNames', [1; 2; 3]);
%% Prediction accuracy

% Perform 5-fold cross-validation for classificationEnsemble and compute the validation accuracy.
partitionedModel = crossval(ensMdl,'KFold',5);

validationAccuracy = 1-kfoldLoss(partitionedModel)

%% Test data accuracy

% Evaluate performance of test data
testAccuracy = 1-loss(ensMdl,XTest,YTest)