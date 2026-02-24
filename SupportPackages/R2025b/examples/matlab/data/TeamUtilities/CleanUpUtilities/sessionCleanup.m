
    % clear workspace variables
    clc
    disp('clearing workspace & functions...')
    clear
    
    % close mex from memory
    disp('Clearing mex...')
    clear mex
    
    % close figures
    disp('Closing figures...')
    close all
    
    % close all open files in MATLAB editor
    disp('Closing all open files in MATLAB editor')
    closeNoPrompt(matlab.desktop.editor.getAll);
    
    % close open projects
    try
        proj = currentProject();
        disp('closing open projects...')
        close(proj)
	    clear proj
    catch
        disp('No project open.')
    end
    
    disp('cleanup complete')
    pause(1)
    home
