% 假设有 5 个样本，每个样本有 5 个数据，存储在矩阵 data 中
data = [0.738 0.88467 0.76467 0.77533 0.721;
        0.1   0.2     0.3     0.4     0.5;
        0.2   0.4     0.6     0.8     1.0;
        0.3   0.6     0.9     1.2     1.5;
        0.4   0.8     1.2     1.6     2.0];

% 计算最后一列数据的标准差
std_last_column = std(data(:, end));

% 画柱形图，并给最后一列加误差棒
bar(data);
hold on;
errorbar(size(data, 1) + 0.5, mean(data(:, end)), std_last_column, 'r', 'LineWidth', 2);
hold off;

% 设置 x 轴标签和图例
xticks(1:size(data, 1));
xticklabels({'Sample 1', 'Sample 2', 'Sample 3', 'Sample 4', 'Sample 5'});
legend('Data 1', 'Data 2', 'Data 3', 'Data 4', 'Data 5', 'Last column');
