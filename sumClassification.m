%% 30类别统一识别
% for i = 1 : 3
%     [emg_feature_train{i}, emg_feature_test{i}, amode_feature_train{i}, amode_feature_test{i},...
%         fusion_feature_train{i}, fusion_feature_test{i}, train_label{i}, test_label{i}, imu_acc_test{i}] = divideDataSet(emg_data_set{i}, amode_data_set{i}, imu_data_set{i});
% end

for i = 1 : 3
    train_label{i} = train_label{i} + (i - 1) * 10;
    test_label{i} = test_label{i} + (i - 1) * 10;
end

emg_feature_train_sum = [];
emg_feature_test_sum = [];
amode_feature_train_sum = [];
amode_feature_test_sum = [];
fusion_feature_train_sum = [];
fusion_feature_test_sum = [];
train_label_sum = [];
test_label_sum = [];
for i = 1 : 3
    emg_feature_train_sum = [emg_feature_train_sum; emg_feature_train{i}];
    emg_feature_test_sum = [emg_feature_test_sum; emg_feature_test{i}];
    amode_feature_train_sum = [amode_feature_train_sum; amode_feature_train{i}];
    amode_feature_test_sum = [amode_feature_test_sum; amode_feature_test{i}];
    fusion_feature_train_sum = [fusion_feature_train_sum; fusion_feature_train{i}];
    fusion_feature_test_sum = [fusion_feature_test_sum; fusion_feature_test{i}];
    train_label_sum = [train_label_sum; train_label{i}];
    test_label_sum = [test_label_sum; test_label{i}];
end
%%
% KNN
KNN_model_emg_sum = fitcknn(emg_feature_train_sum, train_label_sum, 'NumNeighbors', K);
KNN_model_amode_sum = fitcknn(amode_feature_train_sum, train_label_sum, 'NumNeighbors', K);
KNN_model_fusion_sum = fitcknn(fusion_feature_train_sum, train_label_sum, 'NumNeighbors', K);
% SVM
SVM_model_emg_sum = fitcecoc(emg_feature_train_sum, train_label_sum);
SVM_model_amode_sum = fitcecoc(amode_feature_train_sum, train_label_sum);
SVM_model_fusion_sum = fitcecoc(fusion_feature_train_sum, train_label_sum);
% LDA
LDA_model_emg_sum = fitcdiscr(emg_feature_train_sum, train_label_sum);
LDA_model_amode_sum = fitcdiscr(amode_feature_train_sum, train_label_sum);
LDA_model_fusion_sum = fitcdiscr(fusion_feature_train_sum, train_label_sum);
%%
% KNN
predict_label_KNN_emg_sum = predict(KNN_model_emg_sum, emg_feature_test_sum);
confusion_KNN_emg_sum = confusionmat(test_label_sum, predict_label_KNN_emg_sum);
predict_label_KNN_amode_sum = predict(KNN_model_amode_sum, amode_feature_test_sum);
confusion_KNN_amode_sum = confusionmat(test_label_sum, predict_label_KNN_amode_sum);
predict_label_KNN_fusion_sum = predict(KNN_model_fusion_sum, fusion_feature_test_sum);
confusion_KNN_fusion_sum = confusionmat(test_label_sum, predict_label_KNN_fusion_sum);
% SVM
predict_label_SVM_emg_sum = predict(SVM_model_emg_sum, emg_feature_test_sum);
confusion_SVM_emg_sum = confusionmat(test_label_sum, predict_label_SVM_emg_sum);
predict_label_SVM_amode_sum = predict(SVM_model_amode_sum, amode_feature_test_sum);
confusion_SVM_amode_sum = confusionmat(test_label_sum, predict_label_SVM_amode_sum);
predict_label_SVM_fusion_sum = predict(SVM_model_fusion_sum, fusion_feature_test_sum);
confusion_SVM_fusion_sum = confusionmat(test_label_sum, predict_label_SVM_fusion_sum);
% LDA
predict_label_LDA_emg_sum = predict(LDA_model_emg_sum, emg_feature_test_sum);
confusion_LDA_emg_sum = confusionmat(test_label_sum, predict_label_LDA_emg_sum);
predict_label_LDA_amode_sum = predict(LDA_model_amode_sum, amode_feature_test_sum);
confusion_LDA_amode_sum = confusionmat(test_label_sum, predict_label_LDA_amode_sum);
predict_label_LDA_fusion_sum = predict(LDA_model_fusion_sum, fusion_feature_test_sum);
confusion_LDA_fusion_sum = confusionmat(test_label_sum, predict_label_LDA_fusion_sum);

%%
str = "KNN";
acc = getConfusionResult(confusion_KNN_emg_sum);
disp(str + " sum EMG" + ": " + string(acc));
str = "SVM";
acc = getConfusionResult(confusion_SVM_emg_sum);
disp(str + " sum EMG" + ": " + string(acc));
str = "LDA";
acc = getConfusionResult(confusion_LDA_emg_sum);
disp(str + " sum EMG" + ": " + string(acc));
fprintf(" \n");
%%
str = "KNN";
acc = getConfusionResult(confusion_KNN_amode_sum);
disp(str + " sum Amode" + ": " + string(acc));
str = "SVM";
acc = getConfusionResult(confusion_SVM_amode_sum);
disp(str + " sum Amode" + ": " + string(acc));
str = "LDA";
acc = getConfusionResult(confusion_LDA_amode_sum);
disp(str + " sum Amode" + ": " + string(acc));
fprintf(" \n");
%%
str = "KNN";
acc = getConfusionResult(confusion_KNN_fusion_sum);
disp(str + " sum fusion" + ": " + string(acc));
str = "SVM";
acc = getConfusionResult(confusion_SVM_fusion_sum);
disp(str + " sum fusion" + ": " + string(acc));
str = "LDA";
acc = getConfusionResult(confusion_LDA_fusion_sum);
disp(str + " sum fusion" + ": " + string(acc));
fprintf(" \n");