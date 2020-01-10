%% Batch type and Recursive 
% the Riccati equation of the discrete version
clear all; clc

%  generate measurement
N= 1000; 
x = 10;
R0 = 1;  %noise intensity

% for i = 1:N  
%     R(i) = R0;   % noise intensity is constant
% end

for i = 1:N  
    if i <= N/2 
    R(i) = R0;   % noise intensity is constant
    else
        R(i) = 2*R0;
    end
end
y = x + R0*randn(N,1);
plot(1:N,y); grid on

xlswrite('kim.xlsx',y)
%% read data as MS excel format
data = xlsread('kim.xlsx');

%% simple average and recursive average

BatchAverage= 1/N*sum(data)
%% recursive average
ReAve(1) = y(1); %ReAve = recursive average 
for i = 2:N
    ReAve(i)=(i-1)/(i) *ReAve(i-1) +1/i *data(i);
end

plot(1:N,data,'b',1:N, ReAve,'r'); grid on
BatchAverage
ReAve(N)
%% kalman gain design

P(1) = R(1);    %the initial error variance 
for i = 2:N
    K(i) = P(i-1)/(P(i-1) +R(i)); 
    P(i)  = (1 - K(i))^2 * P(i-1) + K(i)^2 * R(i);  
end
%% Kalman estimator

xkal(1) = data(1);
for i = 2:N    
    xkal(i) = xkal(i-1) + K(i)*(data(i) - xkal(i-1));
end

plot(1:N, data,'k',1:N, ReAve,'b', 1:N, xkal,'r')
%plot(1:N, ReAve,'b',1:N,xkal,'r'); grid on
%%  we do not know the intensity of noise, just guess, in this example the kalman is still better

% fro kalman variance 
TempR(1:N) = 5*R;
P(1) = TempR(1);
for i = 2:N
    Sim_P(i) = 1/i *TempR(i); 
    K(i) = P(i-1)/(P(i-1) +TempR(i)); 
    P(i)  = (1 - K(i))^2 * P(i-1) + K(i)^2 *TempR(i);  
end
plot(1:N,Sim_P,'b',1:N,P,'r'); grid on
title('the variance: the simple one(blue), the kalman(red)')





