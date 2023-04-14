function acc = getAcc(mat)
    sum = 0;
    sum_i = 0;
    for i = 1 : size(mat, 1)
        for j = 1 : size(mat, 2)
            if(i ==j)
                sum_i = sum_i + mat(i, j);
            end
            sum = sum + mat(i, j);
        end
    end
    acc = sum_i / sum;
end