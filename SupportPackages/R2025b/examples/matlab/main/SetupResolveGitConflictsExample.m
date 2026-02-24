exampleFolder = pwd;

repoRoot = fileparts(exampleFolder);
gitRepoLocation = fullfile(repoRoot,"repositories","ResolveGitConflictsExample");
counter = 1;

while exist(gitRepoLocation,"dir")
    name = "ResolveGitConflictsExample"+string(counter);
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

% Commit Theirs changes.
createConflict(exampleRepo,fullfile(exampleFolder,"TeamUtilities","README.md"));

%% Local functions

function doTheirsEdit(filename)
    writelines("Contact example@mailinglist.com",filename,WriteMode="append");
end

function doMineEdit(filename)
    writelines("Post on the forum.",filename,WriteMode="append");
end

function createConflict(repo,filename)
    % Create conflicts in file
    originalBranch = repo.CurrentBranch;
    createBranch(repo,"readmeBranch");
    doTheirsEdit(filename);
    commit(repo, Message = "Add contact info",Files=repo.ModifiedFiles);
    push(repo);
    switchBranch(repo,"readmeBranch");
    doMineEdit(filename);
    commit(repo, Message = "Update readme");
    switchBranch(repo,originalBranch);

    try
        merge(repo,"readmeBranch"); % Merge readmeBranch with initial branch called main, trunk, etc.
    catch ME
        if (strcmp(ME.identifier,'shared_cmlink:git:MergeFailed'))
            % An exception is expected because this branch merge
            % results in a conflict
        else
            rethrow(ME)
        end
    end
end