%% Produce Failure When Callback Runs
% You can use |verifyFail| to make sure that a piece of code does not run
% in certain conditions. For example, by placing a call to |verifyFail|
% within a callback method, an undesired attempt to run the callback
% results in a verification failure.

% Copyright 2020 The MathWorks, Inc.

%%
% In a file in your current folder, create a handle class with an event.
%
% <include>MyHandle.m</include>
%
%%
% In your current folder, create the |ListenerTest| class. Add code to
% create an event source, a listener for the event, and a helper method
% that serves as the listener callback. Then, add two |Test| methods to
% test callback behavior when the event is triggered.
%
% <include>ListenerTest.m</include>
%
%%
% Run the tests. |passingTest| disables the listener and then triggers the
% event. Therefore, the callback does not run, and the test passes.
% However, when |failingTest| triggers the event, |forbiddenCallback| runs,
% resulting in a failure that is produced by |verifyFail|.
%%
runtests("ListenerTest")
