%% Create Simple Live Editor Task
% This example shows how to create a simple custom Live Editor task and add it to a live script. 
% 
%% Define Live Editor Task Subclass
% Define a class called |NormalizeVectorData| that creates a custom Live Editor 
% task for normalizing vector data.
%
% To define the class, create a file called |NormalizeVectorData.m| that contains 
% the |NormalizeVectorData| class definition with these features:
%
% * |State| and |Summary| public properties that store the current state of the 
%   task and a dynamic summary of what the task does.
% * Private properties that store the drop-down lists, spinners, checkboxes,
% and grid layout managers for selecting input data and specifying parameters.
% * A |setup| method that initializes the task.
% * A |generateCode| method that updates the generated code for the task.
% * |get.Summary|, |get.State|, and |set.State| methods for getting and
% setting the summary and state of the task.
% * An |updateComponents| method that updates the task when a user selects 
% input data or changes parameters.
% * A |reset| method that resets the state of the task.
% 
% *|NormalizeVectorData| Class Definition* 
%
% <include>NormalizeVectorData.m</include>
%
%% Configure Live Editor Task Metadata
% To configure the task metadata, call the |matlab.task.configureMetadata| 
% function and select the |NormalizeVectorData.m| file. The Task
% Metadata dialog box opens with all of the required task metadata details prepopulated.
%
% <<../configureNormalizeMetadata.png>>
%
% Modify the prepopulated metadata details and click *OK*. MATLAB creates a folder 
% named |resources| inside the folder containing your task class definition file. 
% Inside the |resources| folder, MATLAB generates a file named |liveTasks.json|.
% Add the folder containing the task class definition file to the MATLAB path by calling
% the |addpath| function or using the *Add Folder* button in the Set Path dialog box. 
%
%% Add Live Editor Task to Live Script
% On a code line, type |vector|. 
% MATLAB shows a list of suggested matches.
% 
% <<../normalizeTaskSuggestion.png>>
%
% Select *Normalize Vector Data* from the list. MATLAB adds the Normalize 
% Vector Data task to the live script.
%
% <<../normalizeTaskInScript.png>>
%
% Copyright 2021 The MathWorks, Inc.