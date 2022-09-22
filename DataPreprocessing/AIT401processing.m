% This script processes AIT201

AIT401 = df.AIT401;
% plot(AIT401,'k-','LineWidth',2);ax = gca; ax.FontSize = 14;

%% Dividing into sections

for i = 1:length(AIT401)
    
    if AIT401(i) > 148
        AIT401(i) = 1;
    else
        AIT401(i) = 0;
    end
end

AIT401Processed = AIT401;