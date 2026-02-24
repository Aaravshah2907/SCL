function Tout = tableDiff(Tin)
d = Tin.Var2 - Tin.Var1;
Tin.Var3 = abs(d);
Tout = Tin;
end