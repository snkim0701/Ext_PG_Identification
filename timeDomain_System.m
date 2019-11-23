
%% Ch.4 Correlation for sin wave
clear all; clc; clc
ts =0.01; 
tstop = 10;
t= 0:ts:tstop;
sig = sin(2*pi*t);
figure(1)
subplot(2,1,1)
plot(sig); grid on
title('signal = sine wave ')

y =xcorr(sig);
subplot(2,1,2)
plot(y);grid on
title('autocorrelation of signal')

%% Ch.4 Correlation for randn - quadrant subplot 
clear all; clc; clf
ts =0.1; 
tstop = 100;
t= 0:ts:tstop;
sig = sin(2*pi.*t);
sigr = randn(size(t));
figure(1)
subplot(2,2,1)
plot(sig); grid on
title('signal = sin wave ')

y =xcorr(sig);
subplot(2,2,2)
plot(y);grid on
title('autocorrelation of sine wave')

%
subplot(2,2,3)
plot(sigr);grid on
title('guass noise')

%
subplot(2,2,4)
yr =xcorr(sigr);
plot(yr);grid on
title('autocorrelation of gauss')

%% application of correlation - delay time 
clear all;clf
ts = 0.1;
t_send= 0:ts:10;
t_zero = 10:ts:20;
t=[t_send t_zero];

% sens signal 
sig = sin(2*pi*1*t_send);
send = [sig   zeros(1,size(t_zero,2)) ];
figure(1)
plot(send);

% received signal
n= 11;  % number of sampled delay time
delay = ts * n;
rec = [zeros(1,n)  0.8.*sig  zeros(1,100-n+1)];

figure(2)
subplot(2,1,1)
plot(t,send,'b',t,rec,'r');grid on

subplot(2,1,2)
[xc, lags] = xcorr(rec,send);
plot(lags,xc); grid on