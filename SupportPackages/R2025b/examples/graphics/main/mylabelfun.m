function labels = mylabelfun(vals)
feetPerMeter = 3.28084;
feet = round(vals.*feetPerMeter);
labels = vals + " m (" + feet + " ft)";
labels(vals == 0) = "0 m";
end