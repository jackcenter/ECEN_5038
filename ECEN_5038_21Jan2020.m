clear; clc; close all;

% Initialize matlab
a = 8;              % amplitude
T = 10;             % simulation final time (seconds)
dt = 0.01;          % time step (seconds)
t = 0:dt:T - dt;    % time vector

periods = 1;        % number of times to run simulation
T_total = T*periods;
t_total = 0:dt:T_total - dt;

freq_min = 2*pi/T;
freq_nyqist = pi/dt;

omega_range = freq_min:freq_min:freq_nyqist;

% Parameters: T(s) = k / (s/w + 1) from single motor model
k = 1;      
omega = 1;

s = tf('s');            
TF = k / (s / omega + 1);   % Transfer function

