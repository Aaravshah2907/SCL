function t = transform_fcn(a,b,c)
ii = gather(unique(c));

for k = 1:length(ii)
    jj = (c == ii(k));
    d = mean([a(jj) b(jj)], 2);
    
    if k == 1
        t = table(c(jj),d,'VariableNames',{'Year' 'MeanDelay'});
    else
        t = [t; table(c(jj),d,'VariableNames',{'Year' 'MeanDelay'})];
    end
end

end