function generateGitignore(gitignorePath)
    % Define the content of the .gitignore file
    gitignoreContent = {
        '# Autosave files'
        '*.asv'
        '*.m~'
        '*.autosave'
        '*.slx.r*'
        '*.mdl.r*'
        
        '# Derived content-obscured files'
        '*.p'
        ''
        '# Compiled MEX files'
        '*.mex*'
        ''
        '# Packaged app and toolbox files'
        '*.mlappinstall'
        '*.mltbx'
        ''
        '# Deployable archives'
        '*.ctf'
        ''
        '# Generated helpsearch folders'
        'helpsearch*/'
        ''
        '# Code generation folders'
        'slprj/'
        'sccprj/'
        'codegen/'
        ''
        '# Cache files'
        '*.slxc'
        ''
        '# Cloud based storage dotfile'
        '.MATLABDriveTag'
        ''
        '# User-specific files or non-MATLAB files'
        '*.py'
        '*.zip'
        ''
        '# User-specific logs'
        'build.log'
        'pipeline.txt'
    };

    % Create and populate the .gitignore file
    writelines(gitignoreContent, fullfile(gitignorePath,'.gitignore'));

    % Display a message
    disp('.gitignore file for MATLAB has been created successfully.');
end