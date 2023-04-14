function fig = FFT_plot(normalData, len_normalData, fs)
    Ts = 1 /fs;
    Y_normalData = fft(normalData);
    P2_normalData = abs(Y_normalData / len_normalData);     % 双侧
    P1_normalData = P2_normalData(1 : len_normalData / 2 + 1);
    P1_normalData(2: end - 1) = 2 * P1_normalData(2: end - 1);
    f_normalData = fs * (0: (len_normalData / 2)) / len_normalData;
    t_normalData = (0 : len_normalData - 1) * Ts;
    figure();
    subplot(2, 1, 1);
    plot(t_normalData, normalData);
%     ylim([-2000, 2000]);
    xlabel('t/s'); ylabel('Amptitude');
    title('时域');
    subplot(2, 1, 2);
    plot(f_normalData, P1_normalData);
    xlabel('f/Hz'); ylabel('Amptitude');
    title('频域');
    fig = 0;
end