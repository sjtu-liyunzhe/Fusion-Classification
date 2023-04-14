ave_arr = [88.25, 98.84, 99.20;...
           93.96, 99.43, 99.62;...
           92.19, 99.60, 99.88];
SD_arr = [1.68, 0.59, 0.43;...
          2.04, 0.49, 0.30;...
          1.37, 0.09, 0.12];
figure();
ave_arr = ave_arr .* 0.01;
SD_arr = SD_arr .* 0.01;
hBar = bar(ave_arr);
ctr=transpose(zeros(size(ave_arr)));
ydt=transpose(zeros(size(ave_arr)));
for k1 = 1:size(ave_arr,2)
    ctr(k1,1:size(ave_arr,1)) = bsxfun(@plus, hBar(k1).XData, hBar(k1).XOffset');
    ydt(k1,1:size(ave_arr,1)) = hBar(k1).YData;
end
ctr=transpose(ctr);
ydt=transpose(ydt);
hold on
errorbar(ctr, ydt, SD_arr,'.k','CapSize',5,'MarkerSize',6, 'LineWidth', 1.2);
set(gca, 'XTickLabel', {'KNN' 'SVM' 'LDA'});
legend('EMG', 'A mode', 'EMG + A mode');
xlabel('');
ylabel('\fontsize{18}\fontname{Times New Roman}Acurracy');
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',12);
set(gca,'linewidth',1.5);
ylim([0, 1]);