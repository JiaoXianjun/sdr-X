function bpf
clear al;
close all;

% len = 1e6;
% s = randn(1, len) + 1i.*randn(1, len);
% r = bpf_down_core(s);

% r = upsample(r, 256);

% pwelch(r);

s = [1, zeros(1,2047)];
r = bpf_down_core(s);
r = bpf_up_core(r);
len = length(r);
% figure; plot(r);

% fvtool(r, 1);

fo = 1e6-90;
r = r.*exp(1i.*2.*pi.*fo.*(0 : (len-1))./2.4e6);

spec_dB = 10.*log10(abs(fft(r)).^2);
spec_dB = [spec_dB(( (len/2) + 1 ):end), spec_dB(1:(len/2))];
spec_dB = spec_dB - max(spec_dB);
x_data = linspace(-1.2e3, 1.2e3, len);

figure; plot(x_data(( (len/2)+1) : end), spec_dB(( (len/2)+1) : end)); axis tight; grid on; 
title('Digital BPF; 2.4Msps; Pass band 2.4kHz');
xlabel('kHz'); ylabel('dB');


%  2.4Msps --> 9.4kHz (decimation 256)
%  bandwidth 2.4kHz
function b = bpf_down_core(a)
persistent b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15
if isempty(b0)
    % --------------------------------
    b0 = load('hb0.mat'); % HB
    b0 = b0.Num; %pass: 1.2kHz; 2.4M --> 1.2M

    b1 = load('fir1.mat'); % FIR @ 1.2M
    b1 = b1.Num; %pass: 1.2kHz; stop: 0.3MHz -80dB

    % --------------------------------
    b2 = load('hb2.mat'); % HB
    b2 = b2.Num; %pass: 1.2kHz; 1.2M --> 0.6M

    b3 = load('fir3.mat'); % FIR @ 0.6M
    b3 = b3.Num; %pass: 1.2kHz; stop: (0.6/4)MHz -80dB

    % --------------------------------
    b4 = load('hb4.mat'); % HB
    b4 = b4.Num; %pass: 1.2kHz; 0.6M --> 0.3M

    b5 = load('fir5.mat'); % FIR @ 0.3M
    b5 = b5.Num; %pass: 1.2kHz; stop: (0.3/4)MHz -80dB

    % --------------------------------
    b6 = load('hb6.mat'); % HB
    b6 = b6.Num; %pass: 1.2kHz; 0.3M --> 0.15M

    b7 = load('fir7.mat'); % FIR @ 0.15M
    b7 = b7.Num; %pass: 1.2kHz; stop: (0.15/4)MHz -80dB

    % --------------------------------
    b8 = load('hb8.mat'); % HB
    b8 = b8.Num; %pass: 1.2kHz; 0.15M --> (0.15/2)M

    b9 = load('fir9.mat'); % FIR @ (0.15/2)M
    b9 = b9.Num; %pass: 1.2kHz; stop: (0.15/8)MHz -80dB

    % --------------------------------
    b10 = load('hb10.mat'); % HB
    b10 = b10.Num; %pass: 1.2kHz; (0.15/2)M --> (0.15/4)M

    b11 = load('fir11.mat'); % FIR @ (0.15/4)M
    b11 = b11.Num; %pass: 1.2kHz; stop: (0.15/16)MHz -80dB

    % --------------------------------
    b12 = load('hb12.mat'); % HB
    b12 = b12.Num; %pass: 1.2kHz; (0.15/4)M --> (0.15/8)M

    b13 = load('fir13.mat'); % FIR @ (0.15/8)M
    b13 = b13.Num; %pass: 1.2kHz; stop: (0.15/32)MHz -80dB

    % --------------------------------
    b14 = load('hb14.mat'); % HB
    b14 = b14.Num; %pass: 1.2kHz; (0.15/8)M --> (0.15/16)M

    b15 = load('fir15.mat'); % FIR @ 9.4kHz
    b15 = b15.Num; %pass: 1.2kHz; stop: 1.8kHz -80dB
end

a0 = downsample( conv(a, b0), 2 );
a1 = conv(a0, b1);

a2 = downsample( conv(a1, b2), 2 );
a3 = conv(a2, b3);

a4 = downsample( conv(a3, b4), 2 );
a5 = conv(a4, b5);

a6 = downsample( conv(a5, b6), 2 );
a7 = conv(a6, b7);

a8 = downsample( conv(a7, b8), 2 );
a9 = conv(a8, b9);

a10 = downsample( conv(a9, b10), 2 );
a11 = conv(a10, b11);

a12 = downsample( conv(a11, b12), 2 );
a13 = conv(a12, b13);

a14 = downsample( conv(a13, b14), 2 );
a15 = conv(a14, b15);

b = a15;

%  9.4kHz --> 2.4Msps (upsample 256)
%  bandwidth 2.4kHz
function b = bpf_up_core(a)
persistent b0 b1 b2 b3 b4 b5 b6 b7 b8 b9 b10 b11 b12 b13 b14 b15
if isempty(b0)
    % --------------------------------
    b0 = load('hb0.mat'); % HB
    b0 = b0.Num; %pass: 1.2kHz; 2.4M --> 1.2M

    b1 = load('fir1.mat'); % FIR @ 1.2M
    b1 = b1.Num; %pass: 1.2kHz; stop: 0.3MHz -80dB

    % --------------------------------
    b2 = load('hb2.mat'); % HB
    b2 = b2.Num; %pass: 1.2kHz; 1.2M --> 0.6M

    b3 = load('fir3.mat'); % FIR @ 0.6M
    b3 = b3.Num; %pass: 1.2kHz; stop: (0.6/4)MHz -80dB

    % --------------------------------
    b4 = load('hb4.mat'); % HB
    b4 = b4.Num; %pass: 1.2kHz; 0.6M --> 0.3M

    b5 = load('fir5.mat'); % FIR @ 0.3M
    b5 = b5.Num; %pass: 1.2kHz; stop: (0.3/4)MHz -80dB

    % --------------------------------
    b6 = load('hb6.mat'); % HB
    b6 = b6.Num; %pass: 1.2kHz; 0.3M --> 0.15M

    b7 = load('fir7.mat'); % FIR @ 0.15M
    b7 = b7.Num; %pass: 1.2kHz; stop: (0.15/4)MHz -80dB

    % --------------------------------
    b8 = load('hb8.mat'); % HB
    b8 = b8.Num; %pass: 1.2kHz; 0.15M --> (0.15/2)M

    b9 = load('fir9.mat'); % FIR @ (0.15/2)M
    b9 = b9.Num; %pass: 1.2kHz; stop: (0.15/8)MHz -80dB

    % --------------------------------
    b10 = load('hb10.mat'); % HB
    b10 = b10.Num; %pass: 1.2kHz; (0.15/2)M --> (0.15/4)M

    b11 = load('fir11.mat'); % FIR @ (0.15/4)M
    b11 = b11.Num; %pass: 1.2kHz; stop: (0.15/16)MHz -80dB

    % --------------------------------
    b12 = load('hb12.mat'); % HB
    b12 = b12.Num; %pass: 1.2kHz; (0.15/4)M --> (0.15/8)M

    b13 = load('fir13.mat'); % FIR @ (0.15/8)M
    b13 = b13.Num; %pass: 1.2kHz; stop: (0.15/32)MHz -80dB

    % --------------------------------
    b14 = load('hb14.mat'); % HB
    b14 = b14.Num; %pass: 1.2kHz; (0.15/8)M --> (0.15/16)M

    b15 = load('fir15.mat'); % FIR @ 9.4kHz
    b15 = b15.Num; %pass: 1.2kHz; stop: 1.8kHz -80dB
end

a14 = conv( upsample(a, 2), b14 );
a12 = conv( upsample(a14, 2), b12 );
a10 = conv( upsample(a12, 2), b10 );
a8 = conv( upsample(a10, 2), b8 );
a6 = conv( upsample(a8, 2), b6 );
a4 = conv( upsample(a6, 2), b4 );
a2 = conv( upsample(a4, 2), b2 );
a0 = conv( upsample(a2, 2), b0 );

b = a0;
