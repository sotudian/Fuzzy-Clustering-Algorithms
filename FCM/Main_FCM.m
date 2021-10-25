% Shahab Sotudian - 94125091
clc;
clear all;
close all;

% ----------------------------------------------------------------------

load Data_Cross.mat;
Xin = Data_Cross;
cluster_n=4;
[center, U, Objective_Function] = myfcm(Xin, cluster_n);

center