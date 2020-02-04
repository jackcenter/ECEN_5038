clear; clc; close all;

%% Input Signal (Step)

%% Input Signal (Sinusoid)
    a = 1/5;                            % amplitude
    T = 10;                             % experiment time
    dT = 0.002;                         % sampling time
    min_freq = 2*pi/T;                  % frequency
    range = 1:200;                      % range of frequency multiples
    freq_range = min_freq*range;        % list of frequencies to be tested
    max_freq = 200 * T/(2*pi);          % physical system limitation
    
    save('NAME_initialization_data', 'a', 'T', 'dT', 'freq_range') 
    
    
    % t = 0:dT:T-dT;                    %Time Vector
    % t_sample = 0:dT:4*T-dT;             %Time Vector for Sampling
    % F = 0:2*pi/T:2*pi/dT-2*pi/T;        %Frequency Vector
    % K = 1;
    % tau = 1.03;
    
