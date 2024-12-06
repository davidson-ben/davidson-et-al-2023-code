%--------------------------------------------------------------------------
% Title: swashinertialparticle_int.m
%
% Description:
% Set up the integration of the swashinertialparticle_ode.m function.
%
% Author: B. Davidson
% Last Updated: 06 December 2024
%
% Citation:
% Davidson, et al. (2023). Beaching model for buoyant marine debris in
% bore-driven swash. Flow.
%--------------------------------------------------------------------------

function [t,xp] = swashinertialparticle_int(s,St,H,xp0,t,mu,Cm,gamma,k,shift)
% swashinertialparticle_int.m       Set up integration of swashinertialparticle_ode.m

% function to integrate
rhs = @(t,xp) swashinertialparticle_ode(s,St,H,xp,t,mu,Cm,gamma,k,shift);
% integrate
[t,xp] = ode45(rhs,t,xp0); 

end