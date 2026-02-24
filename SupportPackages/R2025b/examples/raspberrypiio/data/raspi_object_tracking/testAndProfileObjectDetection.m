% TESTANDPROFILEOBJECTDETECTION - Use this script to test and profile the
% objecte detection network created.
%
% In 'MATLAB_CONNECTED_IO' mode live data will be captured from Raspberry Pi and the
% object detection network will run on MATLAB to detect objects within the image.
%
% In 'MATLAB_PIL' mode the object detection network will run on Raspberry Pi
% in PIL mode and user can evaluate the performance of the network.
clear;
%%
predictFunction  = 'raspi_yolov2_detect'; % Speccify the function name without .m
testMode         = 'MATLAB_CONNECTED_IO'; % [MATLAB_CONNECTED_IO , MATLAB_PIL]
imageSize        = [224,224,3];           % Size of input image for the network

testWithServo    = true;                  % If set to true, code to rotate the servo motor will be executed.
servoIncrement   = 2;                     % Rate at which the position of servo should change
servoPinNumber   = 6;                     % GPIO6 for servo control
sPos             = 90;
MinPulseDuration = 1e-3;
MaxPulseDuration = 2e-3;
%%
switch testMode
    case 'MATLAB_CONNECTED_IO'
        % Create IO object to capture data from Raspberry Pi
        raspiObj      = raspi;
        cameraObj     = cameraboard(raspiObj);
        if testWithServo
            sObj = servo(raspiObj, servoPinNumber, 'MaxPulseDuration', MaxPulseDuration, 'MinPulseDuration', MinPulseDuration); %#ok<*UNRCH>
            writePosition(sObj,sPos);
        end
        imgFromCamera = snapshot(cameraObj);
        figureHandle  = imshow(imgFromCamera);
        
        while(ishghandle(figureHandle))
            imgFromCamera          = snapshot(cameraObj);
            imgToNetwork           = imresize(imgFromCamera,imageSize(1:2));
            [outImg, posIncFactor] = feval(predictFunction,imgToNetwork); %#ok<*FVAL>
            imshow(outImg);
            if testWithServo
                sPos = sPos + (servoIncrement*posIncFactor);
                sPos = max(sPos,0);
                sPos = min(sPos,180);
                writePosition(sObj,sPos);
            end
        end
        disp('Testing done with MATLAB_CONNECTED_IO mode.');
        
    case 'MATLAB_PIL'
        % Generate PIL execuatable for the predict functon
        pilExecutable = [predictFunction,'_pil'];
        pilExecutableFile = dir([pilExecutable,'*']);
        predictFunctionFile = dir([predictFunction,'.m']);
        % Check for timestamps and initiate pil build
        if isempty(pilExecutableFile) || (pilExecutableFile.datenum < predictFunctionFile.datenum)
            create_pil_raspi(predictFunction);
        end
        
        % Create IO object to capture data from Raspberry Pi
        raspiObj      = raspi;
        cameraObj     = cameraboard(raspiObj);
        if testWithServo
            sObj = servo(raspiObj, servoPinNumber, 'MaxPulseDuration', MaxPulseDuration, 'MinPulseDuration', MinPulseDuration); %#ok<*UNRCH>
            writePosition(sObj,sPos);
        end
        imgFromCamera = snapshot(cameraObj);
        figureHandle  = imshow(imgFromCamera);
        
        predictFunctionPIL = [predictFunction,'_pil'];
        while(ishghandle(figureHandle))
            imgFromCamera          = snapshot(cameraObj);
            imgToNetwork           = imresize(imgFromCamera,imageSize(1:2));
            [outImg, posIncFactor] = feval(predictFunctionPIL,imgToNetwork); %#ok<*FVAL>
            imshow(outImg);
            if testWithServo
                sPos = sPos + (servoIncrement*posIncFactor);
                sPos = max(sPos,0);
                sPos = min(sPos,180);
                writePosition(sObj,sPos);
            end
        end
        clear(predictFunctionPIL);
        disp('Testing done with MATLAB_PIL mode.');
        
    otherwise
        error('Wrong testMode. Allowed values : {MATLAB_CONNECTED_IO , MATLAB_PIL}');
end
%EOF