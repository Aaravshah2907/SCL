function y = add5(x)
% add5 - Increment input by 5
if ~isa(x,"numeric")
    error("add5:InputMustBeNumeric","Input must be numeric.")
end
y = x + 5;
end