exampleFolder = pwd;

repoRoot = fileparts(exampleFolder);
folderForRepos = fullfile(repoRoot,"repositories");
svnRepoLocation = fullfile(repoRoot,"repositories","WorkWithFilesUnderSVNInMATLABExample");
counter = 1;

if ~exist(folderForRepos, "dir")
    mkdir(folderForRepos)
end


while exist(svnRepoLocation,"dir")
    name = "WorkWithFilesUnderSVNInMATLABExample"+string(counter);
    svnRepoLocation = fullfile(repoRoot,"repositories",name);
    counter = counter + 1;
end

matlab.internal.project.example.createWorkingCopy(svnRepoLocation, fullfile(exampleFolder,"TeamUtilities"),"svn");
matlab.internal.project.example.addAndCommitAllFiles(fullfile(exampleFolder,"TeamUtilities"), "Initial check-in");