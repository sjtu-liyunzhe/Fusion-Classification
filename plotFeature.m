%% 画特征分布图
dimen = 3;
main_emg_feature_test = {};
main_amode_feature_test = {};
main_fusion_feature_test = {};
% PCA降维
for i = 1 : 3
    [coeff, score, latent, tsquared, explained, mu] = pca(emg_feature_test{i});
    main_emg_feature_test{i} = score(:, 1 : dimen);
    [coeff, score, latent, tsquared, explained, mu] = pca(amode_feature_test{i});
    main_amode_feature_test{i} = score(:, 1 : dimen);
    [coeff, score, latent, tsquared, explained, mu] = pca(fusion_feature_test{i});
    main_fusion_feature_test{i} = score(:, 1 : dimen);
end
%%
colors = {'#65C2A4', '#8D9FCA', '#A6D753', '#E4C493', '#FB8D61',...
    '#E789C3', '#FED92E', '#B3B3B3', '#98F5FF', '#FF0000'};
shapes = {'.', 'x', '*'};
% EMG
for i = 1 : 3
    length = size(test_label{i}, 1);
    figure();
    for j = 1 : length
        tmp_color = colors{test_label{i}(j)};
        tmp_shape = shapes{i};
        point = main_emg_feature_test{i}(j, :);
        scatter3(point(1), point(2), point(3), tmp_shape, 'MarkerEdgeColor', tmp_color, 'MarkerFaceColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end
% Amode
for i = 1 : 3
    length = size(test_label{i}, 1);
    figure();
    for j = 1 : length
        tmp_color = colors{test_label{i}(j)};
        tmp_shape = shapes{i};
        point = main_amode_feature_test{i}(j, :);
        scatter3(point(1), point(2), point(3), tmp_shape, 'MarkerEdgeColor', tmp_color, 'MarkerFaceColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end
% fusion
for i = 1 : 3
    length = size(test_label{i}, 1);
    figure();
    for j = 1 : length
        tmp_color = colors{test_label{i}(j)};
        tmp_shape = shapes{i};
        point = main_fusion_feature_test{i}(j, :);
        scatter3(point(1), point(2), point(3), tmp_shape, 'MarkerEdgeColor', tmp_color, 'MarkerFaceColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end