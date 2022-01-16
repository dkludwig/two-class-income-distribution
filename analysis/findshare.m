function share = findshare(frac_returns, frac_share, p)
%FINDSHARE Find share of fraction of population p from given Lorenz curve
%   share = FINDSHARE(r, frac_returns, nfit) interpolates the input Lorenz
%   curve data, with fractions of returns frac_returns and corresponding
%   fractional shares frac_share, and plugs in point p

% Interpolate the CDF via Matlab’s PCHIP
% (piecewise cubic Hermite interpolating polynomial) algorithm in
% log-linear scale. The PCHIP algorithm produces a C^1 interpolation that
% preserves monotonicity and is therefore the best commonly-available
% procedure to apply to both CDFs and Lorenz curves.
interplorenz = griddedInterpolant(frac_returns, frac_share, 'pchip');
share = interplorenz(p);

end