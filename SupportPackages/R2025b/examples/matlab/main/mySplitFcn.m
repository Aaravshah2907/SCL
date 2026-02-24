function T = mySplitFcn(a,b,c)
T = matlab.tall.reduce(@non_group_transform_fcn, @non_group_reduce_fcn, ...
    a, b, c, 'OutputsLike', {non_group_transform_fcn(0,0,0)});

    function t = non_group_transform_fcn(a,b,c)
        d = mean([a b], 2);
        t = table(c,d,'VariableNames',{'Year' 'MeanDelay'});
    end

    function TT = non_group_reduce_fcn(t)
        D = mean(t.MeanDelay);
        TT = table(t.Year(1),D,'VariableNames',{'Year' 'MeanDelay'});
    end

end
