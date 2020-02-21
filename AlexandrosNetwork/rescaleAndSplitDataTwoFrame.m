targetSize = [227,227];

leftTraining = transform(imdsTwoFrameTraining,@preprocessLeftTwoFrame,'IncludeInfo',true);
leftValidation = transform(imdsTwoFrameValidate,@preprocessLeftTwoFrame,'IncludeInfo',true);

% leftTraining = leftTraining.shuffle;
% leftValidation = leftValidation.shuffle;

% centerTraining = transform(topLvlImdsTrain,@(x) imresize(x(1:360, 141:500,:),targetSize));
% centerValidation = transform(topLvlImdsValidate,@(x) imresize(x(1:360, 141:500,:),targetSize));
% 
% centerTraining = centerTraining.shuffle;
% centerValidation = centerValidation.shuffle;
% 
% rightTraining = transform(topLvlImdsTrain,@(x) imresize(x(1:360, 281:640,:),targetSize));
% rightValidation = transform(topLvlImdsValidate,@(x) imresize(x(1:360, 281:640,:),targetSize));
% 
% rightTraining = rightTraining.shuffle;
% rightValidation = rightValidation.shuffle;



%Access info from any datastore with this command
%[data,info] = read(leftTraining);

%Access underlying datastore from combined (eg. imdsTwoFrameTraining)
%imdsCombo.UnderlyingDatastores{1,1}

% imgs = read(imdsTwoFrameTraining);
% imgPresent = imgs{1,1};
% imgPast = imgs{1,2};
%  
% whos imgPresent imgPast;
%  
% subplot(121); imshow(imgPresent); axis on; title('Present Frame');
% subplot(122); imshow(imgPast); axis on; title('Past Frame');
