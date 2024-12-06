%--------------------------------------------------------------------------
% Title: swashinertialpartilce_ode.m
%
% Description:
% This is the particle acceleration function which is integrated to find
% the particle velocity and position.
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------

function dxp = swashinertialparticle_ode(s,St,H,xp,t,mu,Cm,gamma,k,w)
% swashinertialparticle_ode  Particle acceleration function to integrate.
%
% Inputs
%   gamma - particle to fluid density ratio [-]
%   Cm - coefficient of added mass [-] (Cm=1 for infinite cylinder, Cm = 1/2 for sphere)
%   mu - coefficient of friction [-]
%   s - beach slope [-]
%   St - Stokes number [-]
%   H - dimensionless height of particle [-]
%   xp - vector: [(particle position) (particle velocity)] [- -]
%   t - vector of time [-]
%   k - sharpness factor for C_St [-]
%   w - width of C_St zone [-]


%% shoreline and particle parameters
xs = t - 0.5*s*t^2; %shoreline position [-]
us = 1-s*t; %shoreline velocity [-]

% relative particle position
xi = xs-xp(1); %shoreline position - particle position [-]

C_St = 1./(1 + exp(-k*(xi-w))); %effective Stokes coefficient [-]
St_eff = St*C_St; %effective Stokes number [-]

%% flow
if xi > 0 %particle is behind shoreline
    depth = (1/9)*(1 - 0.5*s*t - xp(1)/t)^2;
    u = (1/3)*(1-(2*s*t)+(2*xp(1)/t));
    DuDt = (2/9)*(-5*s + 1/t - xp(1)/t^2);
elseif xi == 0 %particle is at shoreline
    depth=0;
    u=us;
    DuDt=(2/9)*(-5*s + 1/t - xs/t^2);
elseif xi < 0 % particle is in front of shoreline
    depth=0;
    u=0;
    DuDt=0;
end

%depth cannot be negative
if depth <= 0
    depth = 0;
end

h = H*gamma; %height of particle below the free surface [-]

if depth >= h %particle is freely floating
    phi = gamma;
elseif depth < h %particle is touching the beach
    phi = depth/H;
end

beta = (phi + Cm*phi)/(gamma + Cm*phi);

dxp = zeros(2,1); %particle change of position and velocity: [(dxp/dt) (dvp/dt)]
dxp(1) = xp(2); %dxp/dt = vp

if u > 0 %on runup
    mu_calc = 0; %no friction with beach
    St_calc = St_eff;
    beta = 1;
elseif u <= 0 %on run-down
    if depth > h %particle is freely floating
        mu_calc = 0;
        St_calc = St;
    elseif depth <= h && depth > 0 %particle is touching the beach, but there is still water present
        mu_calc = 0;
        St_calc = St;
    elseif depth == 0 %particle is touching the beach and has run out of water
        mu_calc = mu;
        St_calc = St; %won't matter since beaching condition is triggered
    end
end

dxp(2) = beta*DuDt + (u - xp(2))/(St_calc); %particle acceleration

% beaching process
    if u <= 0 %beaching can only occur on drawdown
        if depth == 0 %if particle runs out of water
            if xp(2)<0 %if particle is still moving backwards
                dxp(2) = mu; %only forces on the particle are gravity acting down and friction acting up
            elseif xp(2) >= 0 % if the particle stops moving (or begins moving up the beach slightly) then gravity and friction have reached equilibrium
                dxp(2) = 0; %particle acceleration becomes zero
                dxp(1) = 0; %particle velocity becomes zero
            end
        end
    end
end