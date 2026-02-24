function runMyTests(~)
results = runtests(IncludeSubfolders=true,OutputDetail="terse");
generateHTMLReport(results,"artifacts")
assertSuccess(results);
end