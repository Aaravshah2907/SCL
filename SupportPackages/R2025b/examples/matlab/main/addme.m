function c = addme(a,b)
    switch nargin
        case 2
            c = a + b;
        case 1
            c = a + a;
        otherwise
            c = 0;
    end
end