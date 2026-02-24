function returnControlExample(target)
    arrayToSearch = [3 7 28 14 42 9 0];
    idx = findSqrRootIndex(target,arrayToSearch);
    
    if isnan(idx)
        disp('Square root not found.')
    else
        disp(['Square root found at index ' num2str(idx)])
    end
end