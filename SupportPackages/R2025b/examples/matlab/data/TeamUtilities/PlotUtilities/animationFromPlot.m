function animationFromPlot(hPlot, numFrames, videoFilename)
    % Check if the handle is valid and if it's a plot
    if ~ishandle(hPlot) || ~strcmp(get(hPlot, 'Type'), 'line')
        error('The first input must be a handle to a line plot.');
    end

    % Get the axes handle from the plot
    ax = get(hPlot, 'Parent');

    % Preallocate the struct for storing frames if you want to save the animation
    frames(numFrames) = struct('cdata',[],'colormap',[]);

    % Animation loop
    for k = 1:numFrames
        % Update the data of the plot
        x = get(hPlot, 'XData');
        y = sin(x - 0.1*k); % Shift the sine wave
        set(hPlot, 'YData', y);
        
        % Refresh the plot
        drawnow;
        
        % Capture the frame for the animation
        frames(k) = getframe(ax);
    end

    % Save the animation as a video file
    videoFile = VideoWriter(videoFilename, 'MPEG-4');
    open(videoFile);
    writeVideo(videoFile, frames);
    close(videoFile);
end


% Example usage of the animationFromPlot function
  %x = linspace(0, 2*pi, 100);
  %y = sin(x);
  %hFig = figure;
  %hPlot = plot(x, y, 'LineWidth', 2);

% Call the function to create the animation
  %numFrames = 100; % Number of frames in the animation
  %videoFilename = 'sineWaveAnimation'; % Name of the output video file
  %animationFromPlot(hPlot, numFrames, videoFilename);

% Close the figure
  %close(hFig);