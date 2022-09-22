% This script processes FIT201

FIT201 = df.FIT201;     
% plot(datetime(df.Timestamp),FIT201,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

% Extract Localmaxs

FIT201maxs = islocalmax(FIT201,'MinProminence',0.05);

% plot(datetime(df.Timestamp),FIT201,'k-','LineWidth',2)
 
%  hold on
%  plot(df.Timestamp(FIT201maxs),FIT201(FIT201maxs),'r*','LineWidth',2);
%  hold off
%  ax = gca; ax.FontSize = 14;

 FIT201Maxima = FIT201.*FIT201maxs;

% Distance between max peaks

%use range function
aa=[]; nn=[]; cc = 0;
FITdata.Time = second(df.Timestamp);  % time column
FITdata.localmins = FIT201maxs;  % localmins column
FITdata.range = zeros(max(size(FITdata.Time)),1); % difference colum
FIT201maxs(length(FIT201maxs)) = 1;     % make last value 0 so that last data packet can be captured

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

FIT201Range = FITdata.range;
FIT201Range = FIT201Range';

% Populate the rest of the fields to the last entry
FIT201Range(length(FIT201Range):length(FIT201)) = FIT201Range(length(FIT201Range));
FIT201Range = FIT201Range';

