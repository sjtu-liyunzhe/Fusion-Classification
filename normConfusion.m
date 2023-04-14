function norm_confusionMat = normConfusion(mat)
    m = size(mat, 2);
%     norm_confusionMat = zeros(m);
    for i = 1: m
        norm_confusionMat(i, :) = mat(i, :) / sum(mat(i, :));
    end
end