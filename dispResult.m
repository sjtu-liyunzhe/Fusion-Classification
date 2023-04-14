%% 展示结果
format long;
%% Sep
% EMG 
for i = 1 : 3
    str = "KNN";
    acc = getConfusionResult(confusion_KNN_emg{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "SVM";
    acc = getConfusionResult(confusion_SVM_emg{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "LDA";
    acc = getConfusionResult(confusion_LDA_emg{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    fprintf(" \n");
end
% Amode
for i = 1 : 3
    str = "KNN";
    acc = getConfusionResult(confusion_KNN_amode{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "SVM";
    acc = getConfusionResult(confusion_SVM_amode{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "LDA";
    acc = getConfusionResult(confusion_LDA_amode{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    fprintf(" \n");
end
% fusion
for i = 1 : 3
    str = "KNN";
    acc = getConfusionResult(confusion_KNN_fusion{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "SVM";
    acc = getConfusionResult(confusion_SVM_fusion{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    str = "LDA";
    acc = getConfusionResult(confusion_LDA_fusion{i});
    disp(str + " pos" + string(i) + ": " + string(acc));
    fprintf(" \n");
end
%% pos
getConfusionResult(confusion_pos);
%% double Class
acc = getConfusionResult(confusion_30_KNN_emg);
disp("KNN emg: " + string(acc));
acc = getConfusionResult(confusion_30_SVM_emg);
disp("SVM emg: " + string(acc));
acc = getConfusionResult(confusion_30_LDA_emg);
disp("LDA emg: " + string(acc));
acc = getConfusionResult(confusion_30_KNN_amode);
disp("KNN amode: " + string(acc));
acc = getConfusionResult(confusion_30_SVM_amode);
disp("SVM amode: " + string(acc));
acc = getConfusionResult(confusion_30_LDA_amode);
disp("LDA amode: " + string(acc));
acc = getConfusionResult(confusion_30_KNN_fusion);
disp("KNN fusion: " + string(acc));
acc = getConfusionResult(confusion_30_SVM_fusion);
disp("SVM fusion: " + string(acc));
acc = getConfusionResult(confusion_30_LDA_fusion);
disp("LDA fusion: " + string(acc));
%% hybrid Class