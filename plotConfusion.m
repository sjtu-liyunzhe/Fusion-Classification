function plotConfusion(mat, flag)
    maxcolor = [191,54,12]; % 最大值颜色
    mincolor = [255,255,255]; % 最小值颜色
    figure;
    % 绘制坐标轴
    m = length(mat);
    imagesc(1:m,1:m,mat)
    xticks(1:m)
    xlabel('Predict class','fontsize',10.5)
%     xticklabels(label)
    yticks(1:m)
    ylabel('Actual class','fontsize',10.5)
%     yticklabels(label)

    % 构造渐变色
    mymap = [linspace(mincolor(1)/255,maxcolor(1)/255,64)',...
             linspace(mincolor(2)/255,maxcolor(2)/255,64)',...
             linspace(mincolor(3)/255,maxcolor(3)/255,64)'];

    colormap(mymap)
    colorbar()
    if(flag == 1)
    % 色块填充数字
        for i = 1:m
            for j = 1:m
                text(i,j,num2str(mat(j,i), '%4.2f'),...
                    'horizontalAlignment','center',...
                    'verticalAlignment','middle',...
                    'fontname','Times New Roman',...
                    'fontsize',10);
            end
        end
    else
        if(flag == 2)
            for i = 1:m
                for j = 1:m
                    if(mat(j, i) ~= 0)
                        text(i,j,num2str(mat(j,i), '%4.2f'),...
                            'horizontalAlignment','center',...
                            'verticalAlignment','middle',...
                            'fontname','Times New Roman',...
                            'fontsize',10);
                    end
                end
            end
        end
    end

    % 图像坐标轴等宽
    ax = gca;
    ax.FontName = 'Times New Roman';
    set(gca,'box','on','xlim',[0.5,m+0.5],'ylim',[0.5,m+0.5]);
    axis square
%     saveas(gca,'m.png');
end