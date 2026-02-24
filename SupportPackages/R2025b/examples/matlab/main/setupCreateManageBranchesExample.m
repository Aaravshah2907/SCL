exampleFolder = pwd;

repoRoot = fileparts(exampleFolder);
gitRepoLocation = fullfile(repoRoot,"repositories","CreateAndManageGitBranchesExample");
counter = 1;

while exist(gitRepoLocation,"dir")
    name = "CreateAndManageGitBranchesExample"+string(counter);
    gitRepoLocation = fullfile(repoRoot,"repositories",name);
    counter = counter + 1;
end

matlab.internal.project.example.createWorkingCopy(gitRepoLocation, fullfile(exampleFolder,"TeamUtilities"),"git");
matlab.internal.project.example.addAndCommitAllFiles(fullfile(exampleFolder,"TeamUtilities"), "Initial check-in");

exampleRepo = gitrepo(fullfile(exampleFolder,"TeamUtilities"));

writelines("Questions?",fullfile(exampleFolder,"TeamUtilities","README.md"));
add(exampleRepo,exampleRepo.UntrackedFiles);
commit(exampleRepo,Message="Add README file");

push(exampleRepo,Remote="origin",RemoteBranch=exampleRepo.CurrentBranch.Name)

fileattrib("TeamUtilities",'+w','','s')