%--------------------------------------------------------------------------
% Title: figure7.m
%
% Description:
% This script generates Figure 7 from Davidson, et al. (2023).
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------
clear; close all; clc;
load figure7_data.mat

%description of variables
time_tsl; %time for theoretical shoreline [s]
x_tsl; %position for theoretical shoreline [cm]
time_exsl; %time for experimental shoreline [s]
x_exsl; %position for experimental shoreline [cm]

%% plot
figure
hold on
plot(time_tsl,x_tsl/100,'r','LineWidth',3) %theoretical shoreline trajectory

plot(time_exsl,x_exsl/100,'-xb','LineWidth',2) %experimental shoreline run-up

xlabel('time (s)','interpreter','latex')
ylabel('position (m)','interpreter','latex')
leg = legend({'shoreline model','shoreline data'},'Location','south');
set(gca,'FontSize',25)
set(gca,'TickLabelInterpreter','latex')
set(leg,'Interpreter','latex')
ylim([0 2])
