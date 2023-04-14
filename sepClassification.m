%% 分别针对3种位置类内分类
for i = 1 : 3
    % KNN
    predict_label_KNN_emg{i} = predict(KNN_model_emg{i}, emg_feature_test{i});
    confusion_KNN_emg{i} = confusionmat(test_label{i}, predict_label_KNN_emg{i});
    predict_label_KNN_amode{i} = predict(KNN_model_amode{i}, amode_feature_test{i});
    confusion_KNN_amode{i} = confusionmat(test_label{i}, predict_label_KNN_amode{i});
    predict_label_KNN_fusion{i} = predict(KNN_model_fusion{i}, fusion_feature_test{i});
    confusion_KNN_fusion{i} = confusionmat(test_label{i}, predict_label_KNN_fusion{i});
    % SVM
    predict_label_SVM_emg{i} = predict(SVM_model_emg{i}, emg_feature_test{i});
    confusion_SVM_emg{i} = confusionmat(test_label{i}, predict_label_SVM_emg{i});
    predict_label_SVM_amode{i} = predict(SVM_model_amode{i}, amode_feature_test{i});
    confusion_SVM_amode{i} = confusionmat(test_label{i}, predict_label_SVM_amode{i});
    predict_label_SVM_fusion{i} = predict(SVM_model_fusion{i}, fusion_feature_test{i});
    confusion_SVM_fusion{i} = confusionmat(test_label{i}, predict_label_SVM_fusion{i});
    % LDA
    predict_label_LDA_emg{i} = predict(LDA_model_emg{i}, emg_feature_test{i});
    confusion_LDA_emg{i} = confusionmat(test_label{i}, predict_label_LDA_emg{i});
    predict_label_LDA_amode{i} = predict(LDA_model_amode{i}, amode_feature_test{i});
    confusion_LDA_amode{i} = confusionmat(test_label{i}, predict_label_LDA_amode{i});
    predict_label_LDA_fusion{i} = predict(LDA_model_fusion{i}, fusion_feature_test{i});
    confusion_LDA_fusion{i} = confusionmat(test_label{i}, predict_label_LDA_fusion{i});
end