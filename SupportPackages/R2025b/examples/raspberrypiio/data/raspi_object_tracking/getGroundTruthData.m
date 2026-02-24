function folderName = getGroundTruthData(camObj,captureTime)
% GETGROUNDTRUTHDATA will run for the duration specified in captureTime
% and takes snapshot from the camera specified as camObj.
% All the images will be stored in a seperate directory. 
% The output variable 'folderName' shows the directory name.

% Copyright 2020 The MathWorks, Inc.

% Capture image and show the image as a preview
img = snapshot(camObj);
imshow(img);

% Start progeres bar for the image capture
waitBarHandle = waitbar(0,'Starting image capture... ','windowstyle', 'modal');

% Create output folder in the format Data-21-Apr-2020-11-30-57
folderName = ['Data-',strrep(strrep(datestr(datetime), ':', '-'), ' ', '-')];
mkdir(folderName);

t           = tic;
count       = 1;
elapsedTime = toc(t);

while(elapsedTime < captureTime)
    img         = snapshot(camObj);
    imshow(img);
    
    fileName    = [folderName,filesep,'image_',num2str(count),'.png'];
    imwrite(img,fileName);
    
    count       = count + 1;
    elapsedTime = toc(t);
    progress    = elapsedTime/captureTime;
    waitbar(progress,waitBarHandle,['Saving image to ',folderName]);
end

% Done with image capture. Show progerss bar as 100%
waitbar(1,waitBarHandle,['Captured data to ',folderName]);
end