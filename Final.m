
%% the estimator 
% batch type

X = [10, 9, 10, 11,12, 9];
N = length(X);
disp(' batch estiamtor')
batchX = 1/N * sum(X)

% recursive type
recX(1) = X(1);
for i = 2:N
    recX(i) = (i-1)/i *recX(i-1)  + 1/i * X(i);
end
disp('recursive estimtor')
recX(N)

%% Leat square estimator 
clear all; clc
X_A  = [10, 9, 10, 11, 12, 9];
resolA = 1;
NA = length(X_A);

 X_B  = [10.1, 9.8, 10.2, 9.2, 9.5, 10.3];
resolB = 0.1;
NB = length(X_B);

% the best estimator

var_A = 1/6 * resolA^2;
var_B = 1/6 * resolB^2;


W_A = var_B/(var_A+var_B);
W_B  = var_A/(var_A + var_B);

average_A = 1/NA *sum(X_A);
average_B = 1/NB *sum(X_B);

% the least squared  best estimator is

best_X= W_A * average_A + W_B * average_B

%% Dynamic model
% y =a1 + a2*t + error, find the best estimator for a1 and a2
clear all; clc
t = 0:1:9;
y =[1 3 4 7 10 12 15 16 17]';
N = length(y);
Phi = [ ];
for i = 1:N
    temp = [1; t(i)];
    Phi = [Phi temp];    
end

plot(1:N, y, 'bo'); grid on; hold on
Phi = Phi';
EST = inv((Phi')*(Phi))*Phi'*y;

disp('the best estimator a1 and a2 is ')
EST
regY = Phi*EST;
plot(1:N, regY, '--r'); hold off
title('the best linear regressor(red)')

%% Auto regressive eXogeneous (ARX) and ARMAX
clear all;  clc; clf 

% define a discrete system
% y(t) =  u(t-1) + 0.5*u(t-2)
A = [1];
B = [0  1 0.5];  
sys0 = idpoly([1], [ 0 1 0.5])  % original system
                                 % check the sys0 with the original y(t)

% generate input  and noise
N = 300;  % the number of signal
u = iddata([ ],idinput(N,'rbs'));
e = iddata([ ],randn(N,1));

% generate output
y = sim(sys0,[u e]);

% for regressor matix, 
z = [y,u];
figure(1)
idplot(z); grid on

% LSE 
sys = arx(z,[0 2 1])    % estimate system

% compare the real output with the output of the LSE system
% ye =sim(sys,[u e]);
% figure(2)
% plot(y,'b');grid on;  hold on
% plot(ye,'r');
% title('FIR sytem : real output(blue) with LSE output(red)')
% hold off

%% prediction is important
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

%% generate system  ARMAX model
% A(z)Y(z) = B(z)U(z) + C(Z)E(z)
clear all;  clc

% define a discrete system
%y(t) = 1.5y(t-1) - 0.7y(t-2) + u(t-1) + 0.5u(t-2) + e(t) + 0.5e(t-1)
A = [1  -1.5  0.7];
B = [0 1 0.5];
C = [1 0.5]
sys0 = idpoly(A,B,C)


% generate input and noise
% input = random bianary sequence
u= iddata([ ],idinput(300,'rbs'));
e = iddata([ ],randn(300,1));

% generate output
y = sim(sys0,[u e]);

% for regressor matix, 
z = [y,u];
figure(1)
idplot(z); grid on

% LSE 
sys = armax(z,[2 2 1 1])

% compare the real output with the output of the LSE system
ye =sim(sys,[u e]);
figure(6)
plot(y,'b');grid on;  hold on
plot(ye,'r');
title('ARMAX system : real output(blue) with LSE output(red)')
hold off

%% 
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
plot(1:n, close,'b', 1:n, MovFilter,'c',1:n, CorPo,'r'); grid minor
title('real stock(blue), alpha filter(red)')
alphaPrediction_253 = close(252,1) + CorVel(1,252)