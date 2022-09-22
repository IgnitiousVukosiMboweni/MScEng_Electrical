% This script processes AIT201

AIT504 = df.AIT504;
% plot(AIT5044,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

AIT504Smoothed = smoothdata(AIT504,'movmean','SmoothingFactor',0.05);
% % Display results
% clf
% plot(df.Timestamp,AIT504,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(df.Timestamp,AIT504Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;