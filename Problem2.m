A = [8 -1 1; 2 10 -1; 1 -2 9];
b = [7; 8; 6];

n = length(b);
x0 = [0;0;0];

x = x0;
%maxIter = 1000;

eps = 1e-5;
err = 0;
counter = 0;
%fprintf("Executing...\n");

while true
    counter = counter + 1;
    x_new = zeros(n,1);
        
    for i = 1:n
        if A(i,i) == 0
            error('Zero diagonal element detected. Jacobi method fails.');
        end
            
        sum1 = A(i,1:i-1) * x(1:i-1);
        sum2 = A(i,i+1:n) * x(i+1:n);            
        x_new(i) = (b(i) - sum1 - sum2) / A(i,i);
    end
        
    err = norm(x_new - x, inf);
    if err < eps
        x = x_new;
        fprintf("After %d iterations, Approximate value of x is : ", counter);
        display(x);
        return
    end
        x = x_new;
end

fprintf("After %d iterations, Approximate value of x is : ", counter);
display(x);
