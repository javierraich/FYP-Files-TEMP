%function dataStruct = loadExpFolder

%INPUT1 - expNum to choose a certain exp (or could simply cycle through all
%folders?


%%%%%Useful for loading only 1 experiment


topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
 ('exp'+string(400)));

topLvlImds = imageDatastore(topLevelPath);

labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));

labels = labels/500;

topLvlImds.Labels = labels;
    

  for i = 401:732
      
    topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
     ('exp'+string(i)));

    if exist((fullfile(topLevelPath, 'lab_L.mat')), 'file')
        
        imds = imageDatastore(topLevelPath);

        labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));

        labels = labels/500;

        imds.Labels = labels;
        
        %topLvlImds = combine(topLvlImds, imds);
    
         tmpLabels = topLvlImds.Labels;
     
         topLvlImds = imageDatastore(cat(1,topLvlImds.Files,imds.Files));
         topLvlImds.Labels = cat(1,tmpLabels,imds.Labels);
    end

  end
  

% allImages = readall(imds);
% 
% Imagedims = size(allImages);
% 
%  for i = 1:Imagedims(1)
%      %imshow(cell2mat(allImages(i,1)))
%      allImages = 
%  end



%imshow(cell2mat(allImages(1,1)))

%img1 = readimage(imds1,3);

%dsCombo = combine(imds1, imds2);



%loadedImages = readall(imagesDatastore);

