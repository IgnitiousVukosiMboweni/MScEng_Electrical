% This script processes AIT201

FIT401Smoothed = df.FIT401;
% plot(df.Timestamp, FIT401Smoothed,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

FIT401Smoothed = smoothdata(FIT401Smoothed,'movmean','SmoothingFactor',0.1);
% % Display results
% clf
% plot(FIT401Smoothed,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(FIT401Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;