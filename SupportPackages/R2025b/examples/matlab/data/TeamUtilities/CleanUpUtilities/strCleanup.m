function [strOut] = strCleanup(strIn)
% clean up strings:
% remove carriage returns
strOut = strIn(strIn ~= newline &  strIn ~= char(13));
% remove propagation symbols
strOut = strrep(strOut, '<', '');
strOut = strrep(strOut, '>', '');

% remove single quote
strOut = strrep(strOut, '''', '');
% replace blanks with _
strOut = strrep(strOut,' ','_');
% replace colons with _
strOut = strrep(strOut,':','_');
% replace slash with _
strOut = strrep(strOut,'/','_');
strOut = strrep(strOut,'\','_');

% replace - with _
strOut = strrep(strOut,'-','_');

% replace [ ] with _
strOut = strrep(strOut,'[','_');
strOut = strrep(strOut,']','_');

end

