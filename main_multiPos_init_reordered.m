%%
clear; clc;
%%
trialNum = 16;
st = 1;
ed = 8;
dir = {};
for i = st : ed
    dir{i} = "\trial_" + string(i);
end
root = "multi pos data\reordered\mxw";
%% Pos 1 90 dec
time_1 = {};
time_1{1} = "22_20_37_44";
time_1{2} = "22_20_38_52";
time_1{3} = "22_20_40_12";
time_1{7} = "22_20_41_09";
time_1{8} = "22_20_42_08";
time_1{6} = "22_20_43_06";
time_1{4} = "22_20_44_06";
time_1{5} = "22_20_46_06";
pos_dir_1 = "90 dec";
%% Pos 2 0 dec
time_2 = {};
time_2{1} = "22_20_50_31";
time_2{2} = "22_20_51_48";
time_2{3} = "22_20_53_17";
time_2{7} = "22_20_54_15";
time_2{8} = "22_20_55_37";
time_2{6} = "22_20_56_44";
time_2{4} = "22_20_58_00";
time_2{5} = "22_20_59_26";
pos_dir_2 = "0 dec";
%% Pos 3 -90 dec
time_3 = {};
time_3{1} = "22_21_01_20";
time_3{2} = "22_21_02_26";
time_3{3} = "22_21_03_41";
time_3{7} = "22_21_06_57";
time_3{8} = "22_21_08_11";
time_3{6} = "22_21_09_29";
time_3{4} = "22_21_10_42";
time_3{5} = "22_21_11_45";
pos_dir_3 = "-90 dec";