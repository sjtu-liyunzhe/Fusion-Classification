function WL = featureWL(data)
    WL = sum(abs(diff(data)));
end