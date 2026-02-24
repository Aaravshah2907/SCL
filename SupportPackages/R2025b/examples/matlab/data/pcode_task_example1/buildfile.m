function plan = buildfile
import matlab.buildtool.tasks.PcodeTask

% Create a plan with no tasks
plan = buildplan;

% Add a task to create P-code files
plan("pcode") = PcodeTask("source","output",PreserveSourceFolder=true);
end