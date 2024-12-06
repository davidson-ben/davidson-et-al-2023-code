%--------------------------------------------------------------------------
% Title: swash_part_model.m
%
% Description:
%   Model the trajectory of an inertial particle in one dimensional swash
%   flow given the initial conditions with which the particle enters the
%   swash zone (ti is the length of time between the initial shoreline
%   motion and the particle crossing the initial shoreline location - this
%   must be greater than zero to avoid singularity, Vpi is the velocity
%   with which the particle crosses the initial shoreline), the particle
%   coefficient of added mass (Cm), the coefficient of friction between the
%   particle and the beach (mu), the density ratio between the particle and
%   the fluid (gamma) and the relaxation time for the particle in the flow
%   (taup).  The outputs are the particle positions (xp), the particle
%   velocities (vp) and the time domain (t) as vectors.
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------

function [xp,vp,t] = swash_part_model(ti,Vpi,Cm,mu,gamma,taup)
% swash_part_model.m         One Dimensional Inertial Particle Model in Swash Flow
% 
% Inputs
%   ti - initial particle time [s]
%   Vpi - initial particle velocity [m/s]
%   Cm - coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
%   mu - coefficient of friction [-]
%   gamma - particle to fluid density ratio [-]
%   taup - particle timescale [s]

%% initialize
s = 1/10; % beach slope [-]
g = 9.81; % gravitational acceleration [m/s^2]
Us = 1.893; % initial shoreline velocity [m/s]
H_dim = 2.68e-3; % particle height [m]
tf = 2*Us/g/s; % particle final time [s]
h_dim = H_dim*gamma; %height of particle below free surface [m]
St = g*taup/Us; % Stokes number [-]
k = 10; %sharpness factor [-]
w = 0.25; %C_St zone width [-]
H = H_dim/(Us^2/g); %dimensionless total height of particle [-]
h = h_dim/(Us^2/g); %dimensionless height of particle below free surface [-]
ti_dimless = ti/(Us/g); %particle initial time [-]
tf_dimless = tf/(Us/g); %particle final time [-]
Vpi_dimless = Vpi/Us; %particle inital velocity [-]
t = linspace(ti_dimless,tf_dimless,1e3); %dimensionless time vector [-]
xp0 = [0 Vpi_dimless]; %dimensionless particle initial location and velocity [-]

%% integrate
[t,xp_out] = swashinertialparticle_int(s,St,H,xp0,t,mu,Cm,gamma,k,w); %solve model

xp = xp_out(:,1); %dimensionless particle position [-]
vp = xp_out(:,2); %dimensionless particle velocity [-]
t; %dimensionless time [-]

end