%This fragment of code generates the GPU Code
%Copy trainedNnet to current directory before running!!

% cfg = coder.gpuConfig('mex');
% cfg.TargetLang = 'C++';
% cfg.DeepLearningConfig = coder.DeepLearningConfig('cudnn');
% codegen -config cfg GPUCoderTestPrecompileFunction -args {ones(227,227,3, 'uint8')} -report



%SINGLE IMAGE TEST AND DISPLAY
% testData = leftValidation.read;
% testImg = testData{1,1};
% testLabel = testData{1,2};

% predictedLabel = GPUCoderTestPrecompileFunction_mex(testImg);
% 
% 
% figure
% imshow(igmNew{1,1})
% title(strcat('Prediction  ', string(predictedLabel), ' Truth   ', string(testLabel)))





%Easier to load all data at once for future executions
%If out of memory, can alter this to use a datastore

%data = leftValidation.readall;

predictedLabels = zeros(size (data, 1), 1);

tic

 for i = 1 : size (data, 1)
     predictedLabels(i,1) = GPUCoderTestPrecompileFunction_mex(data{i,1});
 end

toc
 
errorSquared = 0;

 for i = 1 : size (data, 1)
     errorSquared = errorSquared + (predictedLabels(i,1) - data{i,2})^2;
 end

RMSE = sqrt(errorSquared/size (data, 1))