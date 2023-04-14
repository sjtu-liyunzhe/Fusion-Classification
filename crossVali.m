function [ave_acc, sd] = crossVali(mat_cell, k)
    RA = [];
    for i = 1 : k
        RA(i) = getAcc(mat_cell{i});
    end
    ave_acc = sum(RA) / k;
    sd = std(RA);
end