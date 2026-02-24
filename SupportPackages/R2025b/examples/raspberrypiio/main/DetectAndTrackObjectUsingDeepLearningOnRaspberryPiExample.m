%% Detect and Track Object Using Deep Learning on Raspberry Pi
% This example shows how to use the MATLAB(R) Support Package for Raspberry
% Pi(R) Hardware to deploy a deep learning algorithm that
% detects and tracks an object in Connected IO and PIL modes.
% This algorithm uses the ResNet-18-based YOLOv2 neural network to
% identify the object captured by the camera mounted on a servo motor and connected to the Raspberry Pi hardware.
% You can experiment with different objects in your surroundings to see how
% accurately the network detects images on the Raspberry Pi hardware.
%
% Note: You cannot generate and deploy deep learning code on Raspberry Pi hardware using macOS.

% Copyright 2020 The MathWorks, Inc.

%% Prerequisites
%
% Configure the Raspberry Pi network using the *Hardware Setup* window.
% During this process, download the MathWorks(R) Raspbian
% image for deep learning. Instead of using the MathWorks Raspbian image, if you
% choose to customize an existing image on your hardware, ensure that you
% select the option to install the ARM(R) Compute Library.
%
%% Required Hardware
%
% * Raspberry Pi hardware (Model 4 recommended)
% * Supported <https://elinux.org/RPi_USB_Webcams USB webcam> 
% or <https://www.raspberrypi.com/products/camera-module-v2/ Raspberry Pi camera module>
% * Power adapter for the Raspberry Pi board
% * Servo motor
% * Jumper cable
%
%% Hardware Setup
%
% # Power the Raspberry Pi target board.
% # Connect the servo motor to the Raspberry Pi target board using the
% jumper cables. Connect the GND and VCC pins. Additionally, in this example, you connect the servo motor
% signal pin to the GPIO pin 12 of the Raspberry Pi target board.
% # Mount the camera on top of the servo motor using sticky tape or
% an adhesive. This example uses a USB web camera.
%
%% Create Tracker Object
% Create the |tracker| object and obtain the ground truth data. 
%%
%   tracker = raspiObjectTracker
%%
%   tracker =
%
%  raspiObjectTracker with properties:
%
%      BoardDetails: [1x1 struct]
%             Setup: [1x1 struct]
%          Detector: [1x1 struct]
%    TestAndProfile: [1x1 struct]
%%
% View the Raspberry Pi target board details.
%%
%   tracker.BoardDetails
%%
%   ans = 
%
%  struct with fields:
%
%             Name: 'Raspberry Pi'
%    DeviceAddress: '192.168.0.100'
%         UserName: 'pi'
%         Password: 'raspberry'
%%
% This structure shows the name, device address, user name, and password of the Raspberry Pi board.
%
% Note: You can change the values by using dot notation. For example, change the password to |MATLAB| using |tracker.BoardDetails.Password = 'MATLAB'|.
%%
% Check your change by viewing the properties again.
%%
%   tracker.BoardDetails
%%
%   ans = 
%
%  struct with fields:
%
%             Name: 'Raspberry Pi'
%    DeviceAddress: '192.168.0.100'
%         UserName: 'pi'
%         Password: 'MATLAB'
%%
% The structure shows the updated password.
%%%
% View the image capture setup properties.
%%
%   tracker.Setup
%%
%   ans = 
%
%  struct with fields:
%
%    DataCaptureTime: 120
%    CameraInterface: 'webcam'
%%
% This structure shows the type of interface and the capture time.
%
% * |DataCaptureTime| &mdash; Time duration in seconds for image capture
% of the tracked object. The default time is |120| seconds. You can change the values by using dot notation.
% 
% Note: You can increase the capture time to improve the training efficiency of
% the neural network when detecting and tracking an object. For example, to change the capture time to |300| seconds use |tracker.Setup.DataCaptureTime = 300|.
%%
% * |CameraInterface| &mdash; Type of camera interface used to detect
% and track the object, which can be a <docid:mlsupportpkg#buerllq-1 webcam> or <docid:mlsupportpkg#buno94s cameraboard> object.
% The default interface is |webcam|. 
%%
% Place the object to detect and track in front of the camera and run this command at the
% MATLAB Command Window:
%%
%   objectTrackingSetup(tracker)
%%
% This command establishes an IO connection with the Raspberry Pi hardware
% and obtains the ground truth data from the webcam. It also opens the
% *Video Labeler* app.
%%
% The camera captures images for the time that you specify in the
% |DataCaptureTime| property. The app saves the images to a folder in the
% current working directory named |Data|-_date_-_timestamp_, where |date|
% is the current date and |timestamp| is the current time.
%%
% Copy one sample image from the |Data|-_date_-_timestamp_ folder and paste
% it in the current working directory. Note the file name so that you can use it as a reference image while training the network by setting the |tracker.Detector.SampleImage| property.
%
% <<../objectTrackingSetup.png>>
%
% Running the |objectTrackingSetup(tracker)| command also opens the
% <docid:vision_ref#mw_f2d359b5-81b9-4fda-9c7e-84a6164506b8 Video Labeler> app.
% This app allows you to mark the region of interest (ROI),
% automatically label across image frames using an automation
% algorithm, and export the labeled ground truth.
%
% <<../video_Labeler_app.PNG>>
%
% Follow these steps in the Video Labeler app:
%
% # In the *ROI Labels* pane, click *Label*. Create a *Rectangular* label,
% name it, and click *OK*. In this example, the object has the name
% |ball|.
% # Use the mouse to draw a rectangular ROI in the image.
% # In the *Automate Labeling* section, use the *Select Algorithm* button
% to select the |Point Tracker| algorithm and then click *Automate*. The
% algorithm instructions appear in the right pane, and the selected labels
% are available to automate.
% # In the *Run* section, click *Run* to automate labeling for the image sequence.
% # When you are satisfied with the algorithm results, in the *Close* section, click *Accept*.
% # Under *Export Labels*, select *To File* to export the labeled data to a MAT file *objectLabel.mat*.
%
%%
% For detailed information on how to use the Video Labeler app, see
% <docid:vision_ref#mw_f2d359b5-81b9-4fda-9c7e-84a6164506b8 Video Labeler> and
% <docid:vision_ug#mw_552539ba-92c5-49d5-adbb-3e21ab32460a Get Started with the Video Labeler>.
%
%% Detect Object
% Train the YOLOv2 object detector from the captured ground truth data
% and verify the detected object in Connected IO and PIL modes.
%%
% Use the |tracker.Detector| command to check if the value of the |LabeledData| field is the name of the 
% MAT file that you exported using the Video Labeler app.
%%
%   tracker.Detector
%%
%   ans = 
%
%  struct with fields:
%
%        LabeledData: 'objectLabel.mat'
%          ImageSize: [224 224 3]
%         NumClasses: 1
%        SampleImage: 'sampleImage.jpg'
%            Network: [1x1 struct]
%    TrainingOptions: [1x1 struct]
%    DetectorMatFile: 'detectorSaved.mat'
%
%% Train YOLOv2 Object Detector
% Train the YOLOv2 object detector with the images captured from
% the camera. The |objectLabel.mat| file contains the
% exported ground truth data. Use this file to train the
% YOLOv2 object detector.
%%
% From the current directory of the captured object images, select
% a valid sample image as a reference for training the neural network. For this example, set
% the sample image to |image_50.png|.
%%
%   tracker.Detector.SampleImage = 'image_50.png';
%%
% Train the YOLOv2 object detector and save it as the MAT file |detectorSaved.mat|.
%%
%   createObjectDetector(tracker)
%
% <<../createObjectDetector.PNG>>
%
% A figure window containing the selected sample image opens once the YOLOv2 neural network has finished training the images. This image shows an ROI
% and the probability of match within the training network.
%%%
% <<../detection_connectedIO_mode.PNG>>
%%%
% *Note*: You can verify the object detection in either Connected IO
% or PIL modes.
%
%% Verify Object Detection in Connected IO Mode
% Use the Connected IO mode to verify the detected object. The image capture process
% takes place on Raspberry Pi hardware itself.
%%
% Run this command at the MATLAB Command Window:
%%
%   tracker.TestAndProfile
%%
%   ans = 
%
%  struct with fields:
%
%    PredictFunction: 'raspi_yolov2_detect'
%           TestMode: 'IO'
%       TestDuration:  60
%              Servo: [1x1 struct]
%%
% The default |TestMode| value is |'IO'|.
%%
% Verify object detection in the IO mode:
%%
%   startTestAndProfile(tracker)
%%
% A camera window opens showing an ROI
% and the probability of match within the training network for the detected object.
%
% <<../figure_window.PNG>>
%
%% Verify Object Detection in PIL Mode
% Use the PIL mode to verify the detected object. The image capture process
% takes place on the Raspberry Pi hardware itself. The
% |raspi_yolov2_detect| function runs on the Raspberry Pi board in the PIL
% mode. 
%%%
% Note: Object detection and tracking in the PIL mode takes some time to execute.
%%%
% Change the object detection mode to |'PIL'|.
%%
%   tracker.TestAndProfile.TestMode = 'PIL';
%%
% Run this command at the MATLAB Command prompt to verify the object
% detection in PIL mode.
%%
%   startTestAndProfile(tracker)
%%%
% A camera window opens showing an ROI
% and the probability of match within the training network for the detected object.
%
% <<../detection_PIL_mode.PNG>>
%
% <<../detection_PIL_message.PNG>>
%
% To view the *Code Execution Profiling Report*, click the *Execution profiling report* link.
%
% <<../code_execution_profiling_report.PNG>>
%
%% Configure Servo Motor Parameters
% To track an object after its successful detection, you must configure the
% servo motor parameters.
%%
% View the servo motor parameters.
%%
%   tracker.TestAndProfile.Servo
%%
%   ans =
%
%  struct with fields:
%
%       TestWithServo: 0
%           Increment: 0.5000
%           PinNumber: 12
%       StartPosition: 90
%    MinPulseDuration: 5.0000e-04
%    MaxPulseDuration: 0.0025
%%
% * |TestWithServo| - Flag to enable or disable the servo motor
% for tracking the object. The default value of this field is |false|. Enable the servo
% motor using this command:
%%
%   tracker.TestAndProfile.Servo.TestWithServo = true;
%%
% You can modify these parameters based on the datasheet for your servo
% motor:
%
% 1. |Increment| - Step angle size of rotation of the servo
% motor. The default step angle value is |0.5| degrees.
%%
% 2. |PinNumber| - GPIO pin number of the Raspberry Pi target
% board to which the servo motor is connected.
%%
% 3. |StartPosition| - Starting angle position of the servo
% motor. The servo motor rotates from 0 to 180 degrees. The default
% starting angle is 90 degrees.
%%
% 4. |MinPulseDuration| - Minimum pulse duration to move to 0 degrees.
%%
% 5. |MaxPulseDuration| - Maximum pulse duration to move to 180 degrees.
%
%% Track Object in Connected IO Mode
% Use these commands to ensure that object tracking on the servo motor is enabled and the test mode is set to IO:
%%
%   tracker.TestAndProfile.Servo.TestWithServo = true;
%%
%   tracker.TestAndProfile.TestMode = 'IO';
%%
% Track the detected object in connected IO mode:
%%
%   startTestAndProfile(tracker)
%%
% Place the object in front of the camera and move the object. Observe that
% the servo motor rotates to follow the moving object.
%%
% A camera window opens with the ROI and the probability of
% match with the training network. A separate window opens to display
% the angle of the servo motor.
%
% <<../tracking_connectedIO_mode.PNG>>
%
% <<../tracking_connectedIO_message.PNG>>
%
%% Track Object in PIL Mode
% Use these commands to ensure that object tracking on the servo motor is enabled and the test mode is set to PIL:
%%
%   tracker.TestAndProfile.Servo.TestWithServo = true
%%
%   tracker.TestAndProfile.TestMode = 'PIL';
%%
% Track the detected object in connected PIL mode:
%%
%   startTestAndProfile(tracker)
%%
% Place the object in front of the camera and move the object. Observe that
% the servo motor rotates to follow the moving object.
%%
% A camera window opens with the ROI and the probability of
% match with the training network. A separate window opens to display
% the angle of the servo motor.
%
% <<../tracking_PIL_mode.PNG>>
%
% <<../tracking_PIL_message.PNG>>
%
%% Deploy on Raspberry Pi Target Board
% The |raspi_object_tracking| function executes the object tracking
% algorithm on the Raspberry Pi hardware board. This function follows the
% tracking algorithm specified in the |raspi_yolov2_detect| function.
%%
% Before deploying the code on the Raspberry Pi target board, open the
% |raspi_object_tracking.m| function file and configure the parameters by modifying one or more of these:
%
% * Input image size for the ResNet-18 neural network
% * Observations regarding the servo motor incremental angle, starting position, and so on
% * Type of camera interface for capturing images of the object
%
%%
% The |raspi_yolov2_detect| function uses the YOLOv2-based deconvolutional
% neural network (DNN) saved as a MAT file. Pass |inputImg| as an
% input to the detected network. If the object is detected, |outImg|
% contains the bounding box information of the detected object.
% |posIncFactor| indicates the rotation factor required to maintain the
% object at the center of the frame for this bounding box.
%%
% Open the |raspi_yolov2_detect.m| file and enter the name of the
% saved trained neural network MAT file |detectorSaved.mat| in the
% |yolov2obj| parameter.
%%
% Run these commands at the MATLAB command prompt. Note: For Raspberry Pi
% with 32-bit OS use |targetHardware('Raspberry Pi')| and for 64-bit OS use |targetHardware('Raspberry Pi (64bit)')|.
%%
%   t = targetHardware('Raspberry Pi (64bit)')
%%
%   t.CoderConfig.TargetLang = 'C++';
%%
%   dlcfg = coder.DeepLearningConfig('arm-compute');
%%
%   dlcfg.ArmArchitecture = 'armv7';
%%
%   t.CoderConfig.DeepLearningConfig = dlcfg;
%%
%   deploy(t,'raspi_object_tracking')
%%
% Observe that the camera mounted on the servo motor detects the object and
% also tracks its movement. On the Raspberry Pi desktop, open the camera
% display to observe the live tracking results.
%
% <<../deploy_raspberrypi_hardware.PNG>>
%
%%
% The deployed function initiates code generation of the
% |raspi_object_tracking| function. Once code generation is complete,
% MATLAB generates a code generation report. Use this report to debug the
% |raspi_object_tracking| function for any build errors or warnings in the
% generated code.
%
%%
% After successfully generating the code, the support package loads and
% runs the object classification algorithm as a standalone executable on
% the hardware. The executable starts detecting the objects in the
% acquired video and displays the predicted labels and their associated
% probabilities. To view the Raspberry Pi screen, use a VNC viewer and
% open a remote session on the hardware to get the display. You can
% alternatively connect an HDMI cable from the monitor to the hardware.
%
%% Other Things to Try
%
% * Train the YOLOv2 object detector to detect and track more than one
% object.
% * Use a neural network other than ResNet-18 for training the objects and
% observe the differences in the obtained results.
% * Use a different algorithm in the
% <docid:vision_ref#mw_f2d359b5-81b9-4fda-9c7e-84a6164506b8 Video
% Labeler> app and compare the results with the |Point Tracker| algorithm.
% * Change the input image size provided in the |raspi_yolov2_detect| function and observe the object detection image.
%
%% See Also
%
% * <docid:mlsupportpkg#example-resnet50_webcam Identify Objects Within Live Video Using ResNet-50 on Raspberry Pi Hardware>
% * <docid:mlsupportpkg#bu6ial4 Webcam>
% * <docid:mlsupportpkg#buno94s Cameraboard>
% * <docid:vision_ref#mw_f2d359b5-81b9-4fda-9c7e-84a6164506b8 Video Labeler> app
% * <docid:vision_ug#mw_552539ba-92c5-49d5-adbb-3e21ab32460a Get Started with the Video Labeler>