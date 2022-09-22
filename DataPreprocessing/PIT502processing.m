% This script processes AIT201

PIT502 = df.PIT502;
% plot(PIT502,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Smooth the signal

PIT502Smoothed = smoothdata(PIT502,'movmean','SmoothingFactor',0.03);
% % Display results
% clf
% plot(PIT502,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(PIT502Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;