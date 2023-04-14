function plotAmode(dir, time, title, length)
    A_arr = {};
    for i = 1 : 4
        path = ".\fusion_data\" + dir + "\Channel_" + string(i - 1) + "\Amode " +string(time) + " Exp.txt";
        A_arr{i} = load(char(path));
    end
    num = 1;
    figure();
    ylim([0, 200]);
    for i = 1 : length
        for j = 1 : 4
            subplot(4, 1, j);
            plot(A_arr{j}(i, :));
            ylim([0, 200]);
        end
        F = getframe(gcf);
        I = frame2im(F);
        [I, map] = rgb2ind(I, 256);
        if num == 1
            imwrite(I, map, char(title + ".gif"), 'gif', 'Loopcount', inf, 'DelayTime', 0.05);
        else
            imwrite(I, map, char(title + ".gif"), 'gif', 'WriteMode', 'append', 'DelayTime', 0.05);
        end
        num = num + 1;
    end
end