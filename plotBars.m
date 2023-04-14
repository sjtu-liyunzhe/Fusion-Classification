% ave_arr = [83.36, 97.96, 98.52;...
%            86.06, 97.89, 98.43;...
%            84.69, 98.35, 98.66];
% SD_arr = [5.95, 1.87, 1.52;...
%           6.62, 1.50, 2.47;...
%           3.65, 2.11, 1.87];
ave_arr = [93.82, 88.58;...
           93.09, 91.65;...
           88.37, 85.66];
SD_arr = [3.27, 2.20;...
          3.36, 0.71;...
          4.07, 3.48];
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
legend('Condion 1', 'Condion 2');
xlabel('');
ylabel('\fontsize{18}\fontname{Times New Roman}Acurracy');
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',12);
set(gca,'linewidth',1.5);
ylim([0, 1]);