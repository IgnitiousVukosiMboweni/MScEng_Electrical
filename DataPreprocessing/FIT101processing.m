%Plot FIT101
FIT101 = df.FIT101;
% plot(df.Timestamp,FIT101,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;
%% Replace values in FIT101 less than 2.4 with 0
FIT101p = df.FIT101;
FIT101p(FIT101p <= double(2.4) ) = 0;
%% Mean of non zeros
% This code moves signal to x-axis by subtracting mean
mnz = mean(nonzeros(FIT101p));
FIT101p = FIT101p - mnz;
FIT101p(FIT101p <= double(-2) ) = 0;

%% Use moving mean to smooth the signal
FIT101Filtered = smoothdata(FIT101p,'movmean');

%% Extracting Frequency
% This script extracts frequencies of non zero elements from a feature and .. 
% ...populates them into a new column

% Initialisation
fontSize = 15;
a=[]; n=[]; c = 0;
Data.Amplitude = FIT101Filtered;  % amplitude column
Data.Frequency = zeros(max(size((FIT101Filtered))),1); % frequency column
FIT101Filtered(length(FIT101Filtered)) = 0;     % make last value 0 so that last data packet can be captured

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

FIT101Frequencies = Data.Frequency;

%% Finding peaks of the signal

%find local minimums with high prominence
TF1 = islocalmax(FIT101);
% plot(df.Timestamp,FIT101,df.Timestamp(TF1),FIT101(TF1),'r*','LineWidth',2);ax = gca; ax.FontSize = 14;
FIT101Peaks = FIT101.*TF1;