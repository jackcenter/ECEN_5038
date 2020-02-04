clear; clc; close all;

% Initializing QuarcBlock

%Input Signal
    a = 1/5;                             %Amplitude
    T = 10;                            %Experiment Time
    dT = 0.002;                          %Sampling Time
    f = 2*pi/T;                         %Frequency
    F = 0:2*pi/T:2*pi/dT-2*pi/T;        %Frequency Vector
    Max = 200 * T/(2*pi);

    save('Motor_initialization_data', 'a', 'T', 'dT', 'F')