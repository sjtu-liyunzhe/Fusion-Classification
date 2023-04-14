%%
classes = 10;
DS_len = 49;
% pos 1 90 dec
EMG_cell_1 = {}; EMG_label_cell_1 = {}; imu_data_cell_1 = {}; imu_label_cell_1 = {};
emg_data_set_cell_1 = {}; imu_data_set_cell_1 = {}; data_set_cell_1 = {};
% pos 2 0 dec
EMG_cell_2 = {}; EMG_label_cell_2 = {}; imu_data_cell_2 = {}; imu_label_cell_2 = {};
emg_data_set_cell_2 = {}; imu_data_set_cell_2 = {}; data_set_cell_2 = {};
% pos 3 -90 dec
EMG_cell_3 = {}; EMG_label_cell_3 = {}; imu_data_cell_3 = {}; imu_label_cell_3 = {};
emg_data_set_cell_3 = {}; imu_data_set_cell_3 = {}; data_set_cell_3 = {};
for i = st : 1 :ed
    % pos 1 90dec
    [EMG_cell_1{i}, EMG_label_cell_1{i}, imu_data_cell_1{i}, imu_label_cell_1{i}, ...
        emg_data_set_cell_1{i}, imu_data_set_cell_1{i}, data_set_cell_1{i}] = buildMultiPosDataSet(root, pos_dir_1, dir{i}, time_1{i}, 0, DS_len);
    %pos 2 0 dec
    [EMG_cell_2{i}, EMG_label_cell_2{i}, imu_data_cell_2{i}, imu_label_cell_2{i}, ...
        emg_data_set_cell_2{i}, imu_data_set_cell_2{i}, data_set_cell_2{i}] = buildMultiPosDataSet(root, pos_dir_2, dir{i}, time_2{i}, 0, DS_len);
    %pos 2 -90 dec
    [EMG_cell_3{i}, EMG_label_cell_3{i}, imu_data_cell_3{i}, imu_label_cell_3{i}, ...
        emg_data_set_cell_3{i}, imu_data_set_cell_3{i}, data_set_cell_3{i}] = buildMultiPosDataSet(root, pos_dir_3, dir{i}, time_3{i}, 0, DS_len);
end
%%
for i = 1 : classes
    % pos 1 90 dec
    emg_data_set_1{i} = [];
    imu_data_set_1{i} = [];
    % pos 2 0 dec
    emg_data_set_2{i} = [];
    imu_data_set_2{i} = [];
    % pos 3 -90 dec
    emg_data_set_3{i} = [];
    imu_data_set_3{i} = [];
    for j = st : ed
        % pos 1 90 dec
        emg_data_set_1{i} = [emg_data_set_1{i}; emg_data_set_cell_1{j}{i}'];        % EMG
        imu_data_set_1{i} = [imu_data_set_1{i}; imu_data_set_cell_1{j}{i}'];        % IMU
        % pos 2 0 dec
        emg_data_set_2{i} = [emg_data_set_2{i}; emg_data_set_cell_2{j}{i}'];        % EMG
        imu_data_set_2{i} = [imu_data_set_2{i}; imu_data_set_cell_2{j}{i}'];        % IMU
        % pos 3 -90 dec
        emg_data_set_3{i} = [emg_data_set_3{i}; emg_data_set_cell_3{j}{i}'];        % EMG
        imu_data_set_3{i} = [imu_data_set_3{i}; imu_data_set_cell_3{j}{i}'];        % IMU
    end
end
%%
classes = 10;
A_arr_cell_1 = {};
A_arr_cell_2 = {};
A_arr_cell_3 = {};
for i = st : 1 :ed
    % pos 1 0 dec
    [A_arr_cell_1{i}, data_set_cell_1{i}] = buildAmodeSet(root + "\" + pos_dir_1 + "\", dir{i}, time_1{i}, 0, DS_len);
    % pos 2 90 dec
    [A_arr_cell_2{i}, data_set_cell_2{i}] = buildAmodeSet(root + "\" + pos_dir_2 + "\", dir{i}, time_2{i}, 0, DS_len);
    % pos 3 -90 dec
    [A_arr_cell_3{i}, data_set_cell_3{i}] = buildAmodeSet(root + "\" + pos_dir_3 + "\", dir{i}, time_3{i}, 0, DS_len);
end
%%
% for i = st : ed
%     plotAmode(dir{i}, time_1{i}, "trial_" + string(i), 1000);
% end
%%
for i = 1 : 10
    amode_data_set_1{i} = [];
    amode_data_set_2{i} = [];
    amode_data_set_3{i} = [];
    for j = st : ed
        % pos 1 0 dec
        amode_data_set_1{i} = [amode_data_set_1{i}; data_set_cell_1{j}{i}];
        % pos 2 90 dec
        amode_data_set_2{i} = [amode_data_set_2{i}; data_set_cell_2{j}{i}];
        % pos 3 -90 dec
        amode_data_set_3{i} = [amode_data_set_3{i}; data_set_cell_3{j}{i}];
    end
end
%% 划分数据集
