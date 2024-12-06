%--------------------------------------------------------------------------
% Title: figure9.m
%
% Description:
% This script generates Figure 9 from Davidson, et al. (2023).
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------
clear; close all; clc;

%parameters
Us = 1.893; %initial shoreline velocity [m/s]
g = 9.81; %gravitational acceleration [m/s^2]
s = 1/10; %beach slope [-]

%dimensional initial conditions (ICs)
ti_dim = [0.0201    0.0559    0.0371    0.0259    0.0744]; %dimensional initial times from exp. particles [s]
Vp_dim = [2.0125    1.0711    1.4509    1.6229    1.1006]; %dimensional initial velocities from exp. particles [m/s]

%dimensionless initial conditions (ICs)
Vp = Vp_dim/Us; %dimensionless initial velocities [-]
ti = ti_dim/(2*Us/(g*s)); %dimensionless initial times [-]

%% plot
figure
scatter(ti,Vp,50,'ok','Filled')
xlabel('$t_{p0}/(2Us/(gs))$ (-)','interpreter','latex')
ylabel('$V_{p0}/U_s$ (-)','interpreter','latex')
set(gca,'FontSize',25)
set(gca,'TickLabelInterpreter','latex')

annotation('textbox',[0.15 0.91 0 0],'string','A','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.23 0.655 0 0],'string','D','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.38 0.54 0 0],'string','C','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.63 0.288 0 0],'string','B','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.875 0.308 0 0],'string','E','Interpreter','latex','FontSize',25,'EdgeColor','none')