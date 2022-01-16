function med = findmedian(r, frac_returns)
%FINDMEDIAN Find median income
%   med = FINDMEDIAN(r, frac_returns) finds the median income of input
%   CDF data, with income points r and corresponding fractions of returns
%   frac_returns, by interpolation.

% First interpolate the CDF via Matlab’s PCHIP
% (piecewise cubic Hermite interpolating polynomial) algorithm in
% log-linear scale. The PCHIP algorithm produces a C^1 interpolation that
% preserves monotonicity and is therefore the best commonly-available
% procedure to apply to both CDFs and Lorenz curves.
interp = pchip(r, log(frac_returns));

% Find last element of CDF that's greater than 0.5. The 0.5 point is
% therefore between r(idx) and r(idx+1).
idx = length(frac_returns(frac_returns > 0.5));

% get corresponding section of interpolation
section = @(x) interp.coefs(idx,1)*(x - interp.breaks(idx)).^3 ...
                + interp.coefs(idx,2)*(x - interp.breaks(idx)).^2 ...
                + interp.coefs(idx,3)*(x - interp.breaks(idx)) ...
                + interp.coefs(idx,4);
            
% solve for median, which is where the interpolation drops to log(0.5)
syms s
med = double(vpasolve(section(s) == log(0.5), s, [r(idx), r(idx+1)]));


end
