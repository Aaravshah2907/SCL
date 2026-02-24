% Get a list of all open documents in the MATLAB Editor
editorDocuments = matlab.desktop.editor.getAll;

% Check each document to see if it is unsaved
for i = 1:length(editorDocuments)
    doc = editorDocuments(i);
    if doc.Modified % If the document has unsaved changes,
        unsavedFileName = fullfile(pwd,doc.Filename);
        % Save the unsaved document in the same document
        doc.saveAs(unsavedFileName);
    end    
end
disp('Saved all unsaved changes in files open in the MATLAB editor.')
