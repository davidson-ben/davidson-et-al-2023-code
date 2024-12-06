%--------------------------------------------------------------------------
% Title: swash_part_model_iter.m
%
% Description:
% This function iteratively solves the swash_part_model_int over a range of
% intial particle velocity to initial shoreline velocity of (0.3962 -
% 1.0565) [m/s] and Stokes Number (St) of (0.5182 - 10.3645) [-] with Us =
% 1.893 [m/s].
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------

function [UiUs, Sts, x_end_norm] = swash_part_model_iter(gamma,Cm,mu,s,ti_tf)
% swash_part_model_iter.m        Iteratively solve swash_part_model_int.m
%
% Inputs
%   gamma - particle to fluid density ratio [-]
%   Cm - coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
%   mu - coefficient of friction [-]
%   s - beach slope [-]
%   ti_tf - dimensionless initial particle times [-]


% initialize parameters
g = 9.81; % gravitational acceleration [m/s^2]
Us = 1.893; % initial shoreline velocity [m/s]
H_dim = 2.68e-3; % particle height [m]
k = 10; %sharpness factor [-]
w = 0.25; %effective St zone width [-]
H = H_dim/(Us^2/g); %dimensionless total height of particle [-]
h_dim = H_dim*gamma; %height of particle below free surface [m]
h = h_dim/(Us^2/g); %dimensionless height of particle below free surface [-]

%time
tf = 2*Us/g/s; %particle final time [s]
ti = ti_tf*tf; %particle initial time [s] -- must be greater than zero to avoid singularity in flow model
ti_dimless = ti/(Us/g); %particle initial time [-]
tf_dimless = tf/(Us/g); %particle final time [-]
t = linspace(ti_dimless,tf_dimless,200); %dimensionless time vector [-]

%velocity
Vpi = linspace(0.75,2,200); %particle inital velocity [m/s]
Vpi_dimless = Vpi/Us; %particle inital velocity [-]

%taup
taup = linspace(.1,2,200); %particle timescale [s]

x_end = zeros(length(taup),length(Vpi)); %final position
v_end = zeros(length(taup),length(Vpi)); %final velocity

%% integrate
for i = 1:length(taup) %vary taup
    for j = 1:length(Vpi) %vary Vpi
        St = g*taup(i)/Us; % Stokes number
        xp0 = [0 Vpi_dimless(j)]; %dimensionless particle initial location and velocity
        [t,xp_out] = swashinertialparticle_int(s,St,H,xp0,t,mu,Cm,gamma,k,w); %integrate
        x_end(i,j) = xp_out(end,1); %final position
        v_end(i,j) = xp_out(end,2); %final velocity
    end
end

xp = xp_out(:,1); %dimensionless particle position [-]
vp = xp_out(:,2); %dimensionless particle velocity [-]
t; %dimensionless time [-]

UiUs = Vpi/Us; %ratio of initial particle velocity to initial shoreline velocity [-]
Sts = g*taup/Us; %particle Stokes number [-]
x_end_norm = x_end/5; %final particle position over maximum shoreline run-up [-]

end