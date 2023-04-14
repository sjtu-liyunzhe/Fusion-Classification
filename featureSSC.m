function numOfSSC = featureSSC(data)
    threshold = 10e-7;
    numOfSSC = [];
    channel = size(data, 2);
    length = size(data, 1);
    for i  = 1: channel
        count = 0;
        for j = 3: length
            diff1 = data(j, i) - data(j - 1, i);
            diff2 = data(j - 1, i) - data(j - 2, i);
            sign = diff1 * diff2;
            
            if(sign < 0)
                if(abs(diff1) > threshold || abs(diff2) > threshold)
                    count = count + 1;
                end
            end
        end
        numOfSSC(:, end + 1) = count;
    end
    numOfSSC = numOfSSC ./ length;
end