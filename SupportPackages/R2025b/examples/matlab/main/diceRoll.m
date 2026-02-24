function [d1,d2] = diceRoll
str = '@()randi([1 6],1)';
d1 = str2func(str);
d2 = eval(str);
end

function r = randi(~,~)
r = 1;
end