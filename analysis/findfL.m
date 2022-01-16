function fL = findfL(frac_returns, frac_income, ndrop)
% FINDFL Finds additional fraction of income in the upper class fL
%   fL = FINDFL(frac_returns, frac_income, ndrop) fits the income Lorenz
%   curve data to the rescaled exponential distribution for the lower class
%   y = (1-fL)[x + (1-x)*ln(1-x)], dropping the last ndrop points at the
%   high end of the distribution
ft = fittype({'x + (1-x) * log(1-x)'},...
    'coefficients', {'a'});
mdl = fit(frac_returns(1:end-ndrop),...
    frac_income(1:end-ndrop), ft);
fL = 1-mdl.a;

end