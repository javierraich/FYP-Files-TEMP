r1 = randperm(333,floor(333/5));
r1 = sort(r1);
r1 = r1 + 399;

 topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
  ('exp'+string(400)));
 
 topLvlImdsTrain = imageDatastore(topLevelPath);
 
 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 
 labels = labels/500;
 
 topLvlImdsTrain.Labels = labels;
 
  topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
  ('exp'+string(r1(1,1))));
 
 topLvlImdsValidate = imageDatastore(topLevelPath);
 
 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 
 labels = labels/500;
 
 topLvlImdsValidate.Labels = labels;
 
 indexR1 = 2;
 
 
   for i = 401:732
      
    topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
     ('exp'+string(i)));
 
    if r1(1,indexR1) == i
        indexR1 = indexR1 + 1;
    end

    if exist((fullfile(topLevelPath, 'lab_L.mat')), 'file')
        
        
        imds = imageDatastore(topLevelPath);

        labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));

        labels = labels/500;

        imds.Labels = labels;
     

         if r1(1,(indexR1-1)) == i

            tmpLabels = topLvlImdsValidate.Labels;
            topLvlImdsValidate = imageDatastore(cat(1,topLvlImdsValidate.Files,imds.Files));
            topLvlImdsValidate.Labels = cat(1,tmpLabels,imds.Labels);

         else
            tmpLabels = topLvlImdsTrain.Labels;
            topLvlImdsTrain = imageDatastore(cat(1,topLvlImdsTrain.Files,imds.Files));
            topLvlImdsTrain.Labels = cat(1,tmpLabels,imds.Labels);
         end
                          
    end

  end