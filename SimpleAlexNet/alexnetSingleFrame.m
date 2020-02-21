net = alexnet;
core = net.Layers;

%analyzeNetwork
%deepNetworkDesigner

%With batch normalisation
core((21:25),:) = [];
core(18,1) = batchNormalizationLayer;
core(19,1) = fullyConnectedLayer(1);
core(20,1) = regressionLayer;

%Without batch normalisation
%  core((20:25),:) = [];
%  core(18,1) = fullyConnectedLayer(1);
%  core(19,1) = regressionLayer;

miniBatchSize  = 128;
validationFrequency = floor(numel(topLvlImdsTrain.Labels)/miniBatchSize);

    %NOTE - LEARNNING RATE IS LOW AT 0.0001 instead of 0.001 !!
    %Replace later maybe??
    
options = trainingOptions('sgdm', ...
    'MiniBatchSize',miniBatchSize, ...
    'MaxEpochs',30, ...
    'InitialLearnRate',2.5e-3, ...
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.1, ...
    'LearnRateDropPeriod',10, ...
    'Shuffle','every-epoch', ...
    'ValidationData',leftValidation, ...
    'ValidationFrequency',validationFrequency, ...
    'Plots','training-progress', ...
    'Verbose',false, ...
    'ExecutionEnvironment','gpu');

trainedNnet = trainNetwork(leftTraining,core,options);

%h= findall(groot,'Type','Figure');
%h.MenuBar = 'figure';