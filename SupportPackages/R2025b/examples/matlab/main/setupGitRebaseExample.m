localrepo = gitinit(pwd);

% Define the file to be modified
filenameSaveUtility = 'saveUnsavedMFiles.m';
filenameCleanupUtility = 'cleanup.m';

% Define the content for each part
part1 = [
    "% Get a list of all open documents in the MATLAB Editor"
    "editorDocuments = matlab.desktop.editor.getAll;"
];

part2 = [
    "% Check each document to see if it is unsaved"
    "for i = 1:length(editorDocuments"
    "    doc = editorDocuments(i);"
    "    if doc.Modified % If the document has unsaved changes,"
    "        unsavedFileName = fullfile(pwd,doc.Filename);"
    "        % Save the unsaved document in the same document"
    "        doc.saveas(unsavedFileName);"
    "    end"
    "end"
];
part2Fix1 = [
    "% Check each document to see if it is unsaved"
    "for i = 1:length(editorDocuments)"
    "    doc = editorDocuments(i);"
    "    if doc.Modified % If the document has unsaved changes,"
    "        unsavedFileName = fullfile(pwd,doc.Filename);"
    "        % Save the unsaved document in the same document"
    "        doc.saveas(unsavedFileName);"
    "    end"
    "end"
];
part2Fix2 = [
    "% Check each document to see if it is unsaved"
    "for i = 1:length(editorDocuments)"
    "    doc = editorDocuments(i);"
    "    if doc.Modified % If the document has unsaved changes,"
    "        unsavedFileName = fullfile(pwd,doc.Filename);"
    "        % Save the unsaved document in the same document"
    "        doc.saveAs(unsavedFileName);"
    "    end"
    "end"
];

part3 = "disp('Saved all unsaved changes in files open in the MATLAB editor.')";

part4 = "%Copyright 2024 The MathWorks, Inc.";

part5 = [
    % clear workspace variables"
    "clc"
    "disp('clearing workspace & functions...')"
    "clear"
    " "
    "% close mex from memory"
    "disp('Clearing mex...')"
    "clear mex"
];    

part6 = [
    "% close figures"
    "disp('Closing figures...')"
    "close all"
    " "
    "% close all open files in MATLAB editor"
    "disp('Closing all open files in MATLAB editor')"
    "closeNoPrompt(matlab.desktop.editor.getAll);"
    " "
    "% close open projects"
    "try"
    "    proj = currentProject();"
    "    disp('closing open projects...')"
    "    close(proj)"
	"    clear proj"
    "catch"
    "    disp('No project open.')"
    "end"
];  

part7 = [
    "disp('cleanup complete')"
    "pause(1)"
    "home"
];

 % Create the saveUnsavedMFiles file
 writelines("% Utility to save files with unsaved changes",filenameSaveUtility);
    
 commit(localrepo, Message="Add auxiliary files");
 % Add the file to the repository and commit
 add(localrepo,filenameSaveUtility);

% Function to write content to the script file
function writeAndCommit(repo, filename, content, commitMessage)
    
	writelines(content, filename, WriteMode="append");
	
    % Commit the change with a descriptive message
    commit(repo, Message = commitMessage);
end

% Write part 1 and commit
writeAndCommit(localrepo, filenameSaveUtility, part1, 'Part 1 of the saveUnsaveFiles utility');

% Write part 2 and commit
writeAndCommit(localrepo, filenameSaveUtility, part2, 'Part 2 of the saveUnsaveFiles utility');

% Create Feature branch but do not switch
createBranch(localrepo,"Feature");

% Write part 3 and commit
writeAndCommit(localrepo, filenameSaveUtility, part3, 'Print message when files saved successfully');

% Write part 4 and commit
writeAndCommit(localrepo, filenameSaveUtility, part4, 'Add copyright');

% Switch to Feature
switchBranch(localrepo,"Feature");

% Write first commit in Feature branch
 writelines("% Utility to cleanup session",filenameCleanupUtility);
 add(localrepo,filenameCleanupUtility);
 writeAndCommit(localrepo, filenameCleanupUtility, part5, 'Create new cleanup utility');

 % Create BugFix branch but do not switch
createBranch(localrepo,"BugFix");

% Write second commit in Feature branch
 writeAndCommit(localrepo, filenameCleanupUtility, part6, 'Add project cleanup to cleanup utility');
 
 % Write third commit in Feature branch
 writeAndCommit(localrepo, filenameCleanupUtility, part7, 'Add display message when successful');

 % Switch to BugFix
switchBranch(localrepo,"BugFix");

% Rewrite over the filenameSaveUtility
writelines("% Utility to save files with unsaved changes",filenameSaveUtility);
writelines(part1,filenameSaveUtility, WriteMode="append");
writelines(part2Fix1,filenameSaveUtility, WriteMode="append");
writelines(part3,filenameSaveUtility, WriteMode="append");
writelines(part4,filenameSaveUtility, WriteMode="append");
commit(localrepo, Message= "Fix missing bracket");

% Rewrite over the filenameSaveUtility
writelines("% Utility to save files with unsaved changes",filenameSaveUtility);
writelines(part1,filenameSaveUtility, WriteMode="append");
writelines(part2Fix2,filenameSaveUtility, WriteMode="append");
writelines(part3,filenameSaveUtility, WriteMode="append");
writelines(part4,filenameSaveUtility, WriteMode="append");
commit(localrepo, Message= "Saveas -> SaveAs");