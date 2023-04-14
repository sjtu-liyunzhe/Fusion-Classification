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
colors_hybrid{1} = {'#9AFF9A', '#90EE90', '#7CCD7C', '#00FF7F', '#00EE76',...
    '#00CD66', '#00FF00', '#00EE00', '#00CD00', '#7FFF00'};
colors_hybrid{2} = {'#FFFF00', '#EEEE00', '#CDCD00', '#FFD700', '#EEC900',...
    '#CDAD00', '#FFC125', '#EEB422', '#CD9B1D', '#FFB90F'};
colors_hybrid{3} = {'#FF00FF', '#EE82EE', '#DDA0DD', '#DA70D6', '#BA55D3',...
    '#9932CC', '#9400D3', '#8A2BE2', '#A020F0', '#9370DB'};
colors = {'#65C2A4', '#8D9FCA', '#A6D753', '#E4C493', '#FB8D61',...
    '#E789C3', '#FED92E', '#B3B3B3', '#98F5FF', '#FF0000'};
shapes = {'o', 'x', '.'};
points = {};
%% EMG
figure();
for i = 1 : 3
    for m = 1 : 10
        points{m} = [];
    end
    length = size(test_label{i}, 1);
%     colors = colors_hybrid{i};
    for j = 1 : length
        class_num = test_label{i}(j);
        points{class_num} = [points{class_num}; main_emg_feature_test{i}(j, :)];
    end
    for j = 1 : 10
        tmp_color = colors{j};
        tmp_shape = shapes{i};
        point = points{j};
        scatter3(point(:, 1), point(:, 2), point(:, 3), tmp_shape, 'MarkerEdgeColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end
% legend('1', '2', '3', '4', '5', '6', '7', '8', '9', '10',...
%     '1*');
%% Amode
figure();
for i = 1 : 3
    for m = 1 : 10
        points{m} = [];
    end
    length = size(test_label{i}, 1);
%     colors = colors_hybrid{i};
    for j = 1 : length
        class_num = test_label{i}(j);
        points{class_num} = [points{class_num}; main_amode_feature_test{i}(j, :)];
    end
    for j = 1 : 10
        tmp_color = colors{j};
        tmp_shape = shapes{i};
        point = points{j};
        scatter3(point(:, 1), point(:, 2), point(:, 3), tmp_shape, 'MarkerEdgeColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end
%% fusion
figure();
for i = 1 : 3
    for m = 1 : 10
        points{m} = [];
    end
    length = size(test_label{i}, 1);
%     colors = colors_hybrid{i};
    for j = 1 : length
        class_num = test_label{i}(j);
        points{class_num} = [points{class_num}; main_fusion_feature_test{i}(j, :)];
    end
    for j = 1 : 10
        tmp_color = colors{j};
        tmp_shape = shapes{i};
        point = points{j};
        scatter3(point(:, 1), point(:, 2), point(:, 3), tmp_shape, 'MarkerEdgeColor', tmp_color);
        hold on;
    end
    xlabel('\alpha'); ylabel('\beta'), zlabel('\gamma');
end