
%% y = Ax

clear all;clc; clf
A =[1 0; 1 1; 1 3]
y = [ 1 2 3]'

% pseudo inverse
pseudo=inv(A'*A)
LSE =pseudo*A'*y  % least square estimator
% error between y and A*LSE 
error = y-A*LSE 
disp(' error between y and A*LSE')

%%  example 5.3 in the tetbook
clear all;
disp('Example 5.3 ')
disp(' ')
t = 0:0.2:1.0;
y=[3 59 98 151 218 264]';
plot(t,y,'o'); grid on
title ('the measured data')
% generate regressor Phi matrix
% model y = xo + vo*t + 1/2 ao**t = [1 t 1/2t**2 ] * [ xo  vo  ao] + v 
% 
Phi = [ ];
for i =1:size(t,2)     
    temp = [1 ; t(i) ; (1/2)*t(i)^2];
    Phi = [Phi temp];
end

% check the value with  the textbook at page 64
Phi=Phi';            
inv((Phi')*(Phi)); 
(Phi)' *y ; 
est = inv((Phi')*(Phi)) *((Phi)' *y); % Least Square estimator
disp('Least Square Estimator for [ x0 v0 a0]')
disp(est)


%% the effect on LSE due to the  the number of data and noise 
% the accuracy
clear all
clc; clf;
disp('Example 5.11 ')
disp(' ')

%generate real value
init =0.5;
vel =1;
accel = 0.5;
N = 100 ;  %the number of sampling data

for i = 1:N;
    t(i) = i/10;   % sampling time
    real(i)  = init + vel*t(i)  + 1/2 *accel*t(i)^2;
end
plot(t,real); grid on
disp('real position')

%  measurement = real + noise
y = real +0.5* randn(1,N);
plot(t,real,'b', t,y,'r'); grid on

% generate regressor matix
Phi = [ ];
for i = 1:N
    temp = [ 1;t(i);1/2*t(i)^2];
    Phi = [Phi temp];    
end
Phi = Phi';
% check the value with  the textbook at page 64
y= y';
inv((Phi'*Phi))*(Phi)'*y

%%