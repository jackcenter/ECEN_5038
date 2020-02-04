clear; clc; close all;

load('NAME_initialization_data.mat')
load('Name_output_data.mat')

u = Input;
t = Time;
pos = Y_1;
vel = Y_2;

sample = 30;

%% System Identification
slope = (pos(end) - pos(end-sample)) / ( t(end) - t(end-sample) );    % [rad / s ]    
volt_avg = mean(vel(end-sample:end));   % steady state voltage
speed_volt_ratio = slope/volt_avg;      % rad/s per volt

tau_volt = volt_avg*0.632;                                          
tau_index = length(vel(1:find(vel > tau_volt)));
tau = Time(tau_index) - 1; 

K = slope/volt_avg;                     % statedy state voltage in rad/s 

vel = vel*speed_volt_ratio;             % velocity vector in rad/s
vel_avg = volt_avg*speed_volt_ratio;    % steady state velocity

s = tf('s');
H = volt_avg / (tau*s + 1);               %Tranfer Function
%% Time Response
subplot(2,1,1)
plot(t, u)
title('Time Response of the System')
ylabel('Input')

subplot(2,1,2)
plot(t, vel)
xlabel('Time [s]')
ylabel('Ouput')

%% Frequency Response
u_s = abs(fft(u)/length(u));

pos_s = abs(fft(pos)/length(pos));
vel_s = abs(fft(vel)/length(vel));

data_indexes = find(u_s >= 1e-3); 

bode_data = zeros(size(u_s));
bode_data(data_indexes) = abs(vel_s(data_indexes)./u_s(data_indexes));
bode_log(data_indexes) = 20*log10(bode_data(data_indexes));

figure
semilogx(freq_range(data_indexes),bode_log(data_indexes),'.-r')
hold on
bode(H)
% % 
% %     B = Vel ./ U;
% %     B = abs(B);
% %     B_log = 20*log10(B);
% %     semilogx(B_log)


