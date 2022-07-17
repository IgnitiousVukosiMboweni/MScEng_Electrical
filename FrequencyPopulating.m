% This script extracts frequencies of non zero elements from a feature and .. 
% ...populates them into a new column

% Initialisation
fontSize = 15;
a=[]; n=[]; c = 0;
Data.Time = Duration;  % time column
Data.Amplitude = FIT101filtered;  % amplitude column
Data.Frequency = zeros(max(size((Data.Time))),1); % frequency column
FIT101filtered(length(FIT101filtered)) = 0;     % make last value 0 so that last data packet can be captured

% Condition for extracting feature
for i = 1:length(Data.Amplitude)
    if Data.Amplitude(i) ~= 0
        a = [a,Data.Amplitude(i)]; %#ok<*AGROW>     % get non-zero amplitude data
        n = [n,i];      % gets sample no from data
        if i <= length(Data.Amplitude) -1
            b = Data.Amplitude(i+1);    % checks if amplitude of next element is zero
        end
        if b == 0
            c = c + 1;
            SWave(c).AMP = a'; %#ok<*SAGROW>    % store non-zero amplitude data in class SWAVE
            SWave(c).Sample_no = n';            % store sample no of non-zero amplitude data in class SWAVE
            a = []; n = []; %nt=[];                    % clear place holders
        end
    end
end 
    
    % find FFT of non-zero amplitude data
    for ii = 1:c
        SWave(ii).FFT = abs(fft(SWave(ii).AMP));
        [~,Hz] = max(SWave(ii).FFT);
       
%         % Uncomment to see plot of Fourier waveform
%         figure; plot(abs(SWave(ii).FFT))                                     
%         xlabel('Hz','FontSize', fontSize); ylabel('dB','FontSize', fontSize);
%         axis equal; grid on;
       
        % populate frequency column
        % devide frequency bins by sample number to convert to Hz. 
        for iii = 1:length(SWave(ii).Sample_no)
            Data.Frequency(SWave(ii).Sample_no(iii)) = Hz/length(SWave(ii).Sample_no);       % assign max frequency for non-zero amplitude data
        end
        Data.Frequency(length(Data.Frequency)) = Data.Frequency(length(Data.Frequency)-1);   % copy second last value of frequency to last value so that its not 0 
        Peak = [];
    end