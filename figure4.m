%--------------------------------------------------------------------------
% Title: figure4.m
%
% Description:
% This script generates Figure 4 from Davidson, et al. (2023).
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
Cm = 0.75; %coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
mu = 0.17; %coefficient of friction [-]
gamma = 0.76; %particle to fluid density ratio [-]
s = 1/10; %beach slope [-]
titf=[0.001 0.01 0.1]; %dimensionless initial particle times [-]

%titf = 0.001
[UiUs_1, Sts_1, x_end_1] = swash_part_model_iter(gamma,Cm,mu,s,titf(1)); %solve the model over Vpi/Us = [0.3962 1.0565] and St = [0.5182 10.3645]
x_end_1(x_end_1<0) = NaN; %model can't continue if the particle moves behind the still water line

%titf = 0.01
[UiUs_2, Sts_2, x_end_2] = swash_part_model_iter(gamma,Cm,mu,s,titf(2)); %solve the model over Vpi/Us = [0.3962 1.0565] and St = [0.5182 10.3645]
x_end_2(x_end_2<0) = NaN; %model can't continue if the particle moves behind the still water line

%titf = 0.1
[UiUs_3, Sts_3, x_end_3] = swash_part_model_iter(gamma,Cm,mu,s,titf(3)); %solve the model over Vpi/Us = [0.3962 1.0565] and St = [0.5182 10.3645]
x_end_3(x_end_3<0) = NaN; %model can't continue if the particle moves behind the still water line

%% plot

figure
set(gca,'TickLabelInterpreter','latex')
set(gcf,'Position',[100 400 1800 500])
t = tiledlayout(1,3,'TileSpacing','loose','Padding','loose');
nexttile
contourf(UiUs_1,Sts_1,x_end_1,1000,'EdgeColor','none')
xlabel('$V_{p0}/U_s$','Interpreter','latex')
ylabel('$St$','Interpreter','latex')
set(gca,'FontSize',35)
set(gca,'TickLabelInterpreter','latex')
xlim([0.5 1])
clim([0 1])
ylim([1 10])

nexttile
contourf(UiUs_2,Sts_2,x_end_2,1000,'EdgeColor','none')
xlabel('$V_{p0}/U_s$','Interpreter','latex')
ylabel('$St$','Interpreter','latex')
set(gca,'FontSize',35)
set(gca,'TickLabelInterpreter','latex')
xlim([0.5 1])
clim([0 1])
ylim([1 10])
hold on
plot([0.5 1],[5 5],'--w','linewidth',3)
plot([0.75 0.75],[1 10],':w','linewidth',3)
%plot(0.75,5,'xw','MarkerSize',20,'LineWidth',3)

nexttile
contourf(UiUs_3,Sts_3,x_end_3,1000,'EdgeColor','none')
xlabel('$V_{p0}/U_s$','Interpreter','latex')
ylabel('$St$','Interpreter','latex')
c = colorbar;
c.Label.String = '$x_p / x_{s max}$';
clim([0 1])
set(gca,'FontSize',35)
set(gca,'TickLabelInterpreter','latex')
c.Label.Interpreter = 'latex';
c.Label.FontSize = 35;
xlim([0.5 1])
ylim([1 10])

annotation('textbox',[0.005 0.9 0.1 0.1],'string','$(a)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.315 0.9 0.1 0.1],'string','$(b)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.625 0.9 0.1 0.1],'string','$(c)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.88 0.92 0.1 0.1],'string','$x_p/x_s$','Interpreter','latex','FontSize',35,'EdgeColor','none')

colorbar('TickLabelInterpreter', 'latex');