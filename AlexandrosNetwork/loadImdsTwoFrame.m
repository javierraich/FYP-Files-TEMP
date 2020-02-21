%Determining random experiments to allocate to training and validation (80%
%and 20% split)

r1 = randperm(333,floor(333/5));
r1 = sort(r1);
r1 = r1 + 399;


%First manual initialisation of the datastores

 topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
  ('exp'+string(400)));
 
 topLvlImdsTrainPresent = imageDatastore(topLevelPath);
 topLvlImdsTrainPresent.Files = setdiff(topLvlImdsTrainPresent.Files,topLvlImdsTrainPresent.Files{1,1});
 
 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 labels = labels(1,2:end);
 labels = labels/500;
 topLvlImdsTrainPresent.Labels = labels;
 
 %t-1 frame initialisation, very similar to above.
 topLvlImdsTrainPast = imageDatastore(topLevelPath);
 topLvlImdsTrainPast.Files = setdiff(topLvlImdsTrainPast.Files,topLvlImdsTrainPast.Files{end,1});

 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 labels = labels(1,1:end-1);
 labels = labels/500;
 topLvlImdsTrainPast.Labels = labels;
 
 
 %Initialise validation data datastore as well
  topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
  ('exp'+string(r1(1,1))));
 

 topLvlImdsValidatePresent = imageDatastore(topLevelPath);
 topLvlImdsValidatePresent.Files = setdiff(topLvlImdsValidatePresent.Files,topLvlImdsValidatePresent.Files{1,1});
 
 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 labels = labels(1,2:end);
 labels = labels/500;
 topLvlImdsValidatePresent.Labels = labels;
 
 topLvlImdsValidatePast = imageDatastore(topLevelPath);
 topLvlImdsValidatePast.Files = setdiff(topLvlImdsValidatePast.Files,topLvlImdsValidatePast.Files{end,1});

 labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
 labels = labels(1,1:end-1);
 labels = labels/500;
 topLvlImdsValidatePast.Labels = labels;
 
 indexR1 = 2;
 
 
   for i = 401:732
      
    topLevelPath = fullfile('c:\','Users','Javier R','Downloads', '3_Corridor', ...
     ('exp'+string(i)));
 
    if r1(1,indexR1) == i
        indexR1 = indexR1 + 1;
    end

    if exist((fullfile(topLevelPath, 'lab_L.mat')), 'file')
                   
         labels = importdata(fullfile(topLevelPath, 'lab_L.mat'));
                 
         imdsPresent = imageDatastore(topLevelPath);
         imdsPast = imageDatastore(topLevelPath);
         
         imdsPresent.Files = setdiff(imdsPresent.Files,imdsPresent.Files{1,1});
         imdsPast.Files = setdiff(imdsPast.Files,imdsPast.Files{end,1});

         
         imdsPresent.Labels = labels(1,2:end)/500;
         imdsPast.Labels = labels(1,1:end-1)/500;
     

         if r1(1,(indexR1-1)) == i

            tmpLabels = topLvlImdsValidatePresent.Labels;
            topLvlImdsValidatePresent = imageDatastore(cat(1,topLvlImdsValidatePresent.Files,imdsPresent.Files));
            topLvlImdsValidatePresent.Labels = cat(1,tmpLabels,imdsPresent.Labels);

            tmpLabels = topLvlImdsValidatePast.Labels;
            topLvlImdsValidatePast = imageDatastore(cat(1,topLvlImdsValidatePast.Files,imdsPast.Files));
            topLvlImdsValidatePast.Labels = cat(1,tmpLabels,imdsPast.Labels);
            
         else
             
            tmpLabels = topLvlImdsTrainPresent.Labels;
            topLvlImdsTrainPresent = imageDatastore(cat(1,topLvlImdsTrainPresent.Files,imdsPresent.Files));
            topLvlImdsTrainPresent.Labels = cat(1,tmpLabels,imdsPresent.Labels);

            tmpLabels = topLvlImdsTrainPast.Labels;
            topLvlImdsTrainPast = imageDatastore(cat(1,topLvlImdsTrainPast.Files,imdsPast.Files));
            topLvlImdsTrainPast.Labels = cat(1,tmpLabels,imdsPast.Labels);
            
         end
                          
    end

   end
  
   imdsTwoFrameTraining = combine(topLvlImdsTrainPresent, topLvlImdsTrainPast);
   imdsTwoFrameValidate = combine(topLvlImdsValidatePresent, topLvlImdsValidatePast);