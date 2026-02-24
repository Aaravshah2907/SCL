%% Modularize Your App by Creating a Custom UI Component
% As the size and complexity of an app increases, modularizing the app can
% help organize and manage the code. One modularization method is to
% separate out self-contained portions of your app layout with common
% functionality as custom UI components.
%
% Some benefits of this method include:
%
% * *Reusability* &mdash; You can reuse a custom UI component within a
% single app or across multiple apps with minimal effort.
% * *Maintainability* &mdash; You can reduce duplicate code by
% componentizing pieces of your app layout that perform similar functions.
% * *Scalability* &mdash; You can more easily extend app functionality when
% your code is organized into multiple self-contained portions. 
% 
% Starting in R2022a, you can use App Designer to create custom UI
% components, and then use those components in your apps. For more
% information, see
% <docid:creating_guis#mw_46809009-e3f2-4ef4-b0a4-0cdc9c142b73 Create a Simple Custom UI Component in App Designer>.
%% Example Overview
% This example explores an app that allows users to store and modify
% information about their lab procedures. An app user can update the status or
% date of a procedure, import data associated with a procedure, and
% order the procedures based on their titles, statuses, or dates.
%
% <<../lab-procedure-app.png>>
% 
% The example includes two different ways to create the app in App Designer:
%
% 1. As a self-contained app with all layout and behavior code contained in
% a single app file 
%
% 2. As a modular app where each lab procedure in the app is represented by
% a |LabProcedure| object, which is created as a custom UI component in
% App Designer
%
% The example contains these files:
%
% * |LabProcedureApp_WithoutComponent.mlapp| &mdash; Self-contained app file
% * |LabProcedure.mlapp| &mdash; Custom UI component file
% * |LabProcedureApp_WithComponent.mlapp| &mdash; Modular app file
%
% These steps describe how to take the self-contained app and make it more
% modular by creating and using the |LabProcedure| custom UI component.
%
%% Create the Custom UI Component
% To modularize an app by creating a custom UI component, first identify
% the portions of your app that can be extracted to a separate component
% file. For example, there are certain characteristics that every
% lab procedure in the app has in common.  These aspects
% are captured in the |LabProcedure| custom UI component.
% 
% To explore the component code, open the |LabProcedure.mlapp| file in App
% Designer.
% 
%% 
% *Lay Out Component*
%
% In *Design View*, lay out the |LabProcedure| component by
% adding the features that every lab procedure in the app has in common:
%
% * A label for the lab procedure title
% * A status drop-down component with the options |Not started|, |Running|,
% |Succeeded|, and |Failed|, and a status label
% * A date picker component and a date label
% * A button to import data
% * A button to view data
%
% <<../lab-procedure-component.png>>
%
%% 
% *Program Underlying Component Behavior*
%
% In *Code View*, program the behavior that every lab procedure in the app
% has in common by adding underlying component callbacks. For example, add
% a |ButtonPushedFcn| callback to the *Import Data* button that allows app
% users to select a file when they click the button.
%
%% 
% *Create Public Properties*
%
% The app needs access to certain information about each lab procedure. For
% example, to order the procedures by status, the app needs access to the
% statuses. Provide this access by creating public properties.
%
% Create these public properties for the component:  
%
% * |Title|
% * |Status|
% * |Date|
%
% Then, write code to associate the properties with the |LabProcedure|
% component appearance and behavior.
% 
% For more information, see <docid:creating_guis#mw_7d69d826-43fb-42a7-bd45-620c02eeb7eb Create Public Properties for Custom UI Components in App Designer>.
%
%% 
% *Create Public Callbacks*
%
% The app needs to execute a response when a user interacts with a lab
% procedure. For example, to update the background color of the procedure
% based on its status, the app needs to execute a response to an app user
% changing the status in the drop-down list. Provide the ability for an app
% creator to program a response to an interaction in the context of the app
% by creating event&ndash;public callback pairs.
%
% Create events with these associated public callbacks for the
% |LabProcedure| component:
%
% * |StatusChangedFcn|
% * |DateChangedFcn|
% 
% Then, write code to trigger the event and execute the callback when the
% drop-down component value changes.
% 
% For more information, see <docid:creating_guis#mw_f14de0d3-1290-4770-a058-1cb7a8ec08d2 Create Callbacks for Custom UI Components in App Designer>.
%
%% 
% *Configure Component for Use in Apps*
%
% To add the |LabProcedure| component to the *Component Library*, click the
% *Configure for Apps* button in the *Designer* tab and fill out the App
% Designer Custom UI Component Metadata dialog box.
%
% For more information, see <docid:creating_guis#mw_f591d4e6-f0ae-4d5e-a631-f5f432bbeaa4 Configure Custom UI Components for App Designer>.
%% Use the Custom UI Component in Your App
% After you create and configure your custom UI component, incorporate the
% component into your app. 
% 
% To explore the app code that
% uses the |LabProcedure| component, open the
% |LabProcedureApp_WithComponent.mlapp| file in App Designer.
%
%% 
% *Lay Out App*
%
% Replace the portions of the app layout that represent a lab procedure
% with |LabProcedure| components. Under the *Example Components (Custom)*
% section of the *Component Library*, drag the |LabProcedure| components
% onto the app canvas.
%
% Use the Property Inspector to customize the appearance of each of the
% procedures in the app. For example, update the |Title| property of each
% lab procedure.
%
%% 
% *Update App Code*
%
% Update your app code to refer to the |LabProcedure| components and to query
% and set their public properties when needed.
%
% For example, the original example app contains a helper
% function named |updateBackgroundColor|. Update this helper function code
% to change the background color of the |LabProcedure| component when its
% status changes. Because the |LabProcedure| component has a |Status| public
% property and an inherited |BackgroundColor| public property, the updated
% helper function code is simple and easy to read:
%
%  function updateBackgroundColor(app,lp)
%      switch lp.Status
%          case "Not started"
%              lp.BackgroundColor = [0.94 0.94 0.94];
%          case "Running"
%              lp.BackgroundColor = [0.76 0.84 0.87];
%          case "Succeeded"
%              lp.BackgroundColor = [0.75 0.87 0.75];
%          case "Failed"
%              lp.BackgroundColor = [0.87 0.76 0.75];
%      end
%  end
%% 
% *Add Component Callbacks*
%
% Add a |StatusChangedFcn| callback to each |LabProcedure| component by
% right-clicking the component and selecting *Callbacks > Add
% StatusChangedFcn callback*. Call the |updateBackgroundColor| and
% |updateProcedureOrder| helper functions to update the app when an app
% user changes the status of a lab procedure.
%
% To run the app, click *Run*.
%%
% Copyright 2021 The MathWorks, Inc.