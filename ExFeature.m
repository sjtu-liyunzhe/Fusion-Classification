function [ vFeature ] = ExFeature( data, win_length )
% parameters definition
global sampling_freq sample_length chnum sample_depth sound_speed zero_delay

% chnum = 4;
% sample_dots = 1000;
% sample_length = sample_dots; % num of dots sampled
sample_depth = 38.5e-3;
sample_depth = repmat(sample_depth, 1, chnum);                             
sampling_freq = 20e6;
sampling_freq = repmat(sampling_freq, 1, chnum);
zero_delay = 0e-6; % lingwei yanchi in seconds                             
sound_speed = 1540; % m/s

range = win_length;                                                        
burst_tone_freq = 4e6; % used in tgc coefficient calc and Gaussian filter mid-freq
start = win_length; % start of x 
endo = 0; % end of x, avoid gaussian filter jitter
tgc_alpha = 0.05; % [dB/(MHz cm)]
sampling_balance = 128; % median of sampling range  
filter_bandwidth = 110;
log_comp_ratio = 0.4;                                                     

% Declaration and error handling 
mDepth = zeros(chnum, sample_length);
for i = 1 : chnum % channel_no 
    mDepth(i, :) = (1 : sample_length) / sample_length * sample_depth(i); 
    mDepth(i, :) = sound_speed * zero_delay + mDepth(i, :);
    tgc(i, :) = exp(tgc_alpha * burst_tone_freq / 1e6 * mDepth(i, :) * 100);
end

vFeature = [];
fit_foobar = 1 : range; %for fit 

if sample_length ~= size(data, 2)                                          
    error('sample length mismatched.')
end

%%  process start
for i = 1 : chnum % channel_no
      line = bsxfun(@times, tgc(i, :), data(i, :) - sampling_balance); 
%     line = gaussianFilter(line, sampling_freq(i), burst_tone_freq, filter_bandwidth); 
    line = envelopeDetection(line);                                        %Hilbert  
%       line = abs(line);
      line = logCompression(line, log_comp_ratio);                          
% normal code part
    for tail = start + range - 1 : range : (sample_length - endo)  
        xcor = (tail - range + 1) : tail;% x coordinates in a typical segment 
    
    %     foobar = polyfit(fit_foobar, line(xcor), 1);    
        foobar = [mean(line(xcor)'), std(line(xcor)')];     
        
    %     foobar = [max(line(xcor)')]; 
        
        vFeature = [vFeature foobar]; 
    end
end
