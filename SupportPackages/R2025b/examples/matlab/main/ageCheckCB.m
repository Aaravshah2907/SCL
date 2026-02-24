function ageCheckCB(src,event)
if (event.Indices(2) == 2 && ...                  % check if column 2
      (event.NewData < 0 || event.NewData > 120))
   tableData = src.Data;
   tableData{event.Indices(1),event.Indices(2)} = event.PreviousData;
   src.Data = tableData;                              % revert the data
   warning('Age must be between 0 and 120.')          % warn the user
end
