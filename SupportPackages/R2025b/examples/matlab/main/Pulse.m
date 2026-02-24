classdef Pulse < handle
    %PULSE Store pulse data and generate pulse waveform

    properties
        Type
        Frequency
        Length
        Edge 
        Window
        Modulation
        LowPass
        HighPass
        Dispersion
    end

    properties (Constant)
        StartFrequency = 10;
        StopFrequency = 20;
    end

    methods
        function result = generatePulse(obj)
            
            type = obj.Type;
            frequency = obj.Frequency;
            signalLength = obj.Length;
            edge = obj.Edge;
            window = obj.Window;
            modulation = obj.Modulation;
            lowpass = obj.LowPass;
            highpass = obj.HighPass;
            dispersion = obj.Dispersion;
            
            startFrequency = obj.StartFrequency;
            stopFrequency = obj.StopFrequency;
            
            t = -signalLength/2:1/frequency:signalLength/2;
            sig = (signalLength/(8*edge))^2;
            
            switch type
                case 'gaussian'
                    y = exp(-(t).^2/sig) ;
                case 'sinc'
                    x = 2*pi*edge*50.*t/(5*signalLength) ;
                    y = sin(x)./x ;
                    y(x==0) = 1 ;
                case 'square'
                    y = (t > -signalLength/edge/2) & (t < signalLength/edge/2) ;
                case 'triangle'
                    y = (t + signalLength/edge/2).*(t < 0) - (t - signalLength/edge/2).*(t >= 0);
                    y(y < 0) = 0 ;
                case 'monocycle'
                    if (sig == 0)
                        y = t ;
                    else
                        y = 2*t./sig.*exp(-(t).^2/sig) ;
                    end
                case 'exponential'
                    y = exp(-t*8*edge/signalLength) ;
                    y(t<0) = 0 ;
                case 'biexponential'
                    y = exp(-abs(t)*8*edge/signalLength) ;
                case 'mexican hat'
                    z = t./sqrt(0.75*sig);
                    y = sqrt(1/2*pi).*(1-z.^2).*exp(-z.^2/2) ;
                case 'raised cosine'
                    rb = 2*edge*50/(5*signalLength);
                    x = pi.*t.*rb ;
                    y = sin(x)./x ;
                    y(x==0) = 1 ;
                    y = y.*(cos(2*pi*rb.*t)./(1 - (4*rb.*t).^2));
                case 'double sinc'
                    x1 = 2*stopFrequency*pi.*t ;
                    x2 = 2*startFrequency*pi.*t ;
                    y1 = sin(x1)./x1 ;
                    y1(x1==0) = 1 ;
                    y2 = sin(x2)./x2 ;
                    y2(x2==0) = 1 ;
                    y = stopFrequency*y1 - startFrequency*y2;
                case 'sinc squared'
                    x = 2*pi*edge*16.*t/(5*signalLength) ;
                    y = sin(x)./x ;
                    y(x==0) = 1 ;
                    y = y.^2 ;
                case 'sweep'
                    theta = startFrequency.*(t + signalLength/2) + ...
                        ((stopFrequency - startFrequency)/(signalLength)).*(t+signalLength/2).^2;
                    y = real(exp(1j*(2*pi.*theta - pi/2)));
            end
            
            if (lowpass < 1) || (highpass > 0) || (dispersion ~= 0)
                c = length(y) ;
            end
            
            s = fft(y);
            sA = abs(s);
            sP = angle(s);
            if (lowpass < 1)
                cP = ceil(lowpass*c/2);
                if (cP == 0)
                    sA(:) = 0;
                else
                    sA(cP:end-cP+2) = 0;
                end
            end
            
            if (highpass > 0)
                cP = floor(highpass*c/2);
                if (cP ~= 0)
                    sA(1:cP) = 0;
                    sA(end-cP+2:end) = 0;
                end
            end
            
            if (dispersion ~= 0)
                pp = dispersion.*linspace(0,2*pi,c);
                sP = sP + pp;
            end
            s2 = sA.*cos(sP) + 1j*sA.*sin(sP);
            y = real(ifft(s2));
            
            if (window > 0)
                c = length(y);
                w = ones(size(y));
                p1 = floor(c*window/2);
                % Window is defined in three sections: taper, constant, taper
                w(1:p1+1) = (-cos((0:p1)/p1*pi)+1)/2;
                w(end-p1:end) = (cos((0:p1)/p1*pi)+1)/2;
                y=w.*y;
            end
            
            if modulation ~= 0
                y = y.*cos(pi*t*modulation);
            end
            result = y./max(abs(y)) ;       
        end
    end
end