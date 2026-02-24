%% View Information About Spreadsheet File  

%% 
% Create a sample Excel(R) file named |myExample.xlsx|. 
values = {1, 2, 3 ; 4, 5, 'x' ; 7, 8, 9};
headers = {'First', 'Second', 'Third'};
xlswrite('myExample.xlsx', [headers; values]);  

%% 
% Call |xlsfinfo| to get information about the file. 
[status,sheets,xlFormat] = xlsfinfo('myExample.xlsx') 

%%
% |status| contains descriptive text which indicates that the |xlsread|
% function can read the sample file.   



%% 
% Copyright 2012 The MathWorks, Inc.