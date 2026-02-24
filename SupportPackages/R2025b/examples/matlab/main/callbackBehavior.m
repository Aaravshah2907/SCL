function callbackBehavior
% Create the figures and grid layouts
fig1 = uifigure('Position',[400 600 500 150]);
g1 = uigridlayout(fig1,[2,2]);
fig2 = uifigure('Position',[400 100 500 400]);
g2 = uigridlayout(fig2,[3,2], ...
    'RowHeight', {'1x','1x','8x'});

% Create the label for the first figure window
lbl1 = uilabel(g1,'Text','1. Click a button to clear the axes and generate a progress dialog.');
lbl1.Layout.Column = [1 2];
lbl1.HorizontalAlignment = 'center';

% Create the buttons that create a progress dialog
interrupt = uibutton(g1, ...
    'Text','Wait (interruptible)', ...
    'Interruptible','on', ...
    'ButtonPushedFcn',@createProgressDlg);
nointerrupt = uibutton(g1, ...
    'Text','Wait (not interruptible)', ...
    'Interruptible','off', ...
    'ButtonPushedFcn',@createProgressDlg);

% Create the label for the second figure window
lbl2 = uilabel(g2,'Text','2. Click a button to plot some data.');
lbl2.Layout.Column = [1 2];
lbl2.HorizontalAlignment = 'center';

% Create the axes
ax = uiaxes(g2);
ax.Layout.Row = 3;
ax.Layout.Column = [1 2];

% Create the buttons to plot data
queue = uibutton(g2, ...
    'Text','Plot (queue)', ...
    'BusyAction','queue', ...
    'ButtonPushedFcn',@(src,event)surf(ax,peaks(35)));
queue.Layout.Row = 2;
queue.Layout.Column = 1;

cancel = uibutton(g2, ...
    'Text','Plot (cancel)', ...
    'BusyAction','cancel', ...
    'ButtonPushedFcn',@(src,event)surf(ax,peaks(35)));
cancel.Layout.Row = 2;
cancel.Layout.Column = 2;

    % Callback function to create and update a progress dialog
    function createProgressDlg(src,event)
        % Clear axes
        cla(ax,'reset')
        % Create the dialog
        dlg = uiprogressdlg(fig1,'Title','Please Wait',...
        'Message','Loading...');
        steps = 250;
        for step = 1:steps 
            % Update progress
            dlg.Value = step/steps;
            pause(0.01)
        end
        close(dlg)
    end
end


