%--------------------------------------------------------------------------
% Title: figure6.m
%
% Description:
% This script generates Figure 6 from Davidson, et al. (2023).
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------
clear; close all; clc;

load figure6_data.mat

start_runup; %beginning of runup frame
max_runup; %maximum runup frame
last; %last frame

%% plot
figure

tiledlayout(1,3,'TileSpacing','Compact','Padding','Compact');
set(gcf,'Position',[ 1           1        1512         865])

nexttile

%final frame
imshow(last)
hold on

%plot particle trajectories
plot(x(1,:),1280-ypx(1,:),'s','MarkerFaceColor',"#0072BD",'MarkerEdgeColor','none','MarkerSize',8)
plot(x(2,:),1280-ypx(2,:),'d','MarkerFaceColor',"#D95319",'MarkerEdgeColor','none','MarkerSize',8)
plot(x(3,:),1280-ypx(3,:),'pentagram','MarkerFaceColor',"#EDB120",'MarkerEdgeColor','none','MarkerSize',10)
plot(x(4,:),1280-ypx(4,:),'o','MarkerFaceColor',"#7E2F8E",'MarkerEdgeColor','none','MarkerSize',7)
plot(x(5,:),1280-ypx(5,:),'^','MarkerFaceColor',"#77AC30",'MarkerEdgeColor','none','MarkerSize',7)

nexttile

%beginning of runup frame
imshow(start_runup)

nexttile

%maximum runup frame
imshow(max_runup)

annotation('textbox',[0.01 0.9 0.1 0.1],'string','$(a)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.33 0.9 0.1 0.1],'string','$(b)$','Interpreter','latex','FontSize',35,'EdgeColor','none')
annotation('textbox',[0.65 0.9 0.1 0.1],'string','$(c)$','Interpreter','latex','FontSize',35,'EdgeColor','none')