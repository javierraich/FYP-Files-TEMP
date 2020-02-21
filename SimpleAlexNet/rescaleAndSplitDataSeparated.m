targetSize = [227,227];

leftTraining = transform(topLvlImdsTrain,@preprocessForTrainingLeft,'IncludeInfo',true);
leftValidation = transform(topLvlImdsValidate,@preprocessForTrainingLeft,'IncludeInfo',true);

leftTraining = leftTraining.shuffle;
leftValidation = leftValidation.shuffle;

centerTraining = transform(topLvlImdsTrain,@(x) imresize(x(1:360, 141:500,:),targetSize));
centerValidation = transform(topLvlImdsValidate,@(x) imresize(x(1:360, 141:500,:),targetSize));

centerTraining = centerTraining.shuffle;
centerValidation = centerValidation.shuffle;

rightTraining = transform(topLvlImdsTrain,@(x) imresize(x(1:360, 281:640,:),targetSize));
rightValidation = transform(topLvlImdsValidate,@(x) imresize(x(1:360, 281:640,:),targetSize));

rightTraining = rightTraining.shuffle;
rightValidation = rightValidation.shuffle;


igmNew = read(leftTraining);
imgOrigi = read(topLvlImdsTrain);

whos igmNew imgOrigi;

subplot(121); imshow(igmNew{1,1}); axis on; title('Resized Left Window');
subplot(122); imshow(imgOrigi); axis on; title('Original');
