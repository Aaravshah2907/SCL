function Y = Afunction(flag,X)
n = size(X,1);
Am = magic(n);
switch flag
    case "real"
        Y = isreal(Am);
    case "notransp"
        Y = Am*X;
    case "transp"
        Y = Am'*X;
end
end