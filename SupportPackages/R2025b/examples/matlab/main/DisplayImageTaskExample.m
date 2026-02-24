%% Display Image Using Custom Live Editor Task
% Define a class called |DisplayImage| that creates a custom Live Editor 
% task for displaying an image.
%
% To define the class, create a file called |DisplayImage.m| that contains 
% the following class definition with these features:
%
% * |State| and |Summary| public properties that store the current state of
% the task and a dynamic summary of what the task does.
% * Private properties that store the edit field and button for selecting an
% image.
% * A |setup| method that initializes the task.
% * A |generateCode| method that updates the generated code for the task
% when the selected image changes.
% * |get.Summary|, |get.State|, and |set.State| methods for getting and
% setting the summary and state of the task.
% * An |inputImageFile| method that prompts the user to select an image to
% display.
% * A |reset| method that resets the state of the task.
%
% <include>DisplayImage.m</include>
%
%%
% Next, configure the task metadata by calling the |matlab.task.configureMetadata| 
% function and selecting the |DisplayImage.m| file. The Task
% Metadata dialog box opens with all of the required task metadata details prepopulated.
%
% <<../configureDisplayImageTask.png>>
%
%%
% Select *OK* to use the prepopulated metadata details. MATLAB creates a folder 
% named |resources| inside the folder containing your task class definition file. Inside 
% the |resources| folder, MATLAB generates a file named |liveTasks.json|.
% 
% Add the folder containing the task class definition file to the MATLAB path by calling
% the |addpath| function or using the *Add Folder* button in the Set Path dialog box. 
%%
%
% Add the task to a live script. On a code line, type |display|. 
% MATLAB shows a list of suggested matches.
% 
% <<../displayImageSuggestion.png>>
%
%%
% Select *Display Image* from the list. MATLAB adds the Display Image task to the live script.
%
% <<../displayImageInScript.png>>
%
% Copyright 2020 The MathWorks, Inc.
