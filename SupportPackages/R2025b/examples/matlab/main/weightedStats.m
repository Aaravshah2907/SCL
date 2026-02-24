function [wvar, wstd] = weightedStats(X, P)
  wvar = var(X,P);
  wstd = std(X,P);
end