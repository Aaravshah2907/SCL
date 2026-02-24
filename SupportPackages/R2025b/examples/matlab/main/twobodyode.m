function dy = twobodyode(t,y)
% Two body problem with one mass much larger than the other.
r = sqrt(y(1)^2 + y(3)^2);
dy = [y(2); 
    -y(1)/r^3;
    y(4);
    -y(3)/r^3];