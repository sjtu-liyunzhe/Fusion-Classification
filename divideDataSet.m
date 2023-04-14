% imu不用打标签，只给emg和amode打
function [emg_feature_train, emg_feature_test, amode_feature_train, amode_feature_test,...
    fusion_feature_train, fusion_feature_test, train_label, test_label, imu_acc_test] = divideDataSet(emg_data_set, amode_data_set, imu_data_set)
    emg_train_list = [];
    emg_test_list = [];
    amode_train_list = [];
    amode_test_list = [];
    imu_train_list = [];
    imu_test_list = [];
    classes = 10;
    for i = 1 : classes
            trainNum = floor(size(emg_data_set{i}, 1) * 3 / 4);
            emg_data_train{i} = emg_data_set{i}(1 : trainNum, :);
            emg_data_test{i} = emg_data_set{i}(trainNum + 1 : end, :);
            amode_data_train{i} = amode_data_set{i}(1 : trainNum, :);
            amode_data_test{i} = amode_data_set{i}(trainNum + 1 : end, :);
            imu_data_train{i} = imu_data_set{i}(1 : trainNum, :);
            imu_data_test{i} = imu_data_set{i}(trainNum + 1 : end, :);
            % emg
            arr = emg_data_train{i};
            arr_test = emg_data_test{i};
            for j = 1 : size(emg_data_train{i}, 1)
                emg_train_list(end + 1, :) = [arr(j, :), i];
            end
            for j = 1 : size(emg_data_test{i}, 1)
                emg_test_list(end + 1, :) = [arr_test(j, :), i];
            end
            % amode
            arr = amode_data_train{i};
            arr_test = amode_data_test{i};
            for j = 1 : size(amode_data_train{i}, 1)
                amode_train_list(end + 1, :) = [arr(j, :), i];
            end
            for j = 1 : size(amode_data_test{i}, 1)
                amode_test_list(end + 1, :) = [arr_test(j, :), i];
            end
            % imu
            arr = imu_data_train{i};
            arr_test = imu_data_test{i};
            for j = 1 : size(amode_data_train{i}, 1)
                imu_train_list(end + 1, :) = arr(j, :);
            end
            for j = 1 : size(amode_data_test{i}, 1)
                imu_test_list(end + 1, :) = arr_test(j, :);
            end
    end
    train_sum = size(emg_train_list, 1);
    test_sum = size(emg_test_list, 1);
    emg_feature_train = emg_train_list(:, 1 : end - 1);
    emg_feature_test = emg_test_list(:, 1 : end - 1);
    % 归一化
%     [emg_feature_train, PS] = mapminmax(emg_feature_train', 0, 1);
%     gain = PS.gain;
%     xoffset = PS.xoffset;
%     emg_feature_train = emg_feature_train';
%     for i = 1 : size(emg_feature_test, 2)
%         emg_feature_test(:, i) = (emg_feature_test(:, i) - xoffset(i)) .* gain(i);
%     end
    amode_feature_train = amode_train_list(:, 1 : end - 1);
    amode_feature_test = amode_test_list(:,1 : end - 1);
    imu_acc_train = imu_train_list;
    imu_acc_test = imu_test_list;
    %% PCA 降维
    [coeff, score, latent, tsquared, explained, mu] = pca(amode_feature_train);
    per = cumsum(explained) ./ sum(explained);
    dimen = 20;
    amode_feature_train_main = score(:, 1 : dimen);
    score_test = (amode_feature_test - repmat(mu, test_sum, 1)) * coeff;
    amode_feature_test_main = score_test(:, 1 : dimen);
    %%
    fusion_feature_train = [emg_feature_train, amode_feature_train_main];
    fusion_feature_test = [emg_feature_test, amode_feature_test_main];
    amode_feature_train = amode_feature_train_main;
    amode_feature_test = amode_feature_test_main;
    label_emg = emg_train_list(:, end);
    label_amode = amode_train_list(:, end);
    train_label = emg_train_list(:, end);
    test_label = emg_test_list(:, end);
end