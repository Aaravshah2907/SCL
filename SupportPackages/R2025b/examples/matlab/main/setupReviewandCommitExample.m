% Initialize local repository
repo = gitinit("TeamUtilities");

% Add untracked files to the repo
add(repo,repo.UntrackedFiles);

% Commit
commit(repo,Message="Initial commit");

fileattrib("TeamUtilities",'+w','','s')
cd TeamUtilities;

% Make changes
copyright = "%Copyright 2024 The MathWorks, Inc.";

writelines(copyright,fullfile("CleanUpUtilities","strCleanup.m"), WriteMode="append");
writelines(copyright,fullfile("CleanUpUtilities","saveUnsavedMFiles.m"), WriteMode="append");
writelines(copyright,fullfile("CleanUpUtilities","sessionCleanup.m"), WriteMode="append");
writelines(copyright,fullfile("gitUtilities","generateGitattributes.m"), WriteMode="append");
writelines(copyright,fullfile("gitUtilities","generateGitignore.m"), WriteMode="append");
writelines(copyright,fullfile("PlotUtilities","animationFromPlot.m"), WriteMode="append");
writelines(copyright,fullfile("PlotUtilities","standarizePlots.m"), WriteMode="append");
