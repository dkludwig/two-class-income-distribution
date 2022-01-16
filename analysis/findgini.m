function gini = findgini(frac_returns, frac_share)
%FINDGINI Find Gini coefficient
%   share = FINDGINI(frac_returns, frac_share) integrates an interpolant of
%   the Lorenz curve data, with fractions of returns frac_returns and
%   corresponding fractional shares frac_share, to calculate the Gini
%   coefficient.

% Interpolate the CDF via Matlab’s PCHIP
% (piecewise cubic Hermite interpolating polynomial) algorithm in
% log-linear scale. The PCHIP algorithm produces a C^1 interpolation that
% preserves monotonicity and is therefore the best commonly-available
% procedure to apply to both CDFs and Lorenz curves.
lorenz = griddedInterpolant(frac_returns, frac_share, 'pchip');

% Integrate interpolation from 0 to 1
a = integral(@(x) lorenz(x), 0, 1);

% The Gini coefficient is defined as twice the area between the Lorenz
% curve and the 45 degree line of perfect equality
gini = 1 - 2*a;
end