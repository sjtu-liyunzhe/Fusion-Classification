function numOfZC = featureZC(data)
    threshold = 10e-7;
    numOfZC = [];
    channel = size(data, 2);
    length = size(data, 1);
    for i = 1: channel
        count = 0;
        for j = 2: length
            diff = data(j, i) - data(j - 1, i);
            multi = data(j, i) * data(j - 1, i);
            
            if(abs(diff) > threshold && multi < 0)
                count = count + 1;
            end
        end
        numOfZC(:, end + 1) = count;
    end
    numOfZC = numOfZC ./ length; 
end