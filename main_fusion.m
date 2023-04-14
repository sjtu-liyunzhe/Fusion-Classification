clear; clc;
%%
trialNum = 16;
st = 1;
ed = 8;
dir = {};
for i = st : ed
    dir{i} = "\trial_" + string(i);
end
time = {};
%% 无耦合剂
% time{1} = "22_21_07_42";
% time{2} = "22_21_09_06";
% time{3} = "22_21_10_09";
% time{4} = "22_21_11_28";
% time{5} = "22_21_12_40";
% time{6} = "22_21_14_01";
% time{7} = "22_21_15_35";
% time{8} = "22_21_17_26";
% root = "emg_data_new_2";
%% 正常
time{1} = "23_00_26_06";
time{2} = "23_00_28_21";
time{3} = "23_00_29_32";
time{4} = "23_00_31_37";
time{5} = "23_00_33_17";
time{6} = "23_00_34_21";
time{7} = "23_00_35_44";
time{8} = "23_00_37_04";
root = "fusion_data";
%%
classes = 10;
DS_len = 52;
EMG_cell = {}; EMG_label_cell = {}; imu_data_cell = {}; imu_label_cell = {};
emg_data_set_cell = {}; imu_data_set_cell = {}; data_set_cell = {};
for i = st : ed
    [EMG_cell{i}, EMG_label_cell{i}, imu_data_cell{i}, imu_label_cell{i}, ...
        emg_data_set_cell{i}, imu_data_set_cell{i}, data_set_cell{i}] = buildDataSet(root, dir{i}, time{i}, 0, DS_len);
end
%% 拼接EMG
EMG = {};
EMG_label = {};
for i = 1 : 4
    EMG{i} = [];
    EMG_label{i} = [];
    for j = st : ed
        EMG_cell{j}{i} = EMG_cell{j}{i}(1 : size(EMG_label_cell{j}{i}, 2));
        EMG{i} = [EMG{i}; EMG_cell{j}{i}];
        EMG_label{i} = [EMG_label{i}, EMG_label_cell{j}{i}];
    end
end
figure();
for i = 1 : 4
    plot(EMG{i});
    hold on;
end
plot(EMG_label{1} * 0.1, 'linewidth', 1.2);
legend('CH0', 'CH1', 'CH2', 'CH3', 'Label');
ylabel('EMG / mV');
xlim([0, size(EMG{2}, 1)]);
FFT_plot(EMG{2}, size(EMG{2}, 1), 1000);
%%
for i = 1 : classes
    emg_data_set{i} = [];
    for j = st : ed
        emg_data_set{i} = [emg_data_set{i}; emg_data_set_cell{j}{i}'];       % 单源EMG
%         data_set{i} = [data_set{i}, data_set_cell{j}{i}];           % 融合数据
    end
end
%%
classes = 10;
A_arr_cell = {};
for i = st : ed
    [A_arr_cell{i}, data_set_cell{i}] = buildAmodeSet(root, dir{i}, time{i}, 0, DS_len);
end
%%
for i = st : ed
    plotAmode(dir{i}, time{i}, "trial_" + string(i), 1000);
end
%%
feature_arr = [];
label = [];
for i = 1 : 10
    amode_data_set{i} = [];
    for j = st : ed
        amode_data_set{i} = [amode_data_set{i}; data_set_cell{j}{i}];
    end
end
for j = st : ed
    for i = 1 : 10
        feature_arr = [feature_arr; data_set_cell{j}{i}];
        len = size(data_set_cell{j}{i}, 1);
        tmp = ones(len, 1) * i;
        label = [label; tmp];
    end
end