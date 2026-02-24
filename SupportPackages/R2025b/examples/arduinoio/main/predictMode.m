function y = predictMode(input)
% predictActivity - Predict Machine Mode based on trained model stored in the mat file.

% Copyright 2024 The MathWorks, Inc.

persistent model;

if isempty(model)
   model = load('modeTrainedModel.mat'); 
end

y = model.trainedModel.predictFcn(input);

end