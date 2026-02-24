classdef raspiObjectTracker < handle
    % RASPIOBJECTTRACKER Provides utilities to create an object tracker
    % with Raspberry Pi. 
    
    % Copyright 2020 The MathWorks, Inc.
    %#codegen
    
    properties
        BoardDetails = struct('Name',           'Raspberry Pi',...
            'DeviceAddress',  '192.168.0.111',...
            'UserName',       'pi',...
            'Password',       'raspberry');
        Setup        = struct('DataCaptureTime',120,...
            'CameraInterface','webcam');
        Detector     = struct('LabeledData',    'objectLabel.mat',...
            'ImageSize',      [224,224,3],...
            'NumClasses',     1,...
            'SampleImage',    'sampleImage.jpg',...
            'Network',        struct('DAGNetwork',resnet18,...
            'FeatureLayer','res3b_relu',...
            'AnchorBoxes',[64,64]),...
            'TrainingOptions',struct('InitialLearnRate',0.001,...
            'Verbose',true,...
            'MinBatchSize',16,...
            'MaxEpochs',30,...
            'Shuffle','never',...
            'VerboseFrequency',30,...
            'CheckOutPath',tempdir),...
            'DetectorMatFile','detectorSaved.mat');
        TestAndProfile = struct('PredictFunction','raspi_yolov2_detect',...
            'TestMode','IO',...
            'TestDuration',60,...
            'Servo',struct('TestWithServo',false,...
            'Increment',0.5,...
            'PinNumber',12,...
            'StartPosition',90,...
            'MinPulseDuration',0.5e-3,...
            'MaxPulseDuration',2.5e-3));
    end
    
    properties (Hidden,Constant)
        AvailableCamInterface = {'webcam','cameraboard'};
    end
    
    methods
        function obj = raspiObjectTracker()
            %RASPIOBJECTTRACKER Construct an instance of this class
            %   Detailed explanation goes here
            hb = codertarget.linux.remotebuild.BoardParameters(obj.BoardDetails.Name);
            hostname = hb.getParam('hostname');
            username = hb.getParam('username');
            password = hb.getParam('password');
            
            obj.BoardDetails.DeviceAddress = hostname;
            obj.BoardDetails.UserName = username;
            obj.BoardDetails.Password = password;
        end
        
        function set.BoardDetails(obj,val)
            obj.BoardDetails.DeviceAddress = val.DeviceAddress;
            obj.BoardDetails.UserName = val.UserName;
            obj.BoardDetails.Password = val.Password;
        end
        
        function set.Setup(obj,val)
            validateattributes(val.DataCaptureTime,...
                {'numeric'},...
                {'real','nonnegative','integer','scalar','>=',1},...
                '', ...
                'DataCaptureTime');
            validatestring(val.CameraInterface, obj.AvailableCamInterface,'','CameraInterface');
            
            obj.Setup.DataCaptureTime = val.DataCaptureTime;
            obj.Setup.CameraInterface = val.CameraInterface;
        end
        
        function set.Detector(obj,val)
            validateattributes(val.LabeledData,{'char'},{'row','nonempty'},'','LabeledData');
            validateattributes(val.SampleImage,{'char'},{'row'},'','SampleImage');
            validateattributes(val.DetectorMatFile,{'char'},{'row','nonempty'},'','DetectorMatFile');
            validateattributes(val.Network.DAGNetwork,{'DAGNetwork'},{'scalar'},'','DAGNetwork')
            validateattributes(val.Network.FeatureLayer,{'char'},{'row','nonempty'},'','FeatureLayer');
            obj.Detector.LabeledData = val.LabeledData;
            obj.Detector.ImageSize = val.ImageSize;
            obj.Detector.NumClasses = val.NumClasses;
            obj.Detector.SampleImage = val.SampleImage;
            obj.Detector.Network.DAGNetwork = val.Network.DAGNetwork;
            obj.Detector.Network.FeatureLayer = val.Network.FeatureLayer;
            obj.Detector.Network.AnchorBoxes = val.Network.AnchorBoxes;
            obj.Detector.TrainingOptions.InitialLearnRate = val.TrainingOptions.InitialLearnRate;
            obj.Detector.TrainingOptions.Verbose = val.TrainingOptions.Verbose;
            obj.Detector.TrainingOptions.MinBatchSize = val.TrainingOptions.MinBatchSize;
            obj.Detector.TrainingOptions.MaxEpochs = val.TrainingOptions.MaxEpochs;
            obj.Detector.TrainingOptions.Shuffle = val.TrainingOptions.Shuffle;
            obj.Detector.TrainingOptions.VerboseFrequency = val.TrainingOptions.VerboseFrequency;
            obj.Detector.TrainingOptions.CheckOutPath = val.TrainingOptions.CheckOutPath;
            obj.Detector.DetectorMatFile = val.DetectorMatFile;
        end
        
        function set.TestAndProfile(obj,val)
            obj.TestAndProfile.PredictFunction = val.PredictFunction;
            obj.TestAndProfile.TestMode = val.TestMode;
            obj.TestAndProfile.TestDuration = val.TestDuration;
            obj.TestAndProfile.Servo.TestWithServo = val.Servo.TestWithServo;
            obj.TestAndProfile.Servo.Increment = val.Servo.Increment;
            obj.TestAndProfile.Servo.PinNumber = val.Servo.PinNumber;
            obj.TestAndProfile.Servo.StartPosition = val.Servo.StartPosition;
            obj.TestAndProfile.Servo.MinPulseDuration = val.Servo.MinPulseDuration;
            obj.TestAndProfile.Servo.MaxPulseDuration = val.Servo.MaxPulseDuration;
        end
        
        function objectTrackingSetup(obj)
            % Set time duration (seconds) for data capture
            dataCaptureTime = obj.Setup.DataCaptureTime;
            
            % Create raspi obj and camera obj
            hostname = obj.BoardDetails.DeviceAddress;
            username = obj.BoardDetails.UserName;
            password = obj.BoardDetails.Password;
            raspiObj = raspi(hostname,username,password);
            switch obj.Setup.CameraInterface
                case 'webcam'
                    cameraObj = webcam(raspiObj);
                case 'cameraboard'
                    cameraObj = cameraboard(raspiObje);
                otherwise
                    error('Unknown camera interface');
            end
            
            sObj = servo(raspiObj,12);
            writePosition(sObj,90);
            % Get ground truth data for training
            dataLocation = getGroundTruthData(obj,cameraObj,dataCaptureTime);
            
            clear raspiObj;
            clear cameraObj;
            
            %Use Videolabeler app to mark desired object from the image sequence
            videoLabeler(dataLocation);
            
            disp('Use the Video Labeler app and export the label data to objectLabel.mat');
            
        end
        
        function createObjectDetector(obj)
            % CREATEOBJECTDECTOR - run the script to create a YOLOv2 object detector
            % based on the gTruth label data.
            
            %%
            labelData   = obj.Detector.LabeledData ; % mat file with object label (gTruth data)
            imageSize   = obj.Detector.ImageSize;       % Size of input image for the network
            numClasses  = obj.Detector.NumClasses;                 % Number of objects to detect
            sampleImage = obj.Detector.SampleImage; % Sample image for verifying
            %%
            %---------------------------------------------
            % Create a YOLO v2 object detection network.
            %---------------------------------------------
            % Use a pretrained ResNet-18 as base of YOLO v2. This requires  the Deep
            % Learning Toolbox Model for ResNet-18 Network Addon.
            network = obj.Detector.Network.DAGNetwork;
            
            % Specify the network layer to use for feature extraction. Use
            % 'analyzeNetwork' to see all the layer names in a network.
            % The below steps will delete the layers after the feature layer from the
            % feature extraction network.  A good feature extraction layer for YOLOv2
            % is one where the output features width and height are between 8 and 16
            % times smaller than the input image.
            % In this case, the input dimension is [224 224 3]. So, search for
            % something that is around 224/16 ~14. On analyzing resnet18, res3b_relu
            % was found to be downsampled by a factor of 16. This amount of
            % downsampling is a good tradeoff between spatial resolution and the
            % strength of the extracted features (features extracted further down the
            % network encode stronger image features at the cost of spatial resolution).
            featureLayer = obj.Detector.Network.FeatureLayer;
            
            % Specify the anchor boxes.
            anchorBoxes  = obj.Detector.Network.AnchorBoxes;
            
            % Create the YOLO v2 object detection network.
            lgraph       = yolov2Layers(imageSize, numClasses, anchorBoxes,...
                network, featureLayer);
            
            % Visualize the network using the network analyzer.
            % analyzeNetwork(lgraph)
            
            options = trainingOptions('sgdm', 'InitialLearnRate',obj.Detector.TrainingOptions.InitialLearnRate,...
                'Verbose', obj.Detector.TrainingOptions.Verbose, 'MiniBatchSize',obj.Detector.TrainingOptions.MinBatchSize,...
                'MaxEpochs',obj.Detector.TrainingOptions.MaxEpochs,'Shuffle',obj.Detector.TrainingOptions.Shuffle,...
                'VerboseFrequency',obj.Detector.TrainingOptions.VerboseFrequency,'CheckpointPath',obj.Detector.TrainingOptions.CheckOutPath);
            
            % Load gTruth data from mat file and create datastore for training
            load(labelData); %#ok<LOAD,EMLOAD>
            [imds,blds]     = objectDetectorTrainingData(gTruth);
            ds              = combine(imds,blds);
            [detector,~] = trainYOLOv2ObjectDetector(ds,lgraph,options);
            %%
            % Verify the detector using sample image
            if isfile(sampleImage)
                img             = imread(sampleImage);
                [bboxes,scores] = detect(detector,img); % bboxes = (x,y,length,breadth)
                if ~isempty(bboxes)
                    imgWithBox      = insertObjectAnnotation(img,'rectangle',bboxes,scores);
                    imshow(imgWithBox);
                else
                    imshow(img);
                end
                
            end
            
            %%
            % Save the detector to a mat file for future use
            save(obj.Detector.DetectorMatFile,'detector')
        end
        
        function startTestAndProfile(obj)
            % TESTANDPROFILEOBJECTDETECTION - Use this script to test and profile the
            % object detection network created.
            %
            % In 'MATLAB_CONNECTED_IO' mode live data will be captured from Raspberry Pi and the
            % object detection network will run on MATLAB to detect objects within the image.
            %
            % In 'MATLAB_PIL' mode the object detection network will run on Raspberry Pi
            % in PIL mode and user can evaluate the performance of the network.
            %%
            predictFunction  = obj.TestAndProfile.PredictFunction; % Specify the function name without .m
            testMode         = obj.TestAndProfile.TestMode; % [MATLAB_CONNECTED_IO , MATLAB_PIL]
            imageSize        = obj.Detector.ImageSize;           % Size of input image for the network
            
            testWithServo    = obj.TestAndProfile.Servo.TestWithServo;                  % If set to true, code to rotate the servo motor will be executed.
            servoIncrement   = obj.TestAndProfile.Servo.Increment;                     % Rate at which the position of servo should change
            servoPinNumber   = obj.TestAndProfile.Servo.PinNumber;                     % GPIO6 for servo control
            sPos             = obj.TestAndProfile.Servo.StartPosition;
            MinPulseDuration = obj.TestAndProfile.Servo.MinPulseDuration;
            MaxPulseDuration = obj.TestAndProfile.Servo.MaxPulseDuration;
            %%
            switch testMode
                case 'IO'
                    % Create IO object to capture data from Raspberry Pi
                    raspiObj      = raspi;
                    if strcmp(obj.Setup.CameraInterface,'webcam')
                        cameraObj     = webcam(raspiObj);
                    else
                        cameraObj     = cameraboard(raspiObj);
                    end
                    
                    if testWithServo
                        sObj = servo(raspiObj, servoPinNumber, 'MaxPulseDuration', MaxPulseDuration, 'MinPulseDuration', MinPulseDuration); %#ok<*UNRCH>
                        writePosition(sObj,sPos);
                    end
                    windowTitle = 'Raspberry Pi Display';
                    compassTitle = 'Servo Position';
                    hFig = findobj('Name',windowTitle);
                    compFig = findobj('Name',compassTitle);
                    if ~isempty(hFig)
                        hFig.NumberTitle = 'off';
                        hFig.MenuBar = 'none';
                        hFig.ToolBar = 'none';
                    else
                        hFig = figure('Name',windowTitle, ...
                            'NumberTitle','off',...
                            'MenuBar','none',...
                            'ToolBar','none');
                    end
                    ax = axes('Parent',hFig,'Visible','off');
                    dummyImg = zeros(imageSize,'uint8');
                    hIm = imshow(dummyImg,'parent',ax,'border','tight');
                    figure(hFig); % Bring figure window to foreground
                    if testWithServo
                        if ~isempty(compFig)
                            compFig.NumberTitle = 'off';
                            compFig.MenuBar = 'none';
                            compFig.ToolBar = 'none';
                        else
                            compFig = figure('Name',compassTitle, ...
                                'NumberTitle','off',...
                                'MenuBar','none',...
                                'ToolBar','none');
                            imagePosition = get(hFig,'Position');
                            compassPosition = [imagePosition(1)+imagePosition(3),imagePosition(2),imagePosition(3),imagePosition(4)];
                            set(compFig,'Position',compassPosition);
                        end
                        axCompass = axes('Parent',compFig,'Visible','off');
                        compass(axCompass,pol2cart(0,1));
                    end
                    
                    count = 1;
                    start = tic;
                    while(ishghandle(hFig) && toc(start) < obj.TestAndProfile.TestDuration)
                        imgFromCamera          = snapshot(cameraObj);
                        imgToNetwork           = imresize(imgFromCamera,imageSize(1:2));
                        [outImg, posIncFactor] = feval(predictFunction,imgToNetwork); %#ok<*FVAL>
                        Factor = posIncFactor*(1);
                        if ishghandle(hFig)
                            hIm.CData = outImg;
                            drawnow;
                        end
                        if testWithServo
                            sPos = sPos + (servoIncrement*Factor);
                            sPos = max(sPos,0);
                            sPos = min(sPos,180);
                            sPosRad = deg2rad(sPos);
                            
                            [U,V] = pol2cart(sPosRad,1);
                            if ishghandle(compFig)
                                compass(axCompass,U,V);
                                drawnow;
                            end
                            count = count+1;
                            writePosition(sObj,sPos);
                            % Change direction
                            if (sPos < 1) || (sPos > 179)
                                servoIncrement = servoIncrement*(-1);
                            end
                        end
                    end
                    disp('Testing done with CONNECTED IO mode');
                    
                case 'PIL'
                    % Generate PIL executable for the predict function
                    pilExecutable = [predictFunction,'_pil'];
                    pilExecutableFile = dir([pilExecutable,'*']);
                    predictFunctionFile = dir([predictFunction,'.m']);
                    % Check for timestamps and initiate pil build
                    if isempty(pilExecutableFile) || (pilExecutableFile.datenum < predictFunctionFile.datenum)
                        create_pil_raspi(obj,predictFunction);
                    end
                    
                    % Create IO object to capture data from Raspberry Pi
                    raspiObj      = raspi;
                    if strcmp(obj.Setup.CameraInterface,'webcam')
                        cameraObj     = webcam(raspiObj);
                    else
                        cameraObj     = cameraboard(raspiObj);
                    end
                    if testWithServo
                        sObj = servo(raspiObj, servoPinNumber, 'MaxPulseDuration', MaxPulseDuration, 'MinPulseDuration', MinPulseDuration); %#ok<*UNRCH>
                        writePosition(sObj,sPos);
                    end
                    windowTitle = 'Raspberry Pi Display';
                    compassTitle = 'Servo Position';
                    hFig = findobj('Name',windowTitle);
                    compFig = findobj('Name',compassTitle);
                    if ~isempty(hFig)
                        hFig.NumberTitle = 'off';
                        hFig.MenuBar = 'none';
                        hFig.ToolBar = 'none';
                    else
                        hFig = figure('Name',windowTitle, ...
                            'NumberTitle','off',...
                            'MenuBar','none',...
                            'ToolBar','none');
                    end
                    ax = axes('Parent',hFig,'Visible','off');
                    dummyImg = zeros(imageSize,'uint8');
                    hIm = imshow(dummyImg,'parent',ax,'border','tight');
                    figure(hFig); % Bring figure window to foreground
                    
                    if testWithServo
                        if ~isempty(compFig)
                            compFig.NumberTitle = 'off';
                            compFig.MenuBar = 'none';
                            compFig.ToolBar = 'none';
                        else
                            compFig = figure('Name',compassTitle, ...
                                'NumberTitle','off',...
                                'MenuBar','none',...
                                'ToolBar','none');
                            imagePosition = get(hFig,'Position');
                            compassPosition = [imagePosition(1)+imagePosition(3),imagePosition(2),imagePosition(3),imagePosition(4)];
                            set(compFig,'Position',compassPosition);
                        end
                        axCompass = axes('Parent',compFig,'Visible','off');
                        compass(axCompass,pol2cart(0,1));
                    end
                    
                    predictFunctionPIL = [predictFunction,'_pil'];
                    start = tic;
                    while(ishghandle(hFig) && (toc(start) < obj.TestAndProfile.TestDuration))
                        imgFromCamera          = snapshot(cameraObj);
                        imgToNetwork           = imresize(imgFromCamera,imageSize(1:2));
                        [outImg, posIncFactor] = feval(predictFunctionPIL,imgToNetwork); %#ok<*FVAL>
                        Factor = posIncFactor*(1);
                        if ishghandle(hFig)
                            hIm.CData = outImg;
                            drawnow;
                        end
                        if testWithServo
                            sPos = sPos + (servoIncrement*Factor);
                            sPos = max(sPos,0);
                            sPos = min(sPos,180);
                            sPosRad = deg2rad(sPos);
                            
                            [U,V] = pol2cart(sPosRad,1);
                            if ishghandle(compFig)
                                compass(axCompass,U,V);
                                drawnow;
                            end
                            writePosition(sObj,sPos);
                            % Change direction
                            if (sPos < 1) || (sPos > 179)
                                servoIncrement = servoIncrement*(-1);
                            end
                        end
                    end
                    clear(predictFunctionPIL);
                    disp('Testing done with PIL mode');
                    
                otherwise
                    error('Wrong testMode. Allowed values : {IO , PIL}');
            end
            %EOF
        end
        
    end
    
    methods(Hidden)
        function folderName = getGroundTruthData(~,camObj,captureTime)
            % GETGROUNDTRUTHDATA will run for the duration specified in captureTime
            % and takes snapshot from the camera specified as camObj.
            % All the images will be stored in a separate directory.
            % The output variable 'folderName' shows the directory name.
            
            % Capture image and show the image as a preview
            img = snapshot(camObj);
            imshow(img);
            
            % Start progress bar for the image capture
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
            
            % Done with image capture. Show progress bar as 100%
            waitbar(1,waitBarHandle,['Captured data to ',folderName]);
        end
        
        function create_pil_raspi(~,fcnName)
            % CREATE_PIL_MEX Build a PIL MEX function.
            %
            % Customized for Raspberry Pi
            % CREATE_PIL_MEX(fcnName) creates a PIL MEX function that runs the
            % generated code on Raspberry Pi
            %
            % Example:
            % create_pil_mex('fft')
            
            narginchk(2,2);
            
            % targetHardware & deploy workflow for PIL
            t   = targetHardware('Raspberry Pi');
            cfg = coder.config('lib','ecoder',true);
            
            % Create custom coder config for PIL
            cfg.Hardware               = coder.hardware('Raspberry Pi');
            cfg.TargetLang             = 'C++';
            cfg.VerificationMode       = 'PIL';
            cfg.CodeExecutionProfiling = true;
            
            dlcfg                      = coder.DeepLearningConfig('arm-compute');
            dlcfg.ArmArchitecture      = 'armv7';
            cfg.DeepLearningConfig     = dlcfg;
            
            % Assign the dlcfg to coder config
            t.CoderConfig              = cfg;
            
            % Deploy the function
            deploy(t,fcnName);
        end
    end
end

