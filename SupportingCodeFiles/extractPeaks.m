function [peakdist, plotMaxs, plotMins] = extractPeaks(df,feature,prominance)
% This function extracts local maxima and minima, and the distance between them, from the input feature data.

% Extract Localmaxs

maxPeaks = islocalmax(feature,'MinProminence',prominance);
plotMaxs = figure;
plot(df.Timestamp,feature,df.Timestamp(maxPeaks),feature(maxPeaks),'r*');

% Extract Localmins

minPeaks = islocalmin(feature,'MinProminence',prominance);
plotMins =  figure;
plot(df.Timestamp,feature,df.Timestamp(minPeaks),feature(minPeaks),'r*');


% Distance between max peaks

%use range function
aa=[]; nn=[]; cc = 0;
featureData.Time = second(df.Timestamp);  % time column
featureData.localmins = maxPeaks;  % localmins column
featureData.range = zeros(max(size(featureData.Time)),1); % difference colum
maxPeaks(length(maxPeaks)) = 1;     % make last value 0 so that last data packet can be captured

%condition for extracting 
for i = 1:length(featureData.localmins)
    if featureData.localmins(i) ~= 1
        aa = [aa,featureData.localmins(i)];     
        nn = [nn, i];
        if i <= length(featureData.localmins) -1
            g = featureData.localmins(i+1);    % checks if amplitude of next element is zero
        end
        if g == 1
            cc = cc + 1;
            featureStore(cc).MINs = aa'; %#ok<*SAGROW>    % store non-zero amplitude data in class SWAVE
            featureStore(cc).Sample_no = nn';            % store sample no of non-zero amplitude data in class SWAVE
            aa = []; nn = []; %nt=[];                    % clear place holders                   % clear place holders
        end
    end
end
 
%populate range column
for ii = 1:cc
    for iii = 1:length(featureStore(ii).Sample_no)
        featureData.range(featureStore(ii).Sample_no(iii)) = length(featureStore(ii).Sample_no);       % assign max frequency for non-zero amplitude data
    end
end

peakdist = featureData.range;
end

