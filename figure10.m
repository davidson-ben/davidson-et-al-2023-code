%--------------------------------------------------------------------------
% Title: figure10.m
%
% Description:
% This script generates Figure 10 from Davidson, et al. (2023).
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
gamma = 0.76; %particle to fluid density ratio [-]
Cm = 0.75; %coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
mu = 0.17; %coefficient of friction [-]
s = 1/10; %beach slope [-]
Us = 1.893; %initial shoreline velocity [m/s]
g = 9.81; %gravitational acceleration [m/s^2]
taup = 1; %particle timescale [s]
H_dim = 2.68e-3; %particle height [m]
H = H_dim/(Us^2/g); %dimensionless total height of particle [-]
h_dim = H_dim*gamma; %height of particle below free surface [m]
h = h_dim/(Us^2/g);%dimensionless height of particle below free surface [-]
C = 13.5; %drag proportionality constant for intermediate Re regime [-]
nu = 8.9E-4; %fluid viscosity [Pa*s]
D = 2.26e-2; %particle diameter [m]

%initial conditions
ti_experimental_particles = [0.0201    0.0559    0.0371    0.0259    0.0744]; %dimensional initial times from exp. particles [s]
Vpi_experimental_particles = [2.0125    1.0711    1.4509    1.6229    1.1006]; %dimensional initial velocity from exp. particles [m/s]

%% solve model and plot

figure
tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');
set(gcf,'Position',[100 400 1800 500])

for k = 1:3 %only plotting first 3 particles
    nexttile
    [xp, vp, t] = swash_part_model(ti_experimental_particles(k),Vpi_experimental_particles(k),Cm,mu,gamma,taup); %solve model for given particle
    xs = t-0.5*s*t.^2; %shoreline position
    xi = xs - xp; %distance particle is behind shoreline
    us = 1-s*t; %shoreline velocity
    DuDt = zeros(size(xp));
    u = zeros(size(xp));
    phi = zeros(size(xp));

    depth_p = zeros(size(xp));
    for i = 1:length(xp)
        %set depth at particle
        if xi(i) > 0
            depth_p(i) = (1/9)*(1 - 0.5*s*t(i) - xp(i)/t(i))^2;
        elseif xi(i) <= 0
            depth_p(i) = 0; %depth is zero if particle is infront of shoreline
        end
    end

    for i = 1:length(xp)
        %compute particle velocity and acceleration from fluid forcing and added mass (DuDt)
        if xi(i) > 0
            DuDt(i) = (2/9)*(-5*s + 1/t(i) - xp(i)/t(i)^2);
            u(i) = (1/3)*(1-(2*s*t(i))+(2*xp(i)/t(i)));
        elseif xi(i) ==0 %velocity is equal to shoreline velocity when at the shoreline
            DuDt(i) = (2/9)*(-5*s + 1/t(i) - xp(i)/t(i)^2);
            u(i)=us(i);
        elseif xi(i) <= 0 %velocity and acceleration due to fluid forcing and added mass is zero if the particle is infront of the shoreline
            DuDt(i) = 0;
            u(i) = 0;
        end
        
        %set submergence ratio
        if depth_p(i) >= h
            phi(i) = gamma; %equal to density ratio if depth is greater than the maximum particle submergence height
        elseif depth_p(i) < h
            phi(i) = depth_p(i)/H;
        end
    end
    
    %beta
    if u>=0
        beta = 1; %beta = 1 on run-up
    else
        beta = (phi + Cm*phi)./(gamma + Cm.*phi);
    end

    % calculate acceleration components    
    term1 = beta.*DuDt; %fluid and added mass
    term2 = (2*C.*phi*nu)./(pi*D^2.*(gamma + Cm.*phi)).*(u-vp); % drag
    term3 = (mu)*ones(length(xp)); %friction

    % plot
    hold on
    plot(t(depth_p>0),term1(depth_p>0),'Color',"b",'LineWidth',2) %fluid and added mass acts whenever depth >0
    plot(t(depth_p>0),term2(depth_p>0),'Color',"r",'LineWidth',2) %drag acts whenever depth >0
    plot(t(depth_p<=0 & abs(vp)>1e-3),term3(depth_p<=0 & abs(vp)>1e-3),'Color',"m",'LineWidth',2) %friction acts whenever depth <= 0

    xlabel('time (-)','interpreter','latex')
    ylabel('acceleration (-)','interpreter','latex')
    set(gca,'TickLabelInterpreter','latex')
    set(gca,'FontSize',35)
    ylim([-1 1])
    xlim([0 20])

    %flow reversal
    zc = min(find(diff(sign(vp))));
    plot([t(zc) t(zc)],[-10 10],'--k','LineWidth',2)

end

annotation('textbox',[0 0.9 0.1 0.1],'string','$(a)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.33 0.9 0.1 0.1],'string','$(b)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.65 0.9 0.1 0.1],'string','$(c)$','Interpreter','latex','FontSize',35,'EdgeColor','none')

legend('$\beta Du/Dt$','$(u-v_p)/\mathrm{St}$','$- \mu ~\mathrm{sgn}(v_p)$');
legend('Location','south')
legend('Interpreter','latex')
legend('Location','southeast')