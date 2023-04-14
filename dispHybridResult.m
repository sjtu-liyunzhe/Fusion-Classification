%% 展示混叠结果
% KNN
acc = getConfusionResult(confusion_h_2_KNN_emg);
disp("hybrid KNN emg: " + string(acc));
acc = getConfusionResult(confusion_h_2_KNN_amode);
disp("hybrid KNN amode: " + string(acc));
acc = getConfusionResult(confusion_h_2_KNN_fusion);
disp("hybrid KNN fusion: " + string(acc));
% SVM
acc = getConfusionResult(confusion_h_2_SVM_emg);
disp("hybrid SVM emg: " + string(acc));
acc = getConfusionResult(confusion_h_2_SVM_amode);
disp("hybrid SVM amode: " + string(acc));
acc = getConfusionResult(confusion_h_2_SVM_fusion);
disp("hybrid SVM fusion: " + string(acc));
% KNN
acc = getConfusionResult(confusion_h_2_LDA_emg);
disp("hybrid LDA emg: " + string(acc));
acc = getConfusionResult(confusion_h_2_LDA_amode);
disp("hybrid LDA amode: " + string(acc));
acc = getConfusionResult(confusion_h_2_LDA_fusion);
disp("hybrid LDA fusion: " + string(acc));
%% pos3
% KNN
acc = getConfusionResult(confusion_h_3_KNN_emg);
disp("hybrid KNN emg: " + string(acc));
acc = getConfusionResult(confusion_h_3_KNN_amode);
disp("hybrid KNN amode: " + string(acc));
acc = getConfusionResult(confusion_h_3_KNN_fusion);
disp("hybrid KNN fusion: " + string(acc));
% SVM
acc = getConfusionResult(confusion_h_3_SVM_emg);
disp("hybrid SVM emg: " + string(acc));
acc = getConfusionResult(confusion_h_3_SVM_amode);
disp("hybrid SVM amode: " + string(acc));
acc = getConfusionResult(confusion_h_3_SVM_fusion);
disp("hybrid SVM fusion: " + string(acc));
% KNN
acc = getConfusionResult(confusion_h_3_LDA_emg);
disp("hybrid LDA emg: " + string(acc));
acc = getConfusionResult(confusion_h_3_LDA_amode);
disp("hybrid LDA amode: " + string(acc));
acc = getConfusionResult(confusion_h_3_LDA_fusion);
disp("hybrid LDA fusion: " + string(acc));