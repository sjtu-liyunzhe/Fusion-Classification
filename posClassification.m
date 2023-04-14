%%
pos{1} = [-9.81; -9.81; 0];
pos{2} = [-9.81; 0; 0];
pos{3} = [0; 5; 0];
real_label_imu_sum = [];
for i = 1 : 3
    real_label_imu_sum = [real_label_imu_sum; i * ones(size(imu_acc_test{i}, 1), 1)];
end
%%
predict_label_imu_sum = [];
for i = 1 : 3
    predict_label_imu{i} = [];
    for j = 1 : length(imu_acc_test{i})
        tmp_acc = imu_acc_test{i}(j, :)';
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
        predict_label_imu{i}(end + 1, :) = predict_label;
    end
    predict_label_imu_sum = [predict_label_imu_sum; predict_label_imu{i}];
end
confusion_pos = confusionmat(predict_label_imu_sum, real_label_imu_sum);