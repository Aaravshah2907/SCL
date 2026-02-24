function y = predictActivity(input)
% predictActivity - Predict human activity based on trained model stored in the mat file.

% Copyright 2023 The MathWorks, Inc.

persistent model;

if isempty(model)
   model = load('trainedModel.mat'); 
end

y = model.trainedModel.predictFcn(input);

end