function evaluateHandle(fh,x)

y = fh(x);
str = func2str(fh);

disp('For input value: ')
disp(x)
disp(['The function ' str ' evaluates to:'])
disp(y)

end