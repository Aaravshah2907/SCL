classdef DisplayImage < matlab.task.LiveTask
    properties(Access = private,Transient)
        FileNameEditField           matlab.ui.control.EditField
        BrowseButton                matlab.ui.control.Button
    end

    properties(Dependent)
        State
        Summary
    end

    methods(Access = protected)
        function setup(task)
            createComponents(task);
            setComponentsToDefault(task);
        end
    end

    methods
        function [code,outputs] = generateCode(task)
            if isempty(task.FileNameEditField.Value)
                % Return empty values if there is not enough
                % information to generate code
                code = "";
                outputs = {};
                return
            end
            
            outputs = {"im"};
            code = ["% Get Image"
                outputs{1} + " = imread(""" + ...
                task.FileNameEditField.Value + """);"
                ""
                "% Visualize results"
                "figure"          
                "imshow(" + outputs{1} + ");"];
        end
        
        function summary = get.Summary(task)
            if isempty(task.FileNameEditField.Value)
                summary = "Display selected image";
            else
                [~,name,~] = fileparts(task.FileNameEditField.Value);
                summary = "Display image '" + name + "'";
            end
        end

        function state = get.State(task)
            state = struct;
            state.FileNameEditFieldValue = task.FileNameEditField.Value;
        end

        function set.State(task,state)
            task.FileNameEditField.Value = state.FileNameEditFieldValue; 
        end
        
        function reset(task)
            setComponentsToDefault(task);
        end
    end

    methods(Access = private)
        function createComponents(task)
            task.LayoutManager.RowHeight = ["fit" "fit" "fit"]; 
            task.LayoutManager.ColumnWidth = "fit";

            % Row 1: Select image section label
            uilabel(task.LayoutManager,"Text","Select image", ...
                "FontWeight","bold");

            % Row 2: Select data section components
            inputgrid = uigridlayout(task.LayoutManager,"RowHeight", ...
                "fit","ColumnWidth",{"fit",200,"fit"},"Padding",0);
            uilabel(inputgrid,"Text","Input image");
            task.FileNameEditField = uieditfield(inputgrid, ...
                "Editable",false);            
            task.BrowseButton = uibutton(inputgrid,"Text","Browse", ...
               "ButtonPushedFcn",@task.inputImageFile);
            
            % Row 3: Display results section label
            uilabel(task.LayoutManager,"Text","Display results", ...
                "FontWeight","bold");
        end

        function setComponentsToDefault(task)
            task.FileNameEditField.Value = "";    
        end

        function inputImageFile(task,~,~)
            % Display uigetfile dialog box
            filterspec = ["*.jpg;*.tif;*.png;*.gif","All Image Files"];
            [f,p] = uigetfile(filterspec);
            
            % Make sure user did not cancel uigetfile dialog box
            if (ischar(p))
               fileName = [p f];
               task.FileNameEditField.Value = fileName;
            end
            
            notify(task,"StateChanged");
        end
    end
end