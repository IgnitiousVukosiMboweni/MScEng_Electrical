% This script processes AIT201

LIT401 = df.LIT401;
% plot(df.Timestamp, LIT401,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;


%% Smoothing the data

LIT401Smoothed = smoothdata(LIT401,'movmean','SmoothingFactor',0.0005);

%% Find local maxima and minima

maxIndices2 = islocalmax(LIT401,"MinProminence",5);
minIndices2 = islocalmin(LIT401,"MinProminence",5);

% Display results
% clf
% plot(LIT401,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(LIT401Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% 
% % Plot local maxima
% plot(find(maxIndices2),LIT401(maxIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[217 83 25]/255,"MarkerSize",9,"DisplayName","Local maxima")
% 
% % Plot local manima
% plot(find(minIndices2),LIT401(minIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[237 177 32]/255,"MarkerSize",9,"DisplayName","Local maxima")
% hold off
% legend
% ax = gca; ax.FontSize = 14;

LIT401Maxima = LIT401.*maxIndices2;
LIT401Minima = LIT401.*minIndices2;

%% Approximating slope dXdT=Δx/Δt.

reLIT = resample(LIT401Smoothed,1,50);
filtreLIT = medfilt1(reLIT ,10,'truncate'); 
dY = diff(filtreLIT);
dT = diff(df.Timestamp);
dXre = resample(dY,50,1);
% plot(dXre)

LIT401Slopes = dXre;
LIT401Slopes(numel(LIT401)) = 0;
%% Plot sampled data against against original data

% tee = (0:(length(reLIT)-1))*10;
% plot(t,LIT401Smoothed,'*',tee,reLIT,'o')
% plot(t,LIT401Smoothed,'*',tee,reLIT,'o');legend('Original','Resampled', 'Location','NorthWest');


%% Finding distance between peaks

% filter out noise
yMedFilt = medfilt1(LIT401,60,'truncate'); 

%find local minimums with high prominence
TF2 = islocalmin(yMedFilt,"MinProminence",10);
% plot(df.Timestamp,yMedFilt,df.Timestamp(TF2),yMedFilt(TF2),'r*','LineWidth',2);ax = gca; ax.FontSize = 14;

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

LIT401Range = LITdata.range;