function [] = plotAgainstAttacks(df,feature)
%This function plots a graph with attacks area highlighted as a background
attacks = df.Normal_Attack == "Attack";
plot(df.Timestamp,feature,'Color', 'k');
set(gca,'fontsize',14)
hold on
area(df.Timestamp ,attacks.*max(feature),"FaceAlpha", 0.5, "LineStyle", 'none','FaceColor', 'r')
hold off
end

