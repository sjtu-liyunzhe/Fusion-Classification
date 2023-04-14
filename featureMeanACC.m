function meanACC = featureMeanACC(data)
    x = mean(data(:, 1));
    y = mean(data(:, 2));
    z = mean(data(:, 3));
    meanACC = [x; y; z];
end