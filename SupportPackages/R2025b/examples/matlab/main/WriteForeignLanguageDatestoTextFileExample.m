%% Write Foreign-Language Dates to Text File  
% Convert English dates in a table to German and write the table to file.   

%% 
% Create a table that contains a |datetime| array with dates in English.
% Create column vectors of numeric data to go with the dates. 
D = datetime({'01-Jan-2014';'01-Feb-2014';'01-Mar-2014'});
D.Format = 'dd MMMM yyyy';
X1 = [20.2;21.6;20.7];
X2 = [100.5;102.7;99.8];
T = table(D,X1,X2)  

%% 
% Write the table to a text file. Specify German for the locale of the dates
% using the |DateLocale| name-value pair argument, and display the dates
% in the text file. 
writetable(T,'myfile.txt','DateLocale','de_DE');
type myfile.txt   



%% 
% Copyright 2012 The MathWorks, Inc.