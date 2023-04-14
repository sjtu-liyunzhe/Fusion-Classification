clear; clc;
%%
dir = {};
for i = 1 : 12
    dir{i} = "\trial_" + string(i);
end
time = {};
order = "new_2";
if order == "old"
%% old
    time{1} = "21_18_30_33";
    time{2} = "21_18_31_38";
    time{3} = "21_18_32_55";
    time{4} = "21_18_35_41";
    time{5} = "21_18_37_30";
    time{6} = "21_18_38_43";
    time{7} = "21_18_40_42";
    time{8} = "21_18_42_15";
    root = "emg_data_old";
else
    if order == "new"
%% new
        time{1} = "21_19_09_53";
        time{2} = "21_19_12_34";
        time{3} = "21_19_13_56";
        time{4} = "21_19_15_11";
        time{5} = "21_19_16_24";
        time{6} = "21_19_17_39";
        time{7} = "21_19_19_17";
        time{8} = "21_19_20_18";
        root = "emg_data_new";
    else
        if order == "new_2"
            time{1} = "22_21_07_42";
            time{2} = "22_21_09_06";
            time{3} = "22_21_10_09";
            time{4} = "22_21_11_28";
            time{5} = "22_21_12_40";
            time{6} = "22_21_14_01";
            time{7} = "22_21_15_35";
            time{8} = "22_21_17_26";
            root = "emg_data_new_2";
        end
    end
end
%%
classes = 10;
DS_len = 52;
EMG_cell = {}; EMG_label_cell = {}; imu_data_cell = {}; imu_label_cell = {};
emg_data_set_cell = {}; imu_data_set_cell = {}; data_set_cell = {};
for i = 1 : 8
    [EMG_cell{i}, EMG_label_cell{i}, imu_data_cell{i}, imu_label_cell{i}, ...
        emg_data_set_cell{i}, imu_data_set_cell{i}, data_set_cell{i}] = buildDataSet(root, dir{i}, time{i}, 0, DS_len);
end
%% 拼接EMG
EMG = {};
EMG_label = {};
for i = 1 : 4
    EMG{i} = [];
    EMG_label{i} = [];
    for j = 1 : 8
        EMG_cell{j}{i} = EMG_cell{j}{i}(1 : size(EMG_label_cell{j}{i}, 2));
        EMG{i} = [EMG{i}; EMG_cell{j}{i}];
        EMG_label{i} = [EMG_label{i}, EMG_label_cell{j}{i}];
    end
end
figure();
for i = 4 : -1 : 1
    plot(EMG{i});
    hold on;
end
plot(EMG_label{1} * 0.1, 'linewidth', 1.2);
% legend('CH0', 'CH1', 'CH2', 'CH3', 'Label');
legend('CH4', 'CH3', 'CH2', 'CH1', 'Label');
ylabel('EMG / mV');
xlim([0, size(EMG{2}, 1)]);
FFT_plot(EMG{2}, size(EMG{2}, 1), 1000);
%%
for i = 1 : 10
    emg_data_set{i} = [];
    for j = 1 : 8
        emg_data_set{i} = [emg_data_set{i}; emg_data_set_cell{j}{i}'];       % 单源EMG
    end
end