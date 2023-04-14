K = 5;
for fold_num = 1 : 4
    emg_train_list = [];
    emg_test_list = [];
    amode_train_list = [];
    amode_test_list = [];
    for i = 1 : classes
        trainNum = floor(size(emg_data_set{i}, 1) * 1 / 4);
        switch fold_num
            case 1
                emg_data_test{i} = emg_data_set{i}(1 : trainNum, :);
                emg_data_train{i} = emg_data_set{i}(trainNum + 1 : end, :);
                amode_data_test{i} = amode_data_set{i}(1 : trainNum, :);
                amode_data_train{i} = amode_data_set{i}(trainNum + 1 : end, :);
            case 2
                emg_data_test{i} = emg_data_set{i}(trainNum + 1 : 2 * trainNum, :);
                emg_data_train{i} = [emg_data_set{i}(1 : trainNum, :); emg_data_set{i}(2 * trainNum + 1 : end, :)];
                amode_data_test{i} = amode_data_set{i}(trainNum + 1 : 2 * trainNum, :);
                amode_data_train{i} = [amode_data_set{i}(1 : trainNum, :); amode_data_set{i}(2 * trainNum + 1 : end, :)];
            case 3
                emg_data_test{i} = emg_data_set{i}(2 * trainNum + 1 : 3 * trainNum, :);
                emg_data_train{i} = [emg_data_set{i}(1 : 2 * trainNum, :); emg_data_set{i}(3 * trainNum + 1 : end, :)];
                amode_data_test{i} = amode_data_set{i}(2 * trainNum + 1 : 3 * trainNum, :);
                amode_data_train{i} = [amode_data_set{i}(1 : 2 * trainNum, :); amode_data_set{i}(3 * trainNum + 1 : end, :)];
            case 4
                num = floor(size(emg_data_set{i}, 1) * 3 / 4);
                emg_data_train{i} = emg_data_set{i}(1 : num, :);
                emg_data_test{i} = emg_data_set{i}(num + 1: end, :);
                amode_data_train{i} = amode_data_set{i}(1 : num, :);
                amode_data_test{i} = amode_data_set{i}(num + 1: end, :);
        end
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
    end
    train_sum = size(emg_train_list, 1);
    test_sum = size(emg_test_list, 1);
    emg_feature_train = emg_train_list(:, 1 : end - 1);
    emg_feature_test = emg_test_list(:, 1 : end - 1);
    amode_feature_train = amode_train_list(:, 1 : end - 1);
    amode_feature_test = amode_test_list(:,1 : end - 1);
    %% PCA 降维
    [coeff, score, latent, tsquared, explained, mu] = pca(amode_feature_train);
    per = cumsum(explained) ./ sum(explained);
    dimen = 20;
    amode_feature_train_main = score(:, 1 : dimen);
    score_test = (amode_feature_test - repmat(mu, test_sum, 1)) * coeff;
    amode_feature_test_main = score_test(:, 1 : dimen);
%     %% 归一化
%     % emg
%     [emg_feature_train, PS] = mapminmax(emg_feature_train', 0, 1);
%     gain = PS.gain;
%     xoffset = PS.xoffset;
%     emg_feature_train = emg_feature_train';
%     for i = 1 : size(emg_feature_test, 2)
%         emg_feature_test(:, i) = (emg_feature_test(:, i) - xoffset(i)) .* gain(i);
%     end
%     % amode
%     [amode_feature_train_main, PS] = mapminmax(amode_feature_train_main', 0, 1);
%     gain = PS.gain;
%     xoffset = PS.xoffset;
%     amode_feature_train_main = amode_feature_train_main';
%     for i = 1 : size(amode_feature_test_main, 2)
%         amode_feature_test_main(:, i) = (amode_feature_test_main(:, i) - xoffset(i)) .* gain(i);
%     end
    %% 融合
%     fusion_feature_train = [emg_feature_train, amode_feature_train_main];
%     fusion_feature_test = [emg_feature_test, amode_feature_test_main];
    
    fusion_feature_train = amode_feature_train_main;
    fusion_feature_test = amode_feature_test_main;
    
%     fusion_feature_train = emg_feature_train;
%     fusion_feature_test = emg_feature_test;
    
    label_emg = emg_train_list(:, end);
    label_amode = amode_train_list(:, end);
    fusion_train_label = emg_train_list(:, end);
    fusion_test_label = emg_test_list(:, end);
    %% 分类
    switch fold_num
        case 1
           %% KNN
            tic;
            KNN_model = fitcknn(fusion_feature_train, fusion_train_label, 'NumNeighbors', K);
            predict_label_KNN = predict(KNN_model, fusion_feature_test);
            confusion_KNN_1 = confusionmat(fusion_test_label, predict_label_KNN);
            toc;
            plotConfusion(normConfusion(confusion_KNN_1), 2);
            disp(getAcc(confusion_KNN_1));
           %% SVM
            tic;
            SVM_model = fitcecoc(fusion_feature_train, fusion_train_label);
            predict_label_SVM = predict(SVM_model, fusion_feature_test);
            confusion_SVM_1 = confusionmat(fusion_test_label, predict_label_SVM);
            toc;
            plotConfusion(normConfusion(confusion_SVM_1), 2);
            disp(getAcc(confusion_SVM_1));
           %% LDA
            tic;
            LDA_model = fitcdiscr(fusion_feature_train, fusion_train_label);
            predict_label_LDA = predict(LDA_model, fusion_feature_test);
            confusion_LDA_1 = confusionmat(fusion_test_label, predict_label_LDA);
            toc;
            plotConfusion(normConfusion(confusion_LDA_1), 2);
            disp(getAcc(confusion_LDA_1));
        case 2
           %% KNN
            tic;
            KNN_model = fitcknn(fusion_feature_train, fusion_train_label, 'NumNeighbors', K);
            predict_label_KNN = predict(KNN_model, fusion_feature_test);
            confusion_KNN_2 = confusionmat(fusion_test_label, predict_label_KNN);
            toc;
            plotConfusion(normConfusion(confusion_KNN_2), 2);
            disp(getAcc(confusion_KNN_2));
           %% SVM
            tic;
            SVM_model = fitcecoc(fusion_feature_train, fusion_train_label);
            predict_label_SVM = predict(SVM_model, fusion_feature_test);
            confusion_SVM_2 = confusionmat(fusion_test_label, predict_label_SVM);
            toc;
            plotConfusion(normConfusion(confusion_SVM_2), 2);
            disp(getAcc(confusion_SVM_2));
           %% LDA
            tic;
            LDA_model = fitcdiscr(fusion_feature_train, fusion_train_label);
            predict_label_LDA = predict(LDA_model, fusion_feature_test);
            confusion_LDA_2 = confusionmat(fusion_test_label, predict_label_LDA);
            toc;
            plotConfusion(normConfusion(confusion_LDA_2), 2);
            disp(getAcc(confusion_LDA_2));
        case 3
           %% KNN
            tic;
            KNN_model = fitcknn(fusion_feature_train, fusion_train_label, 'NumNeighbors', K);
            predict_label_KNN = predict(KNN_model, fusion_feature_test);
            confusion_KNN_3 = confusionmat(fusion_test_label, predict_label_KNN);
            toc;
            plotConfusion(normConfusion(confusion_KNN_3), 2);
            disp(getAcc(confusion_KNN_3));
           %% SVM
            tic;
            SVM_model = fitcecoc(fusion_feature_train, fusion_train_label);
            predict_label_SVM = predict(SVM_model, fusion_feature_test);
            confusion_SVM_3 = confusionmat(fusion_test_label, predict_label_SVM);
            toc;
            plotConfusion(normConfusion(confusion_SVM_3), 2);
            disp(getAcc(confusion_SVM_3));
           %% LDA
            tic;
            LDA_model = fitcdiscr(fusion_feature_train, fusion_train_label);
            predict_label_LDA = predict(LDA_model, fusion_feature_test);
            confusion_LDA_3 = confusionmat(fusion_test_label, predict_label_LDA);
            toc;
            plotConfusion(normConfusion(confusion_LDA_3), 2);
            disp(getAcc(confusion_LDA_3));
        case 4
           %% KNN
            tic;
            KNN_model = fitcknn(fusion_feature_train, fusion_train_label, 'NumNeighbors', K);
            predict_label_KNN = predict(KNN_model, fusion_feature_test);
            confusion_KNN_4 = confusionmat(fusion_test_label, predict_label_KNN);
            toc;
            plotConfusion(normConfusion(confusion_KNN_4), 2);
            disp(getAcc(confusion_KNN_4));
           %% SVM
            tic;
            SVM_model = fitcecoc(fusion_feature_train, fusion_train_label);
            predict_label_SVM = predict(SVM_model, fusion_feature_test);
            confusion_SVM_4 = confusionmat(fusion_test_label, predict_label_SVM);
            toc;
            plotConfusion(normConfusion(confusion_SVM_4), 2);
            disp(getAcc(confusion_SVM_4));
           %% LDA
            tic;
            LDA_model = fitcdiscr(fusion_feature_train, fusion_train_label);
            predict_label_LDA = predict(LDA_model, fusion_feature_test);
            confusion_LDA_4 = confusionmat(fusion_test_label, predict_label_LDA);
            toc;
            plotConfusion(normConfusion(confusion_LDA_4), 2);
            disp(getAcc(confusion_LDA_4));
    end
end