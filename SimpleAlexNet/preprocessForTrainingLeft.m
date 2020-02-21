function [dataOut,info] = preprocessForTrainingLeft(data,info)
 
%numRows = size(data,4);
%dataOut = cell(numRows,2);

dataOut = cell(1,2);

%targetSize = [227,227];
 

% Randomized 90 degree rotation
%imgOut = rot90(data,randi(4)-1);
imgOut = imresize(data(1:360, 1:360,:),[227,227]);


% Return the label from info struct as the 
% second column in dataOut.
dataOut(1,:) = {imgOut,info.Label(1)};
    
end