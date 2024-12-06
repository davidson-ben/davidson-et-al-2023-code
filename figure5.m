%--------------------------------------------------------------------------
% Title: figure5.m
%
% Description:
% This script generates Figure 5 from Davidson, et al. (2023).
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------
clear; close all; clc;

% Plot synthetic particle trajectory with St from [1 10] while Vp0Us = 0.75
% and with Vp0Us = [0.5 1] while St = 5

%parameters
gamma = 0.76; %particle to fluid density ratio [-]
Cm = 0.75; %coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
mu = 0.17; %coefficient of friction [-]
s = 1/10; %beach slope [-]
Us = 1.893; %initial shoreline velocity [m/s]
g = 9.81; %gravitational acceleration [m/s^2]
VpUs = 0.75; %ratio of initial particle velocity to initial shoreline velocity [-]
Vpi = VpUs*Us; %initial particle velocity [m/s]
ti = 0.0386; %dimensional initial time [-]
St = linspace(1,10,10); %range of St [-]
taup = St*Us/g; %particle timescale [s]

%% solve and plot
figure

tiledlayout(1,3,'TileSpacing','loose','Padding','loose');
set(gcf,'Position',[100 400 1200 500])

c = colorbar;
cmap = colormap('parula');
clim([min(St) max(St)])
lower_St = min(St);
upper_St = max(St);
St_scaled=(St-lower_St)./(upper_St-lower_St);
St_scaled(St_scaled<0)=0;St_scaled(St_scaled>1)=1;
St_scaled=round(1+St_scaled*(size(cmap,1)-1));%round to nearest index

nexttile

hold on
for i = 1:length(St)
    Col = cmap(St_scaled(i),:);
    [xp, vp, t] = swash_part_model(ti,Vpi,Cm,mu,gamma,taup(i)); %solve model
    plot(t,xp,'LineWidth',2,'color',Col) %model particle trajectory (dimensionless)
end

xlabel('time (-)','interpreter','latex')
ylabel('position (-)','interpreter','latex')
set(gca,'FontSize',35)
set(gca,'TickLabelInterpreter','latex')
ylim([0 5])
c = colorbar;
c.Label.Interpreter = 'latex';
clim([1 10])

set(gca,'TickLabelInterpreter','latex')
colorbar('TickLabelInterpreter', 'latex');
annotation('textbox',[0.43 0.91 0.1 0.1],'string','$St$','Interpreter','latex','FontSize',35,'EdgeColor','none')

nexttile
St = 5;
tp = St*Us/g;
VpiUs = linspace(0.5,1,10);
Vpi = VpiUs*Us;

c = colorbar;
cmap = colormap('parula');
clim([min(VpiUs) max(VpiUs)])
lower_VpiUs = min(VpiUs);
upper_VpiUs = max(VpiUs);
VpiUs_scaled=(VpiUs-lower_VpiUs)./(upper_VpiUs-lower_VpiUs);
VpiUs_scaled(VpiUs_scaled<0)=0;VpiUs_scaled(VpiUs_scaled>1)=1;
VpiUs_scaled=round(1+VpiUs_scaled*(size(cmap,1)-1));%round to nearest index

hold on
for i = 1:length(Vpi)
    Col = cmap(VpiUs_scaled(i),:);
    [xp, vp, t] = swash_part_model(ti,Vpi(i),Cm,mu,gamma,tp); %solve model
    plot(t,xp,'LineWidth',2,'color',Col) %model particle trajectory (dimensionless)
end

xlabel('time (-)','interpreter','latex')
ylabel('position (-)','interpreter','latex')
set(gca,'FontSize',35)
set(gca,'TickLabelInterpreter','latex')
ylim([0 5])
c = colorbar;
c.Label.Interpreter = 'latex';
clim([0.5 1])

set(gca,'TickLabelInterpreter','latex')
colorbar('TickLabelInterpreter', 'latex');
annotation('textbox',[0.86 0.91 0.1 0.1],'string','$V_{p0}/U_s$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0 0.9 0.1 0.1],'string','$(a)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.5 0.9 0.1 0.1],'string','$(b)$','Interpreter','latex','FontSize',35,'EdgeColor','none')