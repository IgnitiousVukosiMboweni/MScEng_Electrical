function plotHist(data,column)

normaldataIDX = data.Normal_Attack == "Normal";
normalData = data(normaldataIDX,:);

attackdataIDX = data.Normal_Attack == "Attack";
attackData = data(attackdataIDX,:);

histogram(normalData{:,column});
hold on
histogram(attackData{:,column});
hold off
legend('Normal','Attack');

end

