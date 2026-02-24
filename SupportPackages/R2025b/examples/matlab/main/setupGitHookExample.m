localrepo = gitinit(pwd);

% Name of file to create
filename = 'saveUnsavedMFiles.m';

% Define the content for each part
content = [
    "% Get a list of all open documents in the MATLAB Editor"
    "editorDocuments = matlab.desktop.editor.getAll;"

    "% Check each document to see if it is unsaved"
    "for i = 1:length(editorDocuments)"
    "    doc = editorDocuments(i);"
    "    if doc.Modified % If the document has unsaved changes,"
    "        unsavedFileName = fullfile(pwd,doc.Filename);"
    "        % Save the unsaved document in the same document"
    "        doc.saveAs(unsavedFileName);"
    "    end"
    "end"
    ""
    "disp('Saved all unsaved changes in files open in the MATLAB editor.')";
    ""
    "%Copyright 2024 The MathWorks, Inc.";
];  
 
 % Create the saveUnsavedMFiles file
 writelines("% TODO add utility to save files with unsaved changes",filename);

 % Add the file to the repository and commit
 add(localrepo,filename);

 commit(localrepo, Message="feat: Add auxiliary files");

 writelines(content, filename, WriteMode="append");

 movefile("commit-msg",fullfile(".git","hooks","commit-msg"))
 movefile("pre-commit",fullfile(".git","hooks","pre-commit"))
 movefile("prepare-commit-msg",fullfile(".git","hooks","prepare-commit-msg"))


