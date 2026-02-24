classdef NormalizeVectorData < matlab.task.LiveTask
    properties(Access = private,Transient)
        InputDataDropDown               matlab.ui.control.DropDown
        MethodDropDown                  matlab.ui.control.DropDown
        ZscoreGrid                      matlab.ui.container.GridLayout
        ZscoreDropDown                  matlab.ui.control.DropDown
        RangeGrid                       matlab.ui.container.GridLayout
        LeftRangeSpinner                matlab.ui.control.Spinner
        RightRangeSpinner               matlab.ui.control.Spinner
        InputDataCheckBox               matlab.ui.control.CheckBox
        NormalizedDataCheckBox          matlab.ui.control.CheckBox
    end

    properties(Dependent)
        State
        Summary
    end

    methods(Access = private)
        function createComponents(task)
            g = uigridlayout(task.LayoutManager,[1,1]);
            g.RowHeight = ["fit" "fit" "fit" "fit" "fit" "fit"];
            g.ColumnWidth = "fit";

            % Row 1: Select data section label
            uilabel(g,Text="Select data",FontWeight="bold");

            % Row 2: Select data section components
            inputgrid = uigridlayout(g,RowHeight="fit", ...
                ColumnWidth=["fit","fit"],Padding=0);
            uilabel(inputgrid,Text="Input data");
            task.InputDataDropDown = uidropdown(inputgrid, ...
                ValueChangedFcn=@task.updateComponents, ...
                DropDownOpeningFcn=@task.populateWSDropdownItems);
            task.populateWSDropdownItems(task.InputDataDropDown);

            % Row 3: Specify method section label
            uilabel(g,Text="Specify method",FontWeight="bold");

            % Row 4: Method section components
            methodgrid = uigridlayout(g,RowHeight="fit", ...
                ColumnWidth=["fit","fit","fit"],Padding=0);
            uilabel(methodgrid,Text="Normalization method");
            task.MethodDropDown = uidropdown(methodgrid, ...
                ValueChangedFcn=@task.updateComponents);
            task.MethodDropDown.Items = ["Z-score" "2-Norm" ...
                "Scale by standard deviation" "Scale to new range" ...
                "Center to mean 0"];
            task.MethodDropDown.ItemsData = ["zscore" "norm" "scale" ...
                "range" "center"];

            % Subgrid 1 in method section
            task.ZscoreGrid = uigridlayout(methodgrid,RowHeight="fit", ...
                ColumnWidth=["fit","fit"],Padding=0);
            uilabel(task.ZscoreGrid,Text="Deviation type");
            task.ZscoreDropDown = uidropdown(task.ZscoreGrid, ...
                ValueChangedFcn=@task.updateComponents, ...
                Items=["Standard" "Median absolute"], ...
                ItemsData=["std" "robust"], ...
                Tooltip="Center data to 0 and scale to deviation 1");

            % Subgrid 2 in method section
            task.RangeGrid = uigridlayout(methodgrid,RowHeight="fit", ...
                ColumnWidth={"fit" 50 50},Padding=0);
            task.RangeGrid.Layout.Row = 1;
            task.RangeGrid.Layout.Column = 3;
            uilabel(task.RangeGrid,Text="Range edges");
            task.LeftRangeSpinner = uispinner(task.RangeGrid, ...
                ValueChangedFcn=@task.updateComponents, ...
                Tag="LeftRangeSpinner", ...
                Tooltip="Left edge of new range");

            task.RightRangeSpinner = uispinner(task.RangeGrid, ...
                ValueChangedFcn=@task.updateComponents, ...
                Tag="RightRangeSpinner", ...
                Tooltip="Right edge of new range");

            % Row 5: Display results section label
            uilabel(g,Text="Display results",FontWeight="bold");

            % Row 6: Display results section components
            displaygrid = uigridlayout(g,RowHeight="fit", ...
                ColumnWidth=["fit","fit"],Padding=0);
            task.InputDataCheckBox = uicheckbox(displaygrid, ...
                Text="Input data",ValueChangedFcn=@task.updateComponents);
            task.NormalizedDataCheckBox = uicheckbox(displaygrid, ...
                Text="Normalized data",ValueChangedFcn=@task.updateComponents);
        end

        function setComponentsToDefault(task)
            task.MethodDropDown.Value = "zscore";
            task.ZscoreDropDown.Value = "std";
            task.LeftRangeSpinner.Value = 0;
            task.RightRangeSpinner.Value = 1;
            task.InputDataCheckBox.Value = true;
            task.NormalizedDataCheckBox.Value = true;
        end

        function updateComponents(task,source,~)
            if nargin > 1
                if isequal(source.Tag,"LeftRangeSpinner")
                    if task.RightRangeSpinner.Value <= task.LeftRangeSpinner.Value
                        task.RightRangeSpinner.Value = task.LeftRangeSpinner.Value + 1;
                    end
                elseif isequal(source.Tag,"RightRangeSpinner")
                    if task.RightRangeSpinner.Value <= task.LeftRangeSpinner.Value
                        task.LeftRangeSpinner.Value = task.RightRangeSpinner.Value - 1;
                    end
                end
            end
            hasData = ~isequal(task.InputDataDropDown.Value,"select variable");
            task.MethodDropDown.Enable = hasData;
            task.ZscoreDropDown.Enable = hasData;
            task.LeftRangeSpinner.Enable = hasData;
            task.RightRangeSpinner.Enable = hasData;
            task.InputDataCheckBox.Enable = hasData;
            task.NormalizedDataCheckBox.Enable = hasData;
            % Show only relevant subgrids
            task.ZscoreGrid.Visible = isequal(task.MethodDropDown.Value,"zscore");
            task.RangeGrid.Visible = isequal(task.MethodDropDown.Value,"range");
            % Trigger the live editor to update the generated script
            notify(task,"StateChanged");
        end

        function populateWSDropdownItems(~,src,~)
            workspaceVariables = evalin("base","who");
            src.Items = ["select variable"; workspaceVariables];
        end
    end

    methods(Access = protected)
        function setup(task)
            createComponents(task);
            setComponentsToDefault(task);
            updateComponents(task);
        end
    end

    methods
        function [code,outputs] = generateCode(task)
            if isequal(task.InputDataDropDown.Value,"select variable")
                % Return empty values if there is not enough
                % information to generate code
                code = "";
                outputs = {};
                return
            end
            
            outputs = {'normalizedData'};
            
            inputdata = "`" + task.InputDataDropDown.Value + "`";
            if isequal(task.MethodDropDown.Value,"zscore") && ...
                    isequal(task.ZscoreDropDown.Value,"std")
                code = "normalizedData = normalize(" + inputdata + ");";    
            elseif isequal(task.MethodDropDown.Value,"zscore")
                    code = "normalizedData = normalize(" + inputdata + "," + ...
                        """zscore"",""" + task.ZscoreDropDown.Value + """);";
            elseif isequal(task.MethodDropDown.Value,"range")
                    if isequal(task.LeftRangeSpinner.Value,0) && ...
                            isequal(task.RightRangeSpinner.Value,1)
                        code = "normalizedData = normalize(" + inputdata + ...
                            ",""range"");";
                    else
                        code = "normalizedData = normalize(" + inputdata + ...
                            ",""range"",[" + task.LeftRangeSpinner.Value + "," + ...
                            task.RightRangeSpinner.Value + "]);";
                    end
            else
                code = "normalizedData = normalize(" + inputdata + ...
                    ",""" + task.MethodDropDown.Value + """);";
            end
            
            inputplotcode = "plot(" + inputdata + ",DisplayName=""Input data"")";
            outputplotcode = "plot(normalizedData,DisplayName=""Normalized data"")";
            
            if task.InputDataCheckBox.Value && task.NormalizedDataCheckBox.Value
                code = ["% Normalize data"; code; "% Display results"; ...
                    inputplotcode; "hold on"; outputplotcode; "hold off"; ...
                    "legend"];
            elseif task.InputDataCheckBox.Value
                code = ["% Normalize data"; code; "% Display results"; ...
                    inputplotcode; "legend"];
            elseif task.NormalizedDataCheckBox.Value
                code = ["% Normalize data"; code; "% Display results"; ...
                    outputplotcode; "legend"];
            else
                code = ["% Normalize data"; code];
            end                
        end
            
        function summary = get.Summary(task)
            if isequal(task.InputDataDropDown.Value,"select variable")
                summary = "Normalize vector data";
            else
                switch task.MethodDropDown.Value
                    case "zscore"
                        methodString = " using z-score";
                    case "norm"
                        methodString = " using 2-norm";
                    case "scale"
                        methodString = " using scaling by standard deviation";
                    case "range"
                        methodString = " by scaling to new range";
                    case "center"
                        methodString = " by centering the data to 0";
                end
                summary = "Normalized vector `" + task.InputDataDropDown.Value + ...
                    "`" + methodString;
            end
        end

        function state = get.State(task)
            state = struct;
            state.InputDataDropDownValue = task.InputDataDropDown.Value;
            state.MethodDropDownValue = task.MethodDropDown.Value;
            state.ZscoreDropDownValue = task.ZscoreDropDown.Value;
            state.LeftRangeSpinnerValue = task.LeftRangeSpinner.Value;
            state.RightRangeSpinnerValue = task.RightRangeSpinner.Value;
            state.InputDataCheckboxValue = task.InputDataCheckBox.Value;
            state.NormalizedDataCheckboxValue = task.NormalizedDataCheckBox.Value;
        end

        function set.State(task,state)
            value = state.InputDataDropDownValue;
            if ~ismember(value, task.InputDataDropDown.ItemsData)
                % In case the selected Input Data variable was cleared after
                % saving the mlx file and before reopening the mlx file
                task.InputDataDropDown.Items = [task.InputDataDropDown.Items value];
            end
            task.InputDataDropDown.Value = value;
            task.MethodDropDown.Value = state.MethodDropDownValue;
            task.ZscoreDropDown.Value = state.ZscoreDropDownValue;
            task.LeftRangeSpinner.Value = state.LeftRangeSpinnerValue;
            task.RightRangeSpinner.Value = state.RightRangeSpinnerValue;
            task.InputDataCheckBox.Value = state.InputDataCheckboxValue;
            task.NormalizedDataCheckBox.Value = state.NormalizedDataCheckboxValue;
            updateComponents(task);
        end
        
        function reset(task)
            setComponentsToDefault(task);
            updateComponents(task);
        end
    end
end