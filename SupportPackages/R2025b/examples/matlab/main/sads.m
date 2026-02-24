classdef sads
    % Sensor Array Data Set Class
    properties
        Data         % Sampled sensor data
        SampleRate   % Sample rate (Hz)
        Spacing      % Spacing of array (m)
        Name         % Sensor array test run name
    end
    properties (Access=private)
        Wavelength   % Wavelength of sources (m)
    end
    properties (Constant)
        c=3e8;       % Speed of wave in medium (m/s)
    end
    properties (Dependent)
        NumSensors   % Number of sensors
        NumSamples   % Number of samples
    end
    methods
        function obj=sads(Data, Wavelength,SampleRate,Spacing,Name)
            % SADS Create sensor array data set
            % Example:
            %  sads(Data, Wavelength,SampleRate,Spacing,Name)

            obj.Data=Data;
            obj.SampleRate=SampleRate;
            obj.Spacing = Spacing;
            obj.Name=Name;
            obj.Wavelength=Wavelength;
        end
        function [mags, fflip]=magfft(obj,zeroPadTo)
            % MAGFFT Calculate the magnitude square of the FFT of the
            % sensor array sample data, zeropadding by zeroPadTo elements
            % Example:
            %  result=magfft(s,128);

            mag=zeros(obj.NumSamples,zeroPadTo); % Preallocate store of magnitudes
            f=asin((-0.5:1/(zeroPadTo-1):0.5)*obj.Wavelength/obj.Spacing)/pi; % Frequencies
            fflip=fliplr(f); % Flip frequencies

            % Take the sum over each sensor array sample
            for k=1:obj.NumSamples
                avbig=zeros(1,zeroPadTo);            % Zero pad
                avbig(1:obj.NumSensors)=obj.Data(1,:);
                response=fft(avbig)/zeroPadTo;       % FFT of normalized signal
                mag(k,:)=abs(fftshift(response)).^2; % Mag squared of FFT
            end
            mags=sum(mag);
        end
        function NumSensors=get.NumSensors(obj)
            % Get NumSensors property
            NumSensors=size(obj.Data,2);
        end
        function NumSamples=get.NumSamples(obj)
            % Get NumSamples property
            NumSamples=size(obj.Data,1);
        end
        function plot(obj)
            % PLOT Plot the sensor array sample data set
            % Example:
            %  plot(ds);

            surf(real(obj.Data)',...
                'EdgeLighting','flat','FaceLighting','none',...
                'FaceColor',[1 1 1],...
                'EdgeColor',[0 0 1]);
            view([-55.5 74]);
            title(obj.Name);
            xlabel('Samples')
            ylabel('Sensors')
            zlabel('Amplitude')
            xlim([1 obj.NumSamples]);
            ylim([1 obj.NumSensors]);
            set(gca,'xtick',(1:obj.NumSamples/8:obj.NumSamples));
        end
        function magfftplot(obj, zeroPadTo)
            % MAGFFTPLOT Plot the magnitude square of the FFT of the sensor
            % array data
            % Example:
            %  magfftplot(s,128);

            [mags, fflip]=magfft(obj, zeroPadTo);
            semilogy(180*fflip,mags(1:zeroPadTo),'r');
            grid
            title(['Averaged Magnitude Squared FFT of: ' obj.Name]);
            xlabel('Degrees');
            ylabel('Amplitude');
        end
        function angles=doa(obj)
            % DOA  Estimate the direction of arrival of the sources in the
            % sensor array data set using simplistic peak finding method
            % Example:
            %  angels=doa(ds)

            zeroPadTo=256;
            [mags, fflip]=magfft(obj,zeroPadTo);
            maxtab=peakdet(mags,.1);             % Use peakdet function
            angles=sort(fflip(maxtab(:,1))*180); % Angles
        end
        function obj=steer(obj,theta)
            % STEER Steer array electronically by angle theta (in degrees),
            % returning a new sensor array data set
            % Example:
            %   s=steer(s,10);
            delta=obj.Spacing; thetaR=theta*(pi/180);
            Wc=2*pi*(obj.c/obj.Wavelength); % Source frequency in radians per sec
            phaseShift=exp(-j*Wc*delta*(0:obj.NumSensors-1)*sin(thetaR)/obj.c);
            obj.Data=bsxfun(@times,obj.Data,phaseShift); % Multiply by phaseshift
        end
    end
    methods (Static)
        function showarray(Targets,NumSensors,Spacing)
            % SHOWARRAY  Illustrate a sensor array with ideal sources
            % Example:
            %  showarray(Targets,NumSensors,Spacing)

            numTargets=size(Targets,1);
            orgX=(NumSensors+1)/2;         % Center of array on x-axis

            % Plot sensors
            plot((1:NumSensors)',zeros(NumSensors,1),'o');
            axis tight
            set(gca,'xtick',1:NumSensors); % Ensure tick marks at each sensor
            set(gca,'ytick',[]);           % Remove y tick marks
            ylim([0 NumSensors/1.5]);      % Set Y axis limit
            hold on

            % Plot normal to array (Array direction)
            plot(ones(NumSensors,1).*orgX,(0:NumSensors-1)','--k');

            % Plot Incident rays
            for tar=1:numTargets
                bearing=.5*pi-Targets(tar,1);
                length_line=orgX;
                rayX=length_line*cos(bearing)+orgX;
                rayY=length_line*sin(bearing);
                plot([rayX orgX]', [rayY 0]','r');
            end
            hold off

            % Annotations
            legend('Sensors','Direction of Array','Direction of Sources');
            xlabel(['Sensor spacing is ',num2str(Spacing), ' m']);
            title([int2str(NumSensors),' sensor array with ' int2str(numTargets) ' sources']);
        end
    end
end
function [maxtab, mintab]=peakdet(v, delta)
%PEAKDET Detect peaks in a vector
%        [MAXTAB, MINTAB] = PEAKDET(V, DELTA) finds the local
%        maxima and minima ("peaks") in the vector V.
%        A point is considered a maximum peak if it has the maximal
%        value, and was preceded (to the left) by a value lower by
%        DELTA. MAXTAB and MINTAB consists of two columns. Column 1
%        contains indices in V, and column 2 the found values.
% Eli Billauer, 3.4.05 (Explicitly not copyrighted).
% http://www.billauer.co.il/peakdet.html
% This function is released to the public domain; Any use is allowed.

maxtab = [];
mintab = [];

v = v(:); % Just in case this wasn't a proper vector

if (length(delta(:)))>1
    error('Input argument DELTA must be a scalar');
end

if delta <= 0
    error('Input argument DELTA must be positive');
end

mn = Inf; mx = -Inf;
mnpos = NaN; mxpos = NaN;

lookformax = 1;

for i=1:length(v)
    this = v(i);
    if this > mx, mx = this; mxpos = i; end
    if this < mn, mn = this; mnpos = i; end

    if lookformax
        if this < mx-delta
            maxtab = [maxtab ; mxpos mx];
            mn = this; mnpos = i;
            lookformax = 0;
        end
    else
        if this > mn+delta
            mintab = [mintab ; mnpos mn];
            mx = this; mxpos = i;
            lookformax = 1;
        end
    end
end
end