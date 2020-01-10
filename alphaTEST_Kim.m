

clear all; clc
dt =5/500;
t = 0:dt:5;
n = length(t);


% for i = 1:n
%    if i < 250
%        xo(i) = sin(2*pi*0.1*t(i));
%    else
%        xo(i) = sin(2*pi*0.1*t(i)) +sin(2*pi*0.2*t(i));
%    end
% end
xin = 1000;
vel = 10; 
for i = 1:n
    xo(i) = xin + vel * t(i);
end
y = xo+ randn(1,n) ;

% MOVING 
Win = 40;
a = 1;
b= 1/Win*ones(1,Win);
MovFilter =filter(b,a,y);

% results
plot(y,'b'); hold on ;grid on
plot(xo,'c');
plot(MovFilter,'k')
hold off
%% 


alpha = 0.05;
beta = 2*(2-alpha) -4*sqrt(1-alpha);

CorPo(1) = 500;
CorVel(1) = 5;


% (alpha-beta tracker)
for i = 1:n;
  % Prediction 
PrePo = CorPo(i) + dt*CorVel(i) ;
PreVel = CorVel(i); % since velocity is constant 
Res = y(i) - PrePo; % innivaion process

% correction 
xh = PrePo + alpha*Res; % 
vh = PreVel + beta/dt *Res;
CorPo(i+1) = xh;
CorVel(i+1) = vh;
end
 
% results
plot(y,'b'); hold on ;grid on
plot(CorPo,'r'); 
plot(xo,'c');
plot(MovFilter,'k')
hold off
