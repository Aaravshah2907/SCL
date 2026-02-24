function simpleSum(a,b)
%#codegen
assert(all(size(a) ==1));
assert(isa(a,'double'));
assert(all(size(b) ==1));
assert(isa(b,'double'));
c = a + b;
fprintf('%f + %f = %f\n',a,b,c);
end