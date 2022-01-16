function [r0, alphai] = findr0_alphai(r, frac_returns, T)
%FINDR0_ALPHAI Find the crossover income r0 and Pareto exponent alphai
%   [r0, alphai] = FINDR0_ALPHAI(r, frac_returns, T) fits the given CDF
%   data, with incomes r and corresponding fractions of returns
%   frac_returns, to the interpolated CDF fit function with fixed input T


% set ballpark initial guesses for alpha and r0
initalpha = 1.5;
initr0 = 2*T;
initparams = [initalpha, initr0];

% perform least-squares fit of CDF data in log-linear scale
% set fit settings
fo = fitoptions('Method','NonlinearLeastSquares','StartPoint', initparams);
funcstr = sprintf('log(interpcdf(%d, alphai, r0, x))', T);
ft = fittype(funcstr, 'options', fo);

% fit and extract alphai and r0
mdl = fit(r, log(frac_returns), ft);
alphai = mdl.alphai;
r0 = mdl.r0;

end