% This script processes AIT201

AIT502 = df.AIT502;
% plot(AIT502,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

AIT502Smoothed = smoothdata(AIT502,'movmean','SmoothingFactor',0.005);
% % Display results
% clf
% plot(AIT502,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(AIT502Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;