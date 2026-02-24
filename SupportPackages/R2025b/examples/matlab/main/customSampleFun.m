function [mean_ms,speed] = customSampleFun(S)
threshold_ms = 100;
mean_ms = mean(S)*1e3;
if mean_ms < threshold_ms
    speed = 'fast';
else
    speed = 'slow';
end
end