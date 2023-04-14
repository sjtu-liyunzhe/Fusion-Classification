% ave_arr = [90.2, 99.0, 99.5;...
%            71.6, 14.4, 59.8;...
%            72.7, 24.3, 65.2];
% ave_arr = [92.3, 99.6, 99.8;...
%            71.4, 24.6, 59.2;...
%            74.9, 12.9, 52.4];
ave_arr = [88.9, 99.7, 99.8;...
           78.0, 17.0, 52.5;...
           65.3, 12.0, 34.2];
SD_arr = [1.68, 0.59, 0.43;...
          2.04, 0.49, 0.30;...
          1.37, 0.09, 0.12];
figure();
% ave_arr = ave_arr';
ave_arr = ave_arr .* 0.01;
SD_arr = SD_arr .* 0;
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
set(gca, 'XTickLabel', {'Pos1', 'Pos2', 'Pos3'});
legend('EMG', 'A mode', 'EMG + A mode');
% legend('Pos1 + Pos1', 'Pos1 + Pos2', 'Pos1 + Pos3');
xlabel('');
ylabel('\fontsize{18}\fontname{Times New Roman}Acurracy');
set(gca,'fontname','Times New Roman');
set(gca,'fontsize',12);
set(gca,'linewidth',1.5);
ylim([0, 1]);