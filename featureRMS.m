function RMS = featureRMS(data)
    RMS = sqrt(mean(data.^2));
end