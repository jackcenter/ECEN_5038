clc; close all;
load('Motor_initialization_data')    
load('Closed_Loop_data.mat')

%% Quarc Post Processing Data: Closed Loop

r = Reference;        %Input Response
pos = Theta;   %Output Response [rad/s]


%% Time Response of System
    figure()
    subplot(2,1,1)
    plot(Time, r)
    xlabel('Time [s]')
    ylabel('Step Input')
    subplot(2,1,2)
    plot(Time, pos)
    xlabel('Time [s]')
    ylabel('Ouput Response')
    
%% FFT of Input and Ouput

    R = fft(r);
    POS = fft(pos);

%     figure()
%     subplot(2,1,1)
%     plot(F,abs(U_MS/length(U_MS)))
%     xlabel('Frequency')
%     ylabel('FFT Input Response')
%     subplot(2,1,2)
%     plot(F,abs(VEL_MS/length(U_MS)))
%     xlabel('Frequency')
%     ylabel('FFT Ouput Response')

    index0 = find(abs(R/length(R)) >= 9e-2); 
    B = 0*R;                     
    B(index0) = POS(index0)./R(index0);        %System Response 
    B(index0) = abs(B(index0));               %Magnitude of System Response
    B_log = 20*log10(B);

    %% Creating Transfer Function
    s = tf('s');
    H = db2mag(K_MS) / (s*(.0205*s +1));                  
    Hcl = H/(1+H);
    
    figure
    hold on
    semilogx(F,B_log,"color", burgandy, "LineStyle", ":", "LineWidth", 1)
    bode(Hcl)
    hold off
       


