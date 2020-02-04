clear; clc; close all;
%% Test Data
Time = 1:100;
Input = 1:100;
Y_1 = .5:.5:50;
Y_2 = .25:.25:25;

%% Data Processing

%% Data Transfer
save('NAME_output_data.mat', 'Time', 'Input', 'Y_1', 'Y_2')     