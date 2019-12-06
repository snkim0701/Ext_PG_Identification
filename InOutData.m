
%% generate data
clear all; clc;clf

tsamp = 0.01;  % the sampling time
t= 0:tsamp:10;
fsig = 2;
data = sin(2*pi*fsig.*t);  % 2Hz  sine wave
data = [t ;data]'; % [ time  data]
plot(data(:,1),data(:,2)) % 

% export data un spreadsheet
filename = 'test';
xlswrite(filename,data); 

%  import data 
import = xlsread('test.xls');
subplot(2,1,1)
plot(data(:,1), data(:,2), 'b');
subplot(2,1,2)
plot(import(:,1),import(:,2),'r');

%
simin = import;

%% 
clc;
clear all;
close all;
tsamp=1/4400; %sampling frequency
Afsig=440; %frequency of the sound wave A notes
Cfsig =261;  %frequency of the sound wave C notes
t=0:tsamp:2;
A=sin(2*pi*Afsig.*t) + 2*sin(2*pi*Cfsig.*t);

sound(A);
A=[t;A]';
% export data un spreadsheet
filename = 'ASound';
xlswrite(filename,A); 

%  import data 
Aimport = xlsread('Asound.xls');
subplot(2,1,1)
plot(A(:,1), A(:,2), 'b');
subplot(2,1,2)
plot(Aimport(:,1),Aimport(:,2),'r');

%
simin = Aimport;