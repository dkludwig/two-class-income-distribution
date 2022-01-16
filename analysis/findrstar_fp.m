function [rstar, fp] = findrstar_fp(T, expcoeff, alpha, paretocoeff)
%FINDRSTAR_FP Find cutoff income between the lower and upper classes r*
%             and fraction of population in the upper class fp
%   [rstar, fp] = FINDRSTAR_FP(T, expcoeff, alpha, paretocoeff) solves for
%   the intersection point between the exponential fit for the lower class
%   and the Pareto power law fit for the upper class

% uses initial estimate of r* = 3T
syms r
rstar = double(vpasolve(expcoeff*exp(-r/T) == paretocoeff*r^(-alpha),...
    r, 3*T));
% evaluates the exponential fit at r* to get fp
fp = expcoeff*exp(-rstar/T);

end

