function numericValidationFcn(x)
    errorMsg = 'Value must be numeric.'; 
    assert(isnumeric(x),errorMsg);
end