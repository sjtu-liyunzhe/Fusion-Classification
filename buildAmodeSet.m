function [A_arr, data_set] = buildAmodeSet(root, dir, time, order, DS_len)
    classes = 10;
    for i = 1 : 4
        path = ".\" + root + "\" + dir + "\Channel_" + string(i - 1) + "\Amode " + time + " Exp.txt";
        label_path = ".\" + root + "\" + dir + "\Channel_" + string(i - 1) + "\Amode_Label " + time + " Exp.txt";
        A_arr{i} = load(char(path));
        label_arr{i} = load(char(label_path));
    end
    %% 构建label
    tmp_label = [];
    order = 0;
    if(order == 0)
        cnt = 0;     % 正序
    else
        cnt = 11;      % 逆序
    end
    last = 1;
    for num = label_arr{1}'
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
    %%
    raw_set = {};
    for i = 1 : classes
        raw_set{i} = {};
        for j = 1 : 4
            raw_set{i}{j} = [];
        end
    end
    for i = 1 : 4
        amode = A_arr{i};
        label = tmp_label;
        cnt = 0;
        for j = 1 : size(label, 2)
            if(label(j) > 0 && label(j) < 11)
                raw_set{label(j)}{i}(end + 1, :) = amode(j, :);
                cnt = cnt + 1;
            end
        end
    end
    %%
    global sample_depth sample_length chnum sound_speed zero_delay
    chnum = 4;
    sample_depth = 38.5e-3;
    sample_depth = repmat(sample_depth, 1, chnum);
    zero_delay = 0e-6;
    sound_speed = 1540;
    sample_length = 200;
    win_length = 20;
    data_set = {};
    for c = 1 : classes
        tmp_data = raw_set{c};
        data_set{c} = [];
        for cnt = 25 : 25 + DS_len
            feature = [];
            data = [];
            for i = 1 : 4
                tmp = tmp_data{i}(cnt, :);
                data(end + 1, :) = tmp(:, 1 : sample_length);
            end
            feature(end + 1, :) = ExFeature(data, win_length);
            data_set{c}(end + 1, :) = feature;
        end
    end
end