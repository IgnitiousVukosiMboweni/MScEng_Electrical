% This script processes AIT201

AIT402 = df.AIT402;
% plot(AIT402,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

AIT402Smoothed = smoothdata(AIT402,'movmean','SmoothingFactor',0.005);
% % Display results
% clf
% plot(AIT402,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(AIT402Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;
