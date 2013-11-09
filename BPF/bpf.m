% function bpf
clear al;
close all;

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

