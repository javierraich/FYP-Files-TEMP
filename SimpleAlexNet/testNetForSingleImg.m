testData = leftValidation.read;
testImg = testData{1,1};
testLabel = testData{1,2};

predictedLabel = predict(trainedNnet, testImg);


figure
imshow(igmNew{1,1})
title(strcat('Prediction  ', string(predictedLabel), ' Truth   ', string(testLabel)))
