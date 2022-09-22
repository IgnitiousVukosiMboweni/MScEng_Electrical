% since filtering FIT101 data removed 0s, this script adds 0s from... 
%...original to filtered FIT101 data

for i = 1:length(FIT101filtered)
    if FIT101p(i) == 0
        FIT101filtered(i) = 0;
    end
end 