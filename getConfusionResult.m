%% 计算结果
function [acc] = getConfusionResult(confusion_cal)
    plotConfusion(normConfusion(confusion_cal), 2);
    acc = getAcc(confusion_cal);
end