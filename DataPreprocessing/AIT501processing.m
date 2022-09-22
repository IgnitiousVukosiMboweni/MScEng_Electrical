% This script processes AIT201

AIT501 = df.AIT501;
% plot(df.Timestamp,AIT501,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

AIT501Smoothed = smoothdata(AIT501,'movmean','SmoothingFactor',0.02);
% % Display results
% clf
% plot(AIT501,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(AIT501Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;