% This script processes AIT201

AIT201 = df.AIT201;
% plot(datetime(df.Timestamp),AIT201,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;
%% Filtering the data

windowSize = 600; 
b = (1/windowSize)*ones(1,windowSize);
a = 1;
AIT201Filtered = filter(b,a,AIT201);
 
% plot(df.Timestamp,AIT201,'k-','LineWidth',2)
% hold on
% plot(df.Timestamp,AIT201Filtered,'r-','LineWidth',2)
% legend('Input Data','Filtered Data')
% ax = gca; ax.FontSize = 14;