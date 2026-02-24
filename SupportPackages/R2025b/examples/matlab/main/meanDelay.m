function D = meanDelay(a,b)
X = [a b];
Y = sum(X,2,'omitnan');
D = mean(Y);
end