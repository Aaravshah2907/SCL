localrepo = gitinit(pwd);

% Define the file to be modified
filename = 'saveUnsavedMFiles.m';

% Define the content for each part
part1 = [
    "% Get a list of all open documents in the MATLAB Editor"
    "editorDocuments = matlab.desktop.editor.getAll;"
];

part2 = [
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

part3 = [
    "disp('Saved all unsaved changes in files open in the MATLAB editor.')"
];

 % Create the saveUnsavedMFiles file
 writelines("% Utility to save files with unsaved changes",filename);
    
 commit(localrepo, Message="Add auxiliary files");
 % Add the file to the repository and commit
 add(localrepo,"saveUnsavedMFiles.m");

% Function to write content to the script file
function writeAndCommit(repo, filename, content, commitMessage)
    
	writelines(content, filename, WriteMode="append");
	
    % Commit the change with a descriptive message
    commit(repo, Message = commitMessage);
end

% Write part 1 and commit
writeAndCommit(localrepo, filename, part1, 'Part 1 of the saveUnsavedMFiles utility');

% Write part 2 and commit
writeAndCommit(localrepo, filename, part2, 'Part 2 of the saveUnsavedMFiles utility');

% Write part 3 and commit
writeAndCommit(localrepo, filename, part3, 'Part 3 of the saveUnsavedMFiles utility')