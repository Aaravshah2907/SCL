function vals = HeunMethod(f,h,a,b,x0,y0)
    number_of_iterations = ceil((b-a)/h);
    x=x0;y=y0;
    vals = zeros(number_of_iterations+1,1);
    vals(1)=y0;
    for k = 2 : number_of_iterations+1
        k1 = f(x,y);
        k2 = f(x+h, y+h*k1);
        x = x + h;
        y = y + h*(k1+k2)/2;
        vals(k) = y;
        fprintf("At iteration %d, xval is %0.6f, yval is %0.6f\n",k-1,x,y);
    end

end