%% This script processes FIT101

LIT101 = df.LIT101;

%%  Median smoothing applied to data

LIT101Filtered = medfilt1(LIT101,600,'truncate');
% plot(df.Timestamp,LIT101,df.Timestamp,LIT101Filtered,'LineWidth',2); legend('LIT101','LIT101 Filtered');ax = gca; ax.FontSize = 14;
% legend('original signal','median filter')

%% Approximating slope dXdT=Δx/Δt.

LITMedFilt = medfilt1(LIT101,200,'truncate');
reLIT = resample(LITMedFilt,1,10);
filtreLIT = medfilt1(reLIT ,10,'truncate'); 
dY = diff(filtreLIT);
dXre = resample(dY,10,1);
% plot(dXre)

LIT101Slopes = dXre;
LIT101Slopes(numel(LIT101)) = 0;

%% Plot sampled data against against original data

% tee = (0:(length(reLIT)-1))*10;
% plot(t,LITMedFilt,'*',tee,reLIT,'o')
% plot(t,LITMedFilt,'*',tee,reLIT,'o');legend('Original','Resampled', 'Location','NorthWest');


%% Finding distance between peaks

% filter out noise
yMedFilt = medfilt1(LIT101,60,'truncate'); 

%find local minimums with high prominence
TF2 = islocalmin(yMedFilt,"MinProminence",10);
TF1 = islocalmax(yMedFilt,"MinProminence",10);
% plot(df.Timestamp,yMedFilt,df.Timestamp(TF1),yMedFilt(TF1),'r*','LineWidth',2);ax = gca; ax.FontSize = 14;
LIT101Peaks = (LIT101.*TF1)+ (LIT101.*TF2);

%use range function
aa=[]; nn=[]; cc = 0;
LITdata.Time = second(df.Timestamp);  % time column
LITdata.localmins = TF2;  % localmins column
LITdata.range = zeros(max(size(LITdata.Time)),1); % difference colum
TF2(length(TF2)) = 1;     % make last value 0 so that last data packet can be captured

%condition for extracting 
for i = 1:length(LITdata.localmins)
    if LITdata.localmins(i) ~= 1
        aa = [aa,LITdata.localmins(i)];     
        nn = [nn, i];
        if i <= length(LITdata.localmins) -1
            g = LITdata.localmins(i+1);    % checks if amplitude of next element is zero
        end
        if g == 1
            cc = cc + 1;
            LITstore(cc).MINs = aa'; %#ok<*SAGROW>    % store non-zero amplitude data in class SWAVE
            LITstore(cc).Sample_no = nn';            % store sample no of non-zero amplitude data in class SWAVE
            aa = []; nn = []; %nt=[];                    % clear place holders                   % clear place holders
        end
    end
end
 
%populate range column
for ii = 1:cc
    for iii = 1:length(LITstore(ii).Sample_no)
        LITdata.range(LITstore(ii).Sample_no(iii)) = length(LITstore(ii).Sample_no);       % assign max frequency for non-zero amplitude data
    end
end

LIT101Range = LITdata.range;







nsjjsjjllsinnsjsjdnnkskkk ii nsSAa  m nklnsdkfndknfkdmmms sdsd sd
