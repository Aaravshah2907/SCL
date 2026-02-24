function collectData(src,evt)
    % Read received data and store it in UserData property on bluetooth
    % object
    src.UserData = [src.UserData; read(src,src.BytesAvailableFcnCount)];
end

