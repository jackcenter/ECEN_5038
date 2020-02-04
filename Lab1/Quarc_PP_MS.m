clc; close all;

blue = [0, 0.4470, 0.7410];
orange = [0.8500, 0.3250, 0.0980];
yellow = [0.9290, 0.6940, 0.1250];
green = [0.4660, 0.6740, 0.1880];
grey = [0.5, 0.5, 0.5];
purple = [0.4940, 0.1840, 0.5560];
light_blue = [0.3010, 0.7450, 0.9330];
burgandy = [0.6350, 0.0780, 0.1840];

load('Motor_initialization_data', 'a', 'T', 'dT', 'F')    
load('multisin_response_data.mat')

%% Quarc Post Processing Data: Muti-Sine

u_MS = Input_MS;        %Input Response
vel_MS = dTheta_MS*K;   %Output Response [rad/s]

%% Time Response of System
    figure()
    subplot(2,1,1)
    plot(Time_MS, u_MS)
    xlabel('Time [s]')
    ylabel('Step Input')
    subplot(2,1,2)
    plot(Time_MS, vel_MS)
    xlabel('Time [s]')
    ylabel('Ouput Response')
    
%% FFT of Input and Ouput

    U_MS = fft(u_MS);
    VEL_MS = fft(vel_MS);
    

    figure()
    hold on
    plot(F,abs(U_MS/length(U_MS)), "color", grey, "LineStyle", "-")
    plot(F,abs(VEL_MS/length(U_MS)), "color", burgandy, "LineStyle", ":")
    hold off
    title("Multi-sine Input and Output")
    legend("Input", "Output Data")
    xlabel('Frequency [rad/s]')
    ylabel('Response')
    xlim([0, 3141])

    index0 = find(abs(U_MS/length(U_MS)) >= 9e-2); 
    B = 0*U_MS;                     
    B(index0) = VEL_MS(index0)./U_MS(index0);        %System Response 
    B(index0) = abs(B(index0));               %Magnitude of System Response
    B_log = 20*log10(B);
      
    K_MS = mean(B_log(2:25));
    K_3dB = K_MS - 3;
    Index_tau = find(B_log(2:end) < K_3dB);
    Index_tau = Index_tau(1)+1;
    omega_MS = F(Index_tau);
    tau_MS = 1/omega_MS;
    
    %% Creating Transfer Function
    s = tf('s');
%     K_MS = db2mag(K_MS);
%     H = K_MS / (.0205*s +1);                  
    
    K_MS = 1.3831;
    H = K_MS / (.0280*s +1);   
    
    figure
    hold on
    semilogx(F,B_log,"color", burgandy, "LineStyle", ":", "LineWidth", 1)
    bode(H)
    hold off
    
   

   







