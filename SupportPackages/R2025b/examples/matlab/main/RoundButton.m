classdef RoundButton < matlab.ui.componentcontainer.ComponentContainer
    % Custom button with rounded corners
    properties
        Color {mustBeMember(Color, ...
            {'white','blue','red','green','yellow'})} = 'white'
        FontColor {mustBeMember(FontColor, ...
            {'black','white'})} = 'black'
        Text (1,:) char = 'Button';
    end

    properties (Access = private, Transient, NonCopyable)
        HTMLComponent matlab.ui.control.HTML
    end
    
    events (HasCallbackProperty, NotifyAccess = protected)
        % Generate a ButtonPushedFcn callback property
        ButtonPushed
    end 
    
    methods (Access=protected)
        function setup(obj)
            % Set the initial position of this component
            obj.Position = [100 100 80 40];

            % Create the HTML component
            obj.HTMLComponent = uihtml(obj, ...
                "Position",[1 1 obj.Position(3:4)], ...
                "HTMLSource",fullfile(pwd,"RoundButton.html"));
            obj.HTMLComponent.HTMLEventReceivedFcn = @(src,event) notify(obj,"ButtonPushed");
        end

        function update(obj)
            % Update the HTML component data
            obj.HTMLComponent.Data.Color = obj.Color;
            obj.HTMLComponent.Data.FontColor = obj.FontColor;
            obj.HTMLComponent.Data.Text = obj.Text;
            obj.HTMLComponent.Position = [1 1 obj.Position(3:4)];
        end
    end
end