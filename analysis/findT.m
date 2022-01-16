function [T, expcoeff] = findT(r, frac_returns)
%FINDT Find income temperature T
%   [T, expcoeff] = FINDT(r, frac_returns) fits the lower end of the input
%   CDF data, with income points r and corresponding fractions of returns
%   frac_returns, to C(r) = expcoeff * e^(-r/T)

% We first interpolate the CDF via Matlab’s PCHIP
% (piecewise cubic Hermite interpolating polynomial) algorithm in
% log-linear scale. The PCHIP algorithm produces a C^1 interpolation that
% preserves monotonicity and is therefore the best commonly-available
% procedure to apply to both CDFs and Lorenz curves.
interp = pchip(r, log(frac_returns));

% Find last element of CDF that's greater than 1/e. The 1/e point is
% therefore between r(idx) and r(idx+1).
idx = length(frac_returns(frac_returns > exp(-1)));

% get corresponding section of interpolation
section = @(x) interp.coefs(idx,1)*(x - interp.breaks(idx)).^3 ...
                + interp.coefs(idx,2)*(x - interp.breaks(idx)).^2 ...
                + interp.coefs(idx,3)*(x - interp.breaks(idx)) ...
                + interp.coefs(idx,4);
            
% We then estimate T by finding the income at which the interpolated CDF
% drops to 1/e. T_interp is where the log-linear interpolation hits
% log(1/e) = -1.
syms s
T_interp = double(vpasolve(section(s) == -1, s, [r(idx), r(idx+1)]));

% Finally, we find T by performing a linear least-squares fit in
% log-linear scale to all points with income less than the estimated T.
expfit = fit(...
    r(r < T_interp),...
    log(frac_returns(r < T_interp)),...
    'poly1');

% Points being linear in log-lin scale means
% ln(y) = m*x + b => y = e^b e^(mx)
% Note that coeffs is of form [m, b] (highest to lowest order coefficients)
coeffs = coeffvalues(expfit);
T = -1/coeffs(1);
expcoeff = exp(coeffs(2));


end

