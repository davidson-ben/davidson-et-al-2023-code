%--------------------------------------------------------------------------
% Title: figure8.m
%
% Description:
% This script generates Figure 8 from Davidson, et al. (2023).
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------
clear; close all; clc;

load figure8_data.mat
% description of variables
x_shore; %shoreline position over time [m]
particles; %particle positions for 5 particles over time [m]
time; %time domain [s]

%set parameters
gamma = 0.76; %particle to fluid density ratio [-]
Cm = 0.75; %coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
mu = 0.15; %coefficient of friction [-]
s = 1/10; %beach slope [-]
Us = 1.893; %initial shoreline velocity [m/s]
g = 9.81; %graviational acceleration [m/s^2]
taup = 1; %particle timescale [s]

%% solve model and plot
figure
tiledlayout(2,3,'TileSpacing','Compact','Padding','Compact');
set(gcf,'Position',[100 400 1200 700])
%particle initial conditions (ICs)
ti_experimental_particles = [ 0.0109    0.0559    0.0371    0.0259    0.0744]; %dimensional initial times from experimental particles [T]
Vpi_experimental_particles = [  1.9528    1.0711    1.4509    1.6229    1.1006]; %dimensional initial velocities from experimental particles [L/T]

for i = 1:5 %loop through each particle
    nexttile
    [xp, vp, t] = swash_part_model(ti_experimental_particles(i),Vpi_experimental_particles(i),Cm,mu,gamma,taup); %solve the model with particle ICs
    plot(t,xp,'r--','LineWidth',2) %plot model particle trajectory (dimensionless)
    hold on
    plot(t,t-0.5*s*t.^2,'r-','LineWidth',2) %plot model shoreline trajectory (dimensionless)
    time_exp_part = time/(Us/g); %experimental particle time (dimensionless)
    pos_exp_part = particles(i,:)/(100*(Us^2/g)); %experimental particle position (dimensionless)
    plot(time_exp_part,pos_exp_part,'b--','LineWidth',2) %plot experimental particle trajectory
    plot(time/(Us/g),x_shore/(Us^2/g),'b-','LineWidth',2) %plot experimental shoreline position
    xlabel('time (-)','interpreter','latex')
    ylabel('position (-)','interpreter','latex')
    set(gca,'FontSize',25)
    set(gca,'TickLabelInterpreter','latex')
    ylim([0 5])
end

leg = legend('particle model','shoreline model','particle data','shoreline data','FontSize',25);
set(leg,'Interpreter','latex')
set(leg,'Position',[0.7153    0.2213    0.1980    0.1320])

% letters
annotation('textbox',[0 0.9 0.1 0.1],'string','$(a)$','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.32 0.9 0.1 0.1],'string','$(b)$','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.64 0.9 0.1 0.1],'string','$(c)$','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0 0.4 0.1 0.1],'string','$(d)$','Interpreter','latex','FontSize',25,'EdgeColor','none')
annotation('textbox',[0.32 0.4 0.1 0.1],'string','$(e)$','Interpreter','latex','FontSize',25,'EdgeColor','none')