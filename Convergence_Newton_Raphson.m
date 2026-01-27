function conv_vals = Convergence_Newton_Raphson(errors)

    n = numel(errors);
    conv_vals = zeros(1, n-1);
    
    for k = 1:n-1
        if abs(errors(k)) < eps
            conv_vals(k) = 0;
        else
            conv_vals(k) = errors(k+1) / (errors(k)*errors(k));
        end
    end
    
end
