% Input: dir, time, order: 0 正序, 1 逆序
function [EMG, EMG_label, imu_data, imu_label, emg_data_set, imu_data_set, data_set] = buildMultiPosDataSet(root, pos, dir, time, order, DS_len)
    EMG = {}; IMU = {}; emg_data_set = {}; imu_data_set = {};
    fs = 1000;
    scale = 0.02235174 * 16 * 0.001;
%     path = ".\data\" + dir + "\";
    path = ".\" + root + "\" + pos + "\" + dir + "\";
    tailPath = "EMG " + time + " Exp.txt";
    EMG = {};
    for i = 1 : 4
        str = path + "Channel_" + string(i - 1) + "\" + tailPath;
        emg = load(char(str));
        EMG{i} = emg * scale;
    end
    %% 滤波
    % 带阻
%     f1 = 110;
%     f2 = 126;
%     Wn = [f1, f2] ./ (fs / 2);
%     N = 8;
%     Rp = 3;     % 通带最大衰减
%     Rs = 60;        % 阻带最下衰减
%     [b_c, a_c] = ellip(N, Rp, Rs, Wn, 'stop');
%     for i = 1 : 4
%         EMG{i} = filter(b_c, a_c, EMG{i});
%     end
    % 陷波
%     N     = 20;    % Order
%     BW    = 30;  % Bandwidth    带宽不能小
%     Apass = 1;     % Bandwidth Attenuation
%     [b_c, a_c] = iircomb(fs / 118, BW / (fs / 2), Apass);
%     for i = 1 : 4
%         EMG{i} = filter(b_c, a_c, EMG{i});
%     end
%     % 高通
%     N = 5;  % 阶数
%     wo = 20;    % 截止频率
%     WN = [20 450];
%     [b, a] = butter(N, wo / (fs / 2), 'high');
%     % [b, a] = butter(N, WN / (fs / 2));
%     for i = 1 : 4
%         EMG{i} = filter(b, a, EMG{i});
%     end
    %% 构建label
    label_tailPath = "EMG_Label " + time + " Exp.txt";
    label_cell = {};
    for i = 1 : 4
        str = path + "Channel_" + string(i - 1) + "\" + label_tailPath;
        tmp = load(char(str));
        label_cell{i} = tmp;
    end
    EMG_label = {};
    for i = 1 : 4
        tmp_label = [];
        if(order == 0)
            cnt = 0;
        else
            cnt = 11;
        end
        last = 1;
        for num = label_cell{i}'
            for j = last : num + 1
                tmp_label(:, end + 1) = cnt;
            end
            last = num + 2;
            if(order == 0)
                cnt = cnt + 1;     % 正序
            else
                cnt = cnt - 1;      % 逆序
            end
        end
        EMG_label{i} = tmp_label;
    end
    %%
    figure();
    for i = 4 :-1: 1
        plot(EMG{i});
        hold on;
    end
    plot(EMG_label{1} * 0.1, 'linewidth', 1.2);
%     legend('CH0', 'CH1', 'CH2', 'CH3', 'Label');
    legend('CH4', 'CH3', 'CH2', 'CH1', 'Label');
    ylabel('EMG / mV');
    xlim([0, size(EMG{2}, 1)]);
    ylim([-1, 1]);
    FFT_plot(EMG{1}, size(EMG{1}, 1), 1000);
    %% IMU 数据
    fs_imu = 115;
    imu_path = ".\" + root + "\" + pos + "\" + dir + "\Channel_0\IMU " + time + " Exp.txt";
    imu_label_path = ".\" + root + "\" + pos + "\"+ dir + "\Channel_0\IMU_Label " + time + " Exp.txt";
    imu_data = load(char(imu_path));
    imu_label_arr = load(char(imu_label_path));
    %% 滤波
    N = 5;  % 阶数
    wo = 2.5;    % 截止频率
    [b, a] = butter(N, wo / (100 / 2), 'low');
    for i = 1 : 3
        imu_data(:, i) = filter(b, a, imu_data(:, i));
    end
    FFT_plot(imu_data(:, 1), size(imu_data(:, 1), 1), 100);
    %% IMU label
    imu_label = [];
    if(order == 0)
        cnt = 0;
    else
        cnt = 11;
    end
    last = 1;
    for num = imu_label_arr'
        for j = last : num + 1
            imu_label(:, end + 1) = cnt;
        end
        last = num + 2;
        if(order == 0)
            cnt  = cnt + 1;     % 正序
        else
            cnt = cnt - 1;      % 逆序
        end
    end
    %%
    figure();
    plot(imu_data(:, 1));
    hold on;
    plot(imu_data(:, 2));
    plot(imu_data(:, 3), 'color', '#77AC30');
    plot(imu_label, 'linewidth', 1.4);
    legend("accx", "accy", "accz", "label");
    %% 构建源数据集
    classes = 10;
    timeWindow = 200;
    strideWindow = 50;
    data_set = {};
    data_test = {};
    raw_set = {};
    imu_set = {};
    for i = 1 : classes
        raw_set{i} = {};
        for j = 1 : 4
            raw_set{i}{j} = [];
        end
    end
    for i = 1 : 4
        emg = EMG{i};
        label = EMG_label{i};
        cnt = 0;
        for j = 1 : size(label, 2)
            if(label(j) > 0 && label(j) < 11)
                raw_set{label(j)}{i}(end + 1, :) = emg(j);
                cnt = cnt + 1;
            end
        end
    end
    for i = 1 : classes
        imu_set{i} = {};
        for j = 1 : 3
            imu_set{i}{j} = [];     % accx, accy, accz
        end
    end
    for i = 1 : 3
        % trial_1
        tmp = imu_data(:, i);
        label = imu_label;
        cnt = 0;
        for j = 1 : size(label, 2)
            if(label(j) > 0 && label(j) < 11)
                imu_set{label(j)}{i}(end + 1, :) = tmp(j);
                cnt = cnt + 1;
            end
        end
    end
    %% 特征提取
    w_s = fs_imu / fs;
    % classes = 5;
    for c = 1 : classes
        data = raw_set{c};
        tmp_imu_data = imu_set{c};
        feature_c = {};
        feature_imu = {};
        % EMG特征提取
        for i = 1 : 4
            iemg = data{i};
            iemg = iemg(1000 : end - 1000);
            length = floor((size(iemg, 1) - timeWindow) / strideWindow);
            fprintf("EMG class %d number of sample: %d %d\n", c, size(iemg, 1), length);
            feature_i = [];
            featureStack = [];
            for j = 0 : DS_len
                rms = featureRMS(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :));
                mav = featureMAV(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :));
                zc = featureZC(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :));
                ssc = featureSSC(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :));
                wl = featureWL(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :));
                arc = aryule(iemg(strideWindow * j + 1: strideWindow * j + timeWindow, :), 5);
                featureStack = [rms, mav, wl, zc, ssc];
%                 featureStack = [rms, mav, wl, zc, ssc, arc(:, 2)', arc(:, 3)', arc(:, 4)', arc(:, 5)', arc(:, 6)'];
                feature_i(:, end + 1) = featureStack';
            end
            feature_c{i} = feature_i;
        end
        % IMU特征提取，计算三轴加速度均值
        iimu = [tmp_imu_data{1}, tmp_imu_data{2}, tmp_imu_data{3}];
        iimu = iimu(fs_imu : end - fs_imu, :);
        length = floor((size(iimu, 1) - (timeWindow * w_s)) / (strideWindow * w_s));
        fprintf("IMU class %d number of sample: %d %d\n", c, size(iimu, 1), length);
        feature_imu = [];
        for j = 0 :DS_len
            meanACC = featureMeanACC(iimu(floor(strideWindow * w_s) * j + 1: floor(strideWindow * w_s) * j + floor(timeWindow * w_s), :));
            feature_imu(:, end + 1) = meanACC';
        end
        emg_data_set{c} = [feature_c{1}; feature_c{2}; feature_c{3}; feature_c{4}];
        imu_data_set{c} = feature_imu;
        data_set{c} = [feature_c{1}; feature_c{2}; feature_c{3}; feature_c{4}; feature_imu];
    end
end