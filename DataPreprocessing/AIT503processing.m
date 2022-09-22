% This script processes AIT201

AIT503 = df.AIT503;
% plot(AIT503,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

AIT503Smoothed = smoothdata(AIT503,'movmean','SmoothingFactor',0.005);
% % Display results
% clf
% plot(df.Timestamp,AIT503,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(df.Timestamp,AIT503Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;