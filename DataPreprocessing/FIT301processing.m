% This script processes FIT301

FIT301 = df.FIT301;
% plot(datetime(df.Timestamp),FIT301,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;
%% Smoothing the data

FIT301Smoothed = smoothdata(FIT301,"movmean");

% % Display results
% clf
% plot(FIT301,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(FIT301Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;
%% Find local maxima and minima

maxIndices2 = islocalmax(FIT301,"MinProminence",1);

% % Display results
% clf
% plot(FIT301,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(FIT301Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold on
% 
% % Plot local maxima
% plot(find(maxIndices2),FIT301(maxIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[217 83 25]/255,"DisplayName","Local maxima")
% 
% hold off
% legend
% ax = gca; ax.FontSize = 14;

FIT301Maxima = FIT301.*maxIndices2;

%% Distance between max peaks

%use range function
aa=[]; nn=[]; cc = 0;
FITdata.Time = second(df.Timestamp);  % time column
FITdata.localmins = maxIndices2;  % localmins column
FITdata.range = zeros(max(size(FITdata.Time)),1); % difference colum
maxIndices2(length(maxIndices2)) = 1;     % make last value 0 so that last data packet can be captured

%condition for extracting 
for i = 1:length(FITdata.localmins)
    if FITdata.localmins(i) ~= 1
        aa = [aa,FITdata.localmins(i)];     
        nn = [nn, i];
        if i <= length(FITdata.localmins) -1
            g = FITdata.localmins(i+1);    % checks if amplitude of next element is zero
        end
        if g == 1
            cc = cc + 1;
            AITstore(cc).MINs = aa'; %#ok<*SAGROW>    % store non-zero amplitude data in class SWAVE
            AITstore(cc).Sample_no = nn';            % store sample no of non-zero amplitude data in class SWAVE
            aa = []; nn = []; %nt=[];                    % clear place holders                   % clear place holders
        end
    end
end
 
%populate range column
for ii = 1:cc
    for iii = 1:length(AITstore(ii).Sample_no)
        FITdata.range(AITstore(ii).Sample_no(iii)) = length(AITstore(ii).Sample_no);       % assign max frequency for non-zero amplitude data
    end
end

FIT301Range = FITdata.range;
FIT301Range = FIT301Range';

% Populate the rest of the fields to the last entry
FIT301Range(length(FIT301Range):length(FIT301)) = FIT301Range(length(FIT301Range));

FIT301Range = FIT301Range';