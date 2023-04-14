clear; clc;
%%
S1.name = "mxw";
S1.KNN_res.emg = 0.738;
S1.KNN_res.amode = 0.953;
S1.KNN_res.fusion = 0.96967;
S1.SVM_res.emg = 0.854;
S1.SVM_res.amode = 0.95733;
S1.SVM_res.fusion = 0.96167;
S1.LDA_res.emg = 0.84;
S1.LDA_res.amode = 0.955;
S1.LDA_res.fusion = 0.96167;
%%
S2.name = "lyz";
S2.KNN_res.emg = 0.88467;
S2.KNN_res.amode = 0.915;
S2.KNN_res.fusion = 0.949;
S2.SVM_res.emg = 0.89667;
S2.SVM_res.amode = 0.89767;
S2.SVM_res.fusion = 0.96667;
S2.LDA_res.emg = 0.88433;
S2.LDA_res.amode = 0.921;
S2.LDA_res.fusion = 0.97433;
%%
S3.name = "wyx";
S3.KNN_res.emg = 0.76467;
S3.KNN_res.amode = 0.96533;
S3.KNN_res.fusion = 0.985;
S3.SVM_res.emg = 0.84567;
S3.SVM_res.amode = 0.97733;
S3.SVM_res.fusion = 0.98967;
S3.LDA_res.emg = 0.82067;
S3.LDA_res.amode = 0.96767;
S3.LDA_res.fusion = 0.991;
%%
S4.name = "zht";
S4.KNN_res.emg = 0.77533;
S4.KNN_res.amode = 0.94233;
S4.KNN_res.fusion = 0.96967;
S4.SVM_res.emg = 0.83767;
S4.SVM_res.amode = 0.905;
S4.SVM_res.fusion = 0.95067;
S4.LDA_res.emg = 0.785;
S4.LDA_res.amode = 0.93167;
S4.LDA_res.fusion = 0.98733;
%%
S5.name = "fsy";
S5.KNN_res.emg = 0.721;
S5.KNN_res.amode = 0.939;
S5.KNN_res.fusion = 0.968;
S5.SVM_res.emg = 0.80333;
S5.SVM_res.amode = 0.95233;
S5.SVM_res.fusion = 0.97067;
S5.LDA_res.emg = 0.789;
S5.LDA_res.amode = 0.974;
S5.LDA_res.fusion = 0.982;
%%
subjects = {S1, S2, S3, S4, S5};
%% KNN
% res_arr = [];
% for i = 1 : 5
%     res_arr(i, 1) = subjects{i}.KNN_res.emg;
%     res_arr(i, 2) = subjects{i}.KNN_res.amode;
%     res_arr(i, 3) = subjects{i}.KNN_res.fusion;
% end
% ave = mean(res_arr);
% std = std(res_arr);
%% SVM
% res_arr = [];
% for i = 1 : 5
%     res_arr(i, 1) = subjects{i}.SVM_res.emg;
%     res_arr(i, 2) = subjects{i}.SVM_res.amode;
%     res_arr(i, 3) = subjects{i}.SVM_res.fusion;
% end
% ave = mean(res_arr);
% std = std(res_arr);
%% LDA
res_arr = [];
for i = 1 : 5
    res_arr(i, 1) = subjects{i}.LDA_res.emg;
    res_arr(i, 2) = subjects{i}.LDA_res.amode;
    res_arr(i, 3) = subjects{i}.LDA_res.fusion;
end
ave = mean(res_arr);
std = std(res_arr);
%%
figure(1);
res_arr(end + 1, :) = ave;
hBar = bar(res_arr);
ctr=transpose(zeros(size(res_arr)));
ydt=transpose(zeros(size(res_arr)));
for k1 = 1:size(res_arr,2)
    ctr(k1,1:size(res_arr,1)) = bsxfun(@plus, hBar(k1).XData, hBar(k1).XOffset');
    ydt(k1,1:size(res_arr,1)) = hBar(k1).YData;
end
hBar(1).FaceColor = "#8DA0CB";
hBar(2).FaceColor = "#FC8D62";
% hBar(2).FaceColor = "#C0504D";
hBar(3).FaceColor = "#66C2A9";
ctr=transpose(ctr);
ydt=transpose(ydt);
hold on
errorbar(ctr(6, :), ydt(6, :), std,'.k','CapSize',5,'MarkerSize',6, 'LineWidth', 1.2);
box off;
set(gca, 'XTickLabel', {'S1' 'S2' 'S3' 'S4' 'S5' 'AVE'});
% legend('EMG', 'A mode', 'EMG + A mode');
xlabel('');
ylabel('\fontsize{14}\fontname{Times New Roman}Classification accururacy');
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',12);
set(gca,'linewidth',1.5);
ylim([0.5, 1]);
mid_x = mean([ctr(5, 2), ctr(6, 2)]);
ylim_val = get(gca, 'ylim');
line([mid_x mid_x], ylim_val, 'linewidth', 1.2, 'LineStyle', '--', 'Color', 'r');
ll = yline(0.95, 'linewidth', 1.2, 'lineStyle', '--');
legend('EMG', 'Amode', 'Fusion');