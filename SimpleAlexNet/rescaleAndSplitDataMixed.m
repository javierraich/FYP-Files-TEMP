topLvlImds = topLvlImds.shuffle;

[imds80,imds20] = splitEachLabel(topLvlImds,0.8);


targetSize = [227,227];

leftTraining = transform(imds80,@preprocessForTrainingLeft,'IncludeInfo',true);
leftValidation = transform(imds20,@preprocessForTrainingLeft,'IncludeInfo',true);

centerTraining = transform(imds80,@(x) imresize(x(1:360, 141:500,:),targetSize));
centerValidation = transform(imds20,@(x) imresize(x(1:360, 141:500,:),targetSize));

rightTraining = transform(imds80,@(x) imresize(x(1:360, 281:640,:),targetSize));
rightValidation = transform(imds20,@(x) imresize(x(1:360, 281:640,:),targetSize));


igmNew = read(leftTraining);
imgOrigi = read(imds80);

whos igmNew imgOrigi;

subplot(121); imshow(igmNew{1,1}); axis on; title('Resized Left Window');
subplot(122); imshow(imgOrigi); axis on; title('Original');


