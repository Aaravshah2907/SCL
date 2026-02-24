%% Plot Multiple Sets of Data on Each Side
% Plot two lines against the left _y_-axis by using the |hold on|
% command.

x = linspace(0,10);
yl1 = sin(x);
yl2 = sin(x/2);
yyaxis left
plot(x,yl1)
hold on 
plot(x,yl2)

%%
% Plot two lines against the right _y_-axis. The |hold| command affects
% both the left and right _y_-axes, so you do not need to reissue it. After
% plotting, turn |hold| back off.
yr1 = x;
yr2 = x.^2;
yyaxis right
plot(x,yr1)
plot(x,yr2)
hold off

%%
% Clear the left side by making it active and then using the
% |cla| command.

yyaxis left
cla



%% 
% Copyright 2012 The MathWorks, Inc.