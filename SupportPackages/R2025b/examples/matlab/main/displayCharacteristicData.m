function displayCharacteristicData(src,evt)
    [data,timestamp] = read(src,'oldest');
    disp(data);
    disp(timestamp);
end