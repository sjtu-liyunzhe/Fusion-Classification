%%
% pos{1} = [0; -9.81; 0];
% pos{1} = [-9.81; -9.81; 0];
% pos{2} = [-9.81; 0; 0];
% pos{3} = [0; 9.81; 0];
pos{1} = [-9.81; -9.81; 0];
pos{2} = [-9.81; 0; 0];
pos{3} = [0; 5; 0];
%% 合并测试集
emg_feature_test_sum = [];
amode_feature_test_sum = [];
fusion_feature_test_sum = [];
imu_acc_test_sum = [];
test_label_sum = [];
for i = 1 : 3
    emg_feature_test_sum = [emg_feature_test_sum; emg_feature_test{i}];
    amode_feature_test_sum = [amode_feature_test_sum; amode_feature_test{i}];
    fusion_feature_test_sum = [fusion_feature_test_sum; fusion_feature_test{i}];
    imu_acc_test_sum = [imu_acc_test_sum; imu_acc_test{i}];
    test_label_sum = [test_label_sum; test_label{i} + (i - 1) * 10];
end
test_len = length(imu_acc_test_sum);
%% 分类
result_KNN_emg = [];
result_KNN_amode = [];
result_KNN_fusion = [];
result_SVM_emg = [];
result_SVM_amode = [];
result_SVM_fusion = [];
result_LDA_emg = [];
result_LDA_amode = [];
result_LDA_fusion = [];
for i = 1 : test_len
    % 计算位置
    tmp_acc = imu_acc_test_sum(i, :)';
    dis = [];
    min_dis = intmax;
    pos_index = -1;
    for k = 1 : 3
        dis(k) = norm(tmp_acc - pos{k});
        if(dis(k) < min_dis)
            pos_index = k;
            min_dis = dis(k);
        end
    end
    % 选择分类器
    % KNN
    KNN_model_emg_this_pos = KNN_model_emg{pos_index};
    KNN_model_amode_this_pos = KNN_model_amode{pos_index};
    KNN_model_fusion_this_pos = KNN_model_fusion{pos_index};
    % SVM
    SVM_model_emg_this_pos = SVM_model_emg{pos_index};
    SVM_model_amode_this_pos = SVM_model_amode{pos_index};
    SVM_model_fusion_this_pos = SVM_model_fusion{pos_index};
    % LDA
    LDA_model_emg_this_pos = LDA_model_emg{pos_index};
    LDA_model_amode_this_pos = LDA_model_amode{pos_index};
    LDA_model_fusion_this_pos = LDA_model_fusion{pos_index};
    % 预测
    % KNN
    predict_label_KNN_emg_this_pos = predict(KNN_model_emg_this_pos, emg_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_KNN_emg = [result_KNN_emg; predict_label_KNN_emg_this_pos];
    predict_label_KNN_amode_this_pos = predict(KNN_model_amode_this_pos, amode_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_KNN_amode = [result_KNN_amode; predict_label_KNN_amode_this_pos];
    predict_label_KNN_fusion_this_pos = predict(KNN_model_fusion_this_pos, fusion_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_KNN_fusion = [result_KNN_fusion; predict_label_KNN_fusion_this_pos];
    % SVM
    predict_label_SVM_emg_this_pos = predict(SVM_model_emg_this_pos, emg_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_SVM_emg = [result_SVM_emg; predict_label_SVM_emg_this_pos];
    predict_label_SVM_amode_this_pos = predict(SVM_model_amode_this_pos, amode_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_SVM_amode = [result_SVM_amode; predict_label_SVM_amode_this_pos];
    predict_label_SVM_fusion_this_pos = predict(SVM_model_fusion_this_pos, fusion_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_SVM_fusion = [result_SVM_fusion; predict_label_SVM_fusion_this_pos];
    % LDA
    predict_label_LDA_emg_this_pos = predict(LDA_model_emg_this_pos, emg_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_LDA_emg = [result_LDA_emg; predict_label_LDA_emg_this_pos];
    predict_label_LDA_amode_this_pos = predict(LDA_model_amode_this_pos, amode_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_LDA_amode = [result_LDA_amode; predict_label_LDA_amode_this_pos];
    predict_label_LDA_fusion_this_pos = predict(LDA_model_fusion_this_pos, fusion_feature_test_sum(i, :)) + (pos_index - 1) * 10;
    result_LDA_fusion = [result_LDA_fusion; predict_label_LDA_fusion_this_pos];
end
%% 计算混淆矩阵
% KNN
confusion_30_KNN_emg = confusionmat(result_KNN_emg, test_label_sum);
confusion_30_KNN_amode = confusionmat(result_KNN_amode, test_label_sum);
confusion_30_KNN_fusion = confusionmat(result_KNN_fusion, test_label_sum);
% SVM
confusion_30_SVM_emg = confusionmat(result_SVM_emg, test_label_sum);
confusion_30_SVM_amode = confusionmat(result_SVM_amode, test_label_sum);
confusion_30_SVM_fusion = confusionmat(result_SVM_fusion, test_label_sum);
% LDA
confusion_30_LDA_emg = confusionmat(result_LDA_emg, test_label_sum);
confusion_30_LDA_amode = confusionmat(result_LDA_amode, test_label_sum);
confusion_30_LDA_fusion = confusionmat(result_LDA_fusion, test_label_sum);