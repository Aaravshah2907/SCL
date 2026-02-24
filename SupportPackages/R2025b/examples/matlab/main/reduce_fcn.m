function TT = reduce_fcn(t)
[groups,Y] = findgroups(t.Year);
D = splitapply(@mean, t.MeanDelay, groups);

TT = table(Y,D,'VariableNames',{'Year' 'MeanDelay'});
end