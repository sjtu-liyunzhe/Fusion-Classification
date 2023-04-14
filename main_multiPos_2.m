%%
K = 5;
%% 划分数据集
% pos 1 90 dec
emg_data_set{1} = emg_data_set_1; amode_data_set{1} = amode_data_set_1; imu_data_set{1} = imu_data_set_1;
% pos 2 0 dec
emg_data_set{2} = emg_data_set_2; amode_data_set{2} = amode_data_set_2; imu_data_set{2} = imu_data_set_2;
% pos 3 -90 dec
emg_data_set{3} = emg_data_set_3; amode_data_set{3} = amode_data_set_3; imu_data_set{3} = imu_data_set_3;
for i = 1 : 3
    [emg_feature_train{i}, emg_feature_test{i}, amode_feature_train{i}, amode_feature_test{i},...
        fusion_feature_train{i}, fusion_feature_test{i}, train_label{i}, test_label{i}, imu_acc_test{i}] = divideDataSet(emg_data_set{i}, amode_data_set{i}, imu_data_set{i});
end
%% 训练3个分类器
for i = 1 : 3
    % KNN
    KNN_model_emg{i} = fitcknn(emg_feature_train{i}, train_label{i}, 'NumNeighbors', K);
    KNN_model_amode{i} = fitcknn(amode_feature_train{i}, train_label{i}, 'NumNeighbors', K);
    KNN_model_fusion{i} = fitcknn(fusion_feature_train{i}, train_label{i}, 'NumNeighbors', K);
    % SVM
    SVM_model_emg{i} = fitcecoc(emg_feature_train{i}, train_label{i});
    SVM_model_amode{i} = fitcecoc(amode_feature_train{i}, train_label{i});
    SVM_model_fusion{i} = fitcecoc(fusion_feature_train{i}, train_label{i});
    % LDA
    LDA_model_emg{i} = fitcdiscr(emg_feature_train{i}, train_label{i});
    LDA_model_amode{i} = fitcdiscr(amode_feature_train{i}, train_label{i});
    LDA_model_fusion{i} = fitcdiscr(fusion_feature_train{i}, train_label{i});
end
