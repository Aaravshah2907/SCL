function [M,I] = maxDelay(A,B)
X = [A B];
[M,I] = max(X,[],2);
end