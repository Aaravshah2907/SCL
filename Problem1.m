syms x

f = @(x) x.^4 - 4*x.^3 - 2*x.^2 + 12*x;

df = diff(f,x);
ddf = diff(df, x);

dfsolve = solve(df, {x});

ddf_crit_vals = subs(ddf, {x}, dfsolve);

num_crit_points = length(dfsolve);

for i = 1:num_crit_points
    if ddf_crit_vals(i) > 0
        fprintf("Critical Point %.6f is a local minima\n", dfsolve(i));
    elseif ddf_crit_vals(i) < 0
        fprintf("Critical Point %.6f is a local maxima\n", dfsolve(i));
    else
        fprintf("Critical Point %.6f is a saddle point\n", dfsolve(i));
    end
end

xvals = -3:0.01:6;
fvals = subs(f,{x},xvals);

xtitle = "x values";
ytitle = "f(x) values";
axis.title = 'Something';
axis.xlabel = xtitle;
axis.ylabel = ytitle;
plot(xvals, fvals);