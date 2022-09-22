% This script processes AIT203

AIT203 = df.AIT203;
% plot(datetime(df.Timestamp),AIT203,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;
%% Smoothing the data

AIT203Smoothed = smoothdata(AIT203,"movmean","SmoothingFactor",0.03);

% Display results
% clf
% plot(AIT203,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(AIT203Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold off
% legend
% ax = gca; ax.FontSize = 14;
%% Find local maxima and minima

maxIndices = islocalmax(AIT203,"MinProminence",1);
minIndices = islocalmin(AIT203,"MinProminence",1);

% % Display results
% clf
% plot(AIT203,'k-','LineWidth',2,"DisplayName","Input data")
% hold on
% plot(AIT203Smoothed,'r-','LineWidth',2,...
%     "DisplayName","Smoothed data")
% hold on
% 
% % Plot local maxima
% plot(find(maxIndices2),AIT203(maxIndices2),"^","Color",[217 83 25]/255,...
%     "MarkerFaceColor",[217 83 25]/255,"DisplayName","Local maxima")
% 
% % Plot local minima
% plot(find(minIndices),AIT203(minIndices),"v","Color",[237 177 32]/255,...
%     "MarkerFaceColor",[237 177 32]/255,"DisplayName","Local minima")
% title("Number of extrema: " + (nnz(maxIndices2)+nnz(minIndices)))
% hold off
% legend
% ax = gca; ax.FontSize = 14;

AIT203Minima =  AIT203.*minIndices;
AIT203Maxima = AIT203.*maxIndices;