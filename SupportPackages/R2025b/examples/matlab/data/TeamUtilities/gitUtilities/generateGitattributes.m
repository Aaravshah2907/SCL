function generateGitattributes(gitattributesPath)
    % Define the content of the .gitattributes file
    gitattributesContent = {
        '# Auto detect text files and perform LF normalization'
        '* text=auto'
        ''
        '# Custom for MATLAB'
        '*.fig binary'
        '*.mat binary'
        '*.mdl binary diff merge=mlAutoMerge'
        '*.mdlp binary'
        '*.mex* binary'
        '*.mlapp binary'
        '*.mldatx binary'
        '*.mlproj binary'
        '*.mlx binary'
        '*.p binary'
        '*.sfx binary'
        '*.sldd binary'
        '*.slreqx binary merge=mlAutoMerge'
        '*.slmx binary merge=mlAutoMerge'
        '*.sltx binary'
        '*.slxc binary'
        '*.slx binary merge=mlAutoMerge'
        '*.slxp binary'
        ''
        '# Other common binary file'
        '*.docx binary'
        '*.exe binary'
        '*.jpg binary'
        '*.pdf binary'
        '*.png binary'
        '*.xlsx binary'
        ''
        '# Exclusions for Git LFS (Large File Storage)'
        '#*.data filter=lfs diff=lfs merge=lfs -text'
    };

    % Create and populate the .gitattributes file
    writelines(gitattributesContent, fullfile(gitignorePath,'.gitattributes'));

    % Display a message
    disp('.gitattributes file has been created successfully.');
end