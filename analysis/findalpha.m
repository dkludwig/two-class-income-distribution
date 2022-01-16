 function[alpha, paretocoeff] = findalpha(r, frac_returns, nfit)
%FINDALPHA Find Pareto exponent alpha
%   [alpha, pareto_coeff] = FINDALPHA(r, frac_returns, nfit) fits the last
%   nfit points of the input CDF data, with income points r and
%   corresponding fractions of returns frac_returns, 
%   to C(r) = pareto_coeff / r^alpha

% We find alpha by performing a linear least-squares fit in log-log scale
% to the last nfit points.
paretofit = fit(log(r(end-nfit+1:end)),...
    log(frac_returns(end-nfit+1:end)),'poly1');

% Points being linear in log-log scale means 
% ln(y) = m*ln(x) + b => y = e^b x^m.
% Note that coeffs is of form [m, b] (highest to lowest order coefficients)
coeffs = coeffvalues(paretofit);
alpha = -coeffs(1);
paretocoeff = exp(coeffs(2));

end
