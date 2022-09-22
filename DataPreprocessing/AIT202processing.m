% This script processes AIT202

AIT202 = df.AIT202;     
% plot(datetime(df.Timestamp),AIT202,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;
%% Detrend and smooth the data

y = detrend(AIT202,'linear');
AIT202SmoothDetrend = smoothdata(y,'gaussian');

% plot(df.Timestamp,AIT202,'k-','LineWidth',2)
% hold on
% plot(df.Timestamp,AIT202SmoothDetrend,'r-','LineWidth',2)
% legend('Input Data','Smoothed and Detrended Data')
% ax = gca; ax.FontSize = 14;

%% Extract Localmins

AIT202minindex = islocalmin(AIT202SmoothDetrend,'MinProminence',0.05);
% plot(df.Timestamp,AIT202SmoothDetrend,'k-','LineWidth',2);
% hold on
% plot(df.Timestamp(AIT202minindex),AIT202SmoothDetrend(AIT202minindex),'r*','LineWidth',2);
% Extract Localmaxs

AIT202maxindex = islocalmax(AIT202SmoothDetrend,'MinProminence',0.05);

% plot(df.Timestamp(AIT202maxindex),AIT202SmoothDetrend(AIT202maxindex),'r*','LineWidth',2);
% hold off
% 
% ax = gca; ax.FontSize = 14;

AIT202Minima = AIT202.*AIT202minindex;
AIT202Maxima = AIT202.*AIT202maxindex;

%% Distance between max peaks

%use range function
aa=[]; nn=[]; cc = 0;
AITdata.Time = second(df.Timestamp);  % time column
AITdata.localmins = AIT202maxindex;  % localmins column
AITdata.range = zeros(max(size(AITdata.Time)),1); % difference colum
AIT202maxindex(length(AIT202maxindex)) = 1;     % make last value 0 so that last data packet can be captured

%condition for extracting 
for i = 1:length(AITdata.localmins)
    if AITdata.localmins(i) ~= 1
        aa = [aa,AITdata.localmins(i)];     
        nn = [nn, i];
        if i <= length(AITdata.localmins) -1
            g = AITdata.localmins(i+1);    % checks if amplitude of next element is zero
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
        AITdata.range(AITstore(ii).Sample_no(iii)) = length(AITstore(ii).Sample_no);       % assign max frequency for non-zero amplitude data
    end
end

AIT202PeakRange = AITdata.range;

