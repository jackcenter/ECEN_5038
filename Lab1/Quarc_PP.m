clear; clc; close all;

blue = [0, 0.4470, 0.7410];
orange = [0.8500, 0.3250, 0.0980];
yellow = [0.9290, 0.6940, 0.1250];
green = [0.4660, 0.6740, 0.1880];
grey = [0.5, 0.5, 0.5];
purple = [0.4940, 0.1840, 0.5560];
light_blue = [0.3010, 0.7450, 0.9330];
burgandy = [0.6350, 0.0780, 0.1840];

%% Quarc Post-Processing Data: Step Response
load('Motor_initialization_data')    
load('step_response_data.mat')


    u = Input;                                                              %Input Signal
    pos = Theta;                                                            %Position [rad]
    vel = dTheta;                                                           %Velocity [V]
    T = 10;
    t = 0:dT:T-dT;                                                          %Time Vector
    f =0:2*pi/T:2*pi/dT-2*pi/T;                                             %Frequency Vector [rad/s]
    
    % Identifying the System
    n = 300;
    k = (Theta(end) - Theta(end-n)) / ( Time(end) - Time(end-n) );          %"Slope" [rad/s]
    
    volt_avg = mean(vel(end-n:end));                                        %Transient Voltage
    volt_avg_60 = volt_avg*0.632;                                           %60% of Transient Voltage
    index_tau = length(vel(1:find(vel > volt_avg_60)));
    tau = Time(index_tau) - 1; 
    
    K = k/volt_avg;        %[(rad/s)/V]
    %vel = vel* K/volt_avg; %[rad/s]                                        WHY DID WE DO THIS
    %Vel_avg = mean((vel(end-n:end))); 
    %% Creating Transfer Function
    s = tf('s');
    % TF = K / (tau*s +1);               %Tranfer Function with vel thing
    TF = 1.4623 / (0.0205*s + 1);  % from multi-sine
    % TF = k / (tau*s + 1);                 % from step id

    output_TF = lsim(TF, u, Time);
    
    %% Time Response of System
    figure
    title("Time Response from a Step Input")
    hold on
    plot(Time, u, "color", grey, "LineStyle", "-")
    plot(Time, vel, ':', "color", burgandy, "LineWidth", .7)
    alpha(.5)
    plot(Time, output_TF, "color", blue, "LineStyle", "--", "LineWidth", 1)
    hold off
    xlabel('Time [s]')
    ylabel('Ouput (y)')
    legend("Input", "Data", "Simulation", "Location", "southeast")
    
    
    

    
    
    

    