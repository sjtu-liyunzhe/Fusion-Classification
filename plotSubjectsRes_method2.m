clear; clc;
%%
S1.name = "mxw";
S1.KNN_res.emg = 0.55033;
S1.KNN_res.amode = 0.924;
S1.KNN_res.fusion = 0.94167;
S1.SVM_res.emg = 0.675;
S1.SVM_res.amode = 0.90567;
S1.SVM_res.fusion = 0.93967;
S1.LDA_res.emg = 0.625;
S1.LDA_res.amode = 0.91967;
S1.LDA_res.fusion = 0.93333;
%%
S2.name = "lyz";
S2.KNN_res.emg = 0.689;
S2.KNN_res.amode = 0.828;
S2.KNN_res.fusion = 0.88833;
S2.SVM_res.emg = 0.75;
S2.SVM_res.amode = 0.809;
S2.SVM_res.fusion = 0.879;
S2.LDA_res.emg = 0.69433;
S2.LDA_res.amode = 0.80833;
S2.LDA_res.fusion = 0.88033;
%%
S3.name = "wyx";
S3.KNN_res.emg = 0.696;
S3.KNN_res.amode = 0.91467;
S3.KNN_res.fusion = 0.985;
S3.SVM_res.emg = 0.795;
S3.SVM_res.amode = 0.89533;
S3.SVM_res.fusion = 0.98967;
S3.LDA_res.emg = 0.74833;
S3.LDA_res.amode = 0.88833;
S3.LDA_res.fusion = 0.98;
%%
S4.name = "zht";
S4.KNN_res.emg = 0.66267;
S4.KNN_res.amode = 0.86033;
S4.KNN_res.fusion = 0.95533;
S4.SVM_res.emg = 0.77433;
S4.SVM_res.amode = 0.743;
S4.SVM_res.fusion = 0.945;
S4.LDA_res.emg = 0.688;
S4.LDA_res.amode = 0.78667;
S4.LDA_res.fusion = 0.96033;
%%
S5.name = "fsy";
S5.KNN_res.emg = 0.50867;
S5.KNN_res.amode = 0.895;
S5.KNN_res.fusion = 0.951;
S5.SVM_res.emg = 0.63867;
S5.SVM_res.amode = 0.89733;
S5.SVM_res.fusion = 0.947;
S5.LDA_res.emg = 0.66067;
S5.LDA_res.amode = 0.91533;
S5.LDA_res.fusion = 0.96767;
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
% legend('EMG', 'Amode', 'Fusion');