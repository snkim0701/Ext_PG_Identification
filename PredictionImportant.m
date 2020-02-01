

clear all; clc; 
data=csvread('AAPL.csv',1,1);
whos
close = data(:,5);
plot(close); grid minor
title('apple stock price')

%% moving average
Win =10;
figure(2)
n = length(close);
a=1;
b=1/Win*ones(1,Win);
MovFilter =filter(b,a,close);
plot(1:n,close,'b',1:n, MovFilter,'r');  grid minor
title('real stock(blue), moving(red)')
rawlPredition_253 = close(252,1) +(close(252,1) - close(251,1))
MovPredition_253 = close(252,1) +(MovFilter(252,1) - MovFilter(251,1))

%% alpha - beta tracker
alpha = 0.1;
beta = 2*(2-alpha) -4*sqrt(1-alpha);
CorPo(1) = close(1);   % the price
CorVel(1) = 5;              % rate of the price
n = length(close);
dt = 1;
% (alpha-beta tracker)
for i = 1:n-1;
  % Prediction 
PrePo = CorPo(i) + dt*CorVel(i) ;
PreVel = CorVel(i); % since velocity is constant 
Res = close(i) - PrePo; % innivaion process

% correction 
xh = PrePo + alpha*Res; % 
vh = PreVel + beta/dt *Res;
CorPo(i+1) = xh;
CorVel(i+1) = vh;
end 
plot(1:n, close,'b', 1:n, CorPo,'r'); grid minor
title('real stock(blue), alpha filter(red)')
alphaPrediction_253 = close(252,1) + CorVel(1,252)
