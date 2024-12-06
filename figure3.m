%--------------------------------------------------------------------------
% Title: figure3.m
%
% Description:
% This script generates Figure 3 from Davidson, et al. (2023).
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
k = 10; %sharpness factor [-]
w = 0.25; %zone width [-]
xi = 0:0.01:5; %particle distance behind shoreline [-]
sw = 0:0.01:5; %shoreline position [-]

[SW, XI] = meshgrid(sw,xi);
C_St = zeros(length(sw),length(xi));

for i = 1:length(sw) %iterate over shoreline position
    for j = 1:length(xi) %iterate over particle distance behind shoreline
        C_St(i,j) = 1./(1 + exp(-k*(xi(j)-w))); %compute St_effective
        if xi(j) > sw(i)
            C_St(i,j) = NaN;
        end
    end
end

%% plot

figure
contourf(XI,SW,C_St,100,'EdgeColor','none')
xlabel('$x_s$','interpreter','latex')
ylabel('$\xi$','interpreter','latex')
c = colorbar;
c.Label.Interpreter = 'latex';
c.Label.String = '$C_{St}$';
axis ij
clim([0 1])
set(gca,'FontSize',20)
set(gca,'TickLabelInterpreter','latex')
colorbar('TickLabelInterpreter', 'latex');
annotation('textbox',[0.83 0.9 0.1 0.1],'string','$C_{St}$','Interpreter','latex','FontSize',20,'EdgeColor','none')

colormap(flipud(parula))

hYLabel = get(gca,'YLabel');
set(hYLabel,'rotation',0,'VerticalAlignment','middle')