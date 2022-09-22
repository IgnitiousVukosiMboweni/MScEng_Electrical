% This script processes FIT301

LIT301 = df.LIT301;
% plot(datetime(df.Timestamp),LIT301,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smoothing the data

LIT301Smoothed = medfilt1(LIT301,50,'truncate');

% % Display results
% clf
% plot(LIT301,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(LIT301smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;

%% Find local maxima and minima

maxIndices2 = islocalmax(LIT301,"MinProminence",5);
minIndices2 = islocalmin(LIT301,"MinProminence",5);

% Display results
% clf
% plot(LIT301,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(LIT301Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% 
% % Plot local maxima
% plot(find(maxIndices2),LIT301(maxIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[217 83 25]/255,"MarkerSize",9,"DisplayName","Local maxima")
% 
% % Plot local manima
% plot(find(minIndices2),LIT301(minIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[237 177 32]/255,"MarkerSize",9,"DisplayName","Local maxima")
% hold off
% legend
% ax = gca; ax.FontSize = 14;

LIT301Maxima = LIT301.*maxIndices2;
LIT301Minima = LIT301.*minIndices2;
%% Approximating slope dXdT=Δx/Δt.

LIT301MedFilt = medfilt1(LIT301,50,'truncate');
reLIT = resample(LIT301MedFilt,1,50);
filtreLIT = medfilt1(reLIT ,10,'truncate'); 
dY = diff(filtreLIT);
dT = diff(df.Timestamp);
dXre = resample(dY,50,1);
% plot(dXre)

LIT301Slopes = dXre;
LIT301Slopes(numel(LIT301)) = 0;

%% Plot sampled data against against original data

% tee = (0:(length(reLIT)-1))*10;
% plot(t,LIT301MedFilt,'*',tee,reLIT,'o')
% plot(t,LIT301MedFilt,'*',tee,reLIT,'o');legend('Original','Resampled', 'Location','NorthWest');


%% Finding distance between peaks

% filter out noise
yMedFilt = medfilt1(LIT301,60,'truncate'); 

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

LIT301Range = LITdata.range;