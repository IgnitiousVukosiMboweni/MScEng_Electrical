function newMain = mergePumps(main,backup)
%This function adds true values of the backup pump to the main pump
pidx = main == 0 & backup ==1;
newMain = main + pidx;

end

