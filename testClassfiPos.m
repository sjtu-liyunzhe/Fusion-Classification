clear; clc;
%%
pos{1} = [0; -9.81; 0];
pos{2} = [-9.81; 0; 0];
pos{3} = [0; 9.81; 0];
%%
% pos1 90 dec
path{1} = "C:\Users\User\Desktop\Data\20230303\90\TrainData\03_16_34_16\Channel_0";
name{1} = "IMU 03_16_34_16 Exp.txt";
% pos2 0 dec
path{2} = "C:\Users\User\Desktop\Data\20230303\0\TrainData\03_16_45_01\Channel_0";
name{2} = "IMU 03_16_45_01 Exp.txt";
% pos3 -90dec
path{3} = "C:\Users\User\Desktop\Data\20230303\-90\TrainData\03_17_01_53\Channel_0";
name{3} = "IMU 03_17_01_53 Exp.txt";
for i = 1 : 3
    imu_data{i} = load(char(path{i} + "\" + name{i}));
end
%% 滤波
N = 5;  % 阶数
wo = 2.5;    % 截止频率
WN = [5 50];
% [b, a] = butter(N, WN / (100 / 2));
[b, a] = butter(N, wo / (100 / 2), 'low');
% [b, a] = butter(N, wo / (100 / 2), 'high');
for k = 1 : 3
    for i = 1 : 3
        imu_data{k}(:, i) = filter(b, a, imu_data{k}(:, i));
    end
    figure();
    plot(imu_data{k});
    legend("x", "y", "z");
    FFT_plot(imu_data{k}(:, 1), size(imu_data{k}, 1), 100);
end
%%
timeWindow = 200;
strideWindow = 50;
DS_len = 50;
w_s = 120 / 1000;
acc_cell = {};
for i = 1 : 3
    acc_cell{i} = [];
    iimu = imu_data{i}(100 : end, :);
    for j = 0 : DS_len
        meanACC = featureMeanACC(iimu(strideWindow * w_s * j + 1: strideWindow * w_s * j + timeWindow * w_s, :));
        acc_cell{i} = [acc_cell{i}, meanACC];
    end
end
%% 分类
results = {};
for i = 1 : 3
    results{i} = [];
    for j = 1 : length(acc_cell{i})
        tmp_acc = acc_cell{i}(:, j);
        dis = [];
        min_dis = intmax;
        predict_label = -1;
        for k = 1 : 3
            dis(k) = norm(tmp_acc - pos{k});
            if(dis(k) < min_dis)
                predict_label = k;
                min_dis = dis(k);
            end
        end
        results{i}(:, end + 1) = predict_label;
    end
end