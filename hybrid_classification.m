%% 以pos 1训练分类器，用pos 2和pos 3的测试集 测试
%% KNN
% pos 2
result_h_2_KNN_emg = predict(KNN_model_emg{1}, emg_feature_test{2});
confusion_h_2_KNN_emg = confusionmat(test_label{2}, result_h_2_KNN_emg);
result_h_2_KNN_amode = predict(KNN_model_amode{1}, amode_feature_test{2});
confusion_h_2_KNN_amode = confusionmat(test_label{2}, result_h_2_KNN_amode);
result_h_2_KNN_fusion = predict(KNN_model_fusion{1}, fusion_feature_test{2});
confusion_h_2_KNN_fusion = confusionmat(test_label{2}, result_h_2_KNN_fusion);
% pos 3
result_h_3_KNN_emg = predict(KNN_model_emg{1}, emg_feature_test{3});
confusion_h_3_KNN_emg = confusionmat(test_label{3}, result_h_3_KNN_emg);
result_h_3_KNN_amode = predict(KNN_model_amode{1}, amode_feature_test{3});
confusion_h_3_KNN_amode = confusionmat(test_label{3}, result_h_3_KNN_amode);
result_h_3_KNN_fusion = predict(KNN_model_fusion{1}, fusion_feature_test{3});
confusion_h_3_KNN_fusion = confusionmat(test_label{3}, result_h_3_KNN_fusion);
%% SVM
% pos 2
result_h_2_SVM_emg = predict(SVM_model_emg{1}, emg_feature_test{2});
confusion_h_2_SVM_emg = confusionmat(test_label{2}, result_h_2_SVM_emg);
result_h_2_SVM_amode = predict(SVM_model_amode{1}, amode_feature_test{2});
confusion_h_2_SVM_amode = confusionmat(test_label{2}, result_h_2_SVM_amode);
result_h_2_SVM_fusion = predict(SVM_model_fusion{1}, fusion_feature_test{2});
confusion_h_2_SVM_fusion = confusionmat(test_label{2}, result_h_2_SVM_fusion);
% pos 3
result_h_3_SVM_emg = predict(SVM_model_emg{1}, emg_feature_test{3});
confusion_h_3_SVM_emg = confusionmat(test_label{3}, result_h_3_SVM_emg);
result_h_3_SVM_amode = predict(SVM_model_amode{1}, amode_feature_test{3});
confusion_h_3_SVM_amode = confusionmat(test_label{3}, result_h_3_SVM_amode);
result_h_3_SVM_fusion = predict(SVM_model_fusion{1}, fusion_feature_test{3});
confusion_h_3_SVM_fusion = confusionmat(test_label{3}, result_h_3_SVM_fusion);
%% LDA
% pos 2
result_h_2_LDA_emg = predict(LDA_model_emg{1}, emg_feature_test{2});
confusion_h_2_LDA_emg = confusionmat(test_label{2}, result_h_2_LDA_emg);
result_h_2_LDA_amode = predict(LDA_model_amode{1}, amode_feature_test{2});
confusion_h_2_LDA_amode = confusionmat(test_label{2}, result_h_2_LDA_amode);
result_h_2_LDA_fusion = predict(LDA_model_fusion{1}, fusion_feature_test{2});
confusion_h_2_LDA_fusion = confusionmat(test_label{2}, result_h_2_LDA_fusion);
% pos 3
result_h_3_LDA_emg = predict(LDA_model_emg{1}, emg_feature_test{3});
confusion_h_3_LDA_emg = confusionmat(test_label{3}, result_h_3_LDA_emg);
result_h_3_LDA_amode = predict(LDA_model_amode{1}, amode_feature_test{3});
confusion_h_3_LDA_amode = confusionmat(test_label{3}, result_h_3_LDA_amode);
result_h_3_LDA_fusion = predict(LDA_model_fusion{1}, fusion_feature_test{3});
confusion_h_3_LDA_fusion = confusionmat(test_label{3}, result_h_3_LDA_fusion);