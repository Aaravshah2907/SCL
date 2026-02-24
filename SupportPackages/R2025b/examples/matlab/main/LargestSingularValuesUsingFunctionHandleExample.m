%% Largest Singular Values Using Function Handle
% Create two matrices representing the upper-right and lower-left nonzero
% blocks in a sparse matrix. 
n = 500;
B = rand(500);
C = rand(500);

%%
% Save |Afun| in your current directory so that it is available for use
% with |svds|.
%
% <include>Afun.m</include>
%
% The function |Afun| uses |B| and |C| to compute either |A*x| or |A'*x|
% (depending on the specified flag) without actually forming the entire
% sparse matrix |A = [zeros(n) B; C zeros(n)]|. This exploits the sparsity
% pattern of the matrix to save memory in the computation of |A*x| and
% |A'*x|.

%%
% Use |Afun| to calculate the 10 largest singular values of |A|. Pass |B|,
% |C|, and |n| as additional inputs to |Afun|.
s = svds(@(x,tflag) Afun(x,tflag,B,C,n),[1000 1000],10)

%%
% Directly compute the 10 largest singular values of |A| to compare the
% results.
A = [zeros(n) B; C zeros(n)];
s = svds(A,10)

%% 
% Copyright 2012 The MathWorks, Inc.