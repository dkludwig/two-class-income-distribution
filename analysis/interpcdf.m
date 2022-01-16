function output = interpcdf(T, alphai, r0, r)
%INTERPCDF Evaluate interpolated (complementary) CDF fit function
%   output = INTERPCDF(T, alphai, r0, r) numerically integrates the
%   interpolated PDF function given T, alphai, and r0 and evaluates at
%   ascending incomes r.

% define a function handle for the PDF
interppdf = @(T, alphai, r0, r)...
    exp((-r0/T) * atan(r/r0)).^1/3./(1 + (r/r0).^2).^(1/2 + alphai/2);

% First numerically integrate over 0 to Inf to get normalization factor C.
% 1e6*T was picked as a reasonable cutoff after some trial and error
C = integral(@(x)interppdf(T, alphai, r0, x), 0, 1e6*T);

% Numerically integrate the PDF at each of the increasing incomes r.
% Subtracting from 1 gives the complementary CDF
output = 1 - C^-1 * myintegral(@(x)interppdf(T, alphai, r0, x), 0, r);
end

function integrals = myintegral(fcn, xmin, xmaxes)
%MYINTEGRAL Vectorizes Matlab's built-in integral function
%   integrals = MYINTEGRAL(fcn, xmin, xmaxes) takes in a function handle
%   fcn, a minimum value xmin, and an array of maximum values xmaxes (in
%   ascending order) and outputs an array of corresponding numerical
%   integrations

integrals = zeros(length(xmaxes),1);

% iteratively build integrals from the smallest interval to the largest
integrals(1) = integral(fcn, xmin, xmaxes(1));
for i=2:length(xmaxes)
    integrals(i) = integrals(i-1) + integral(fcn, xmaxes(i-1), xmaxes(i));
end

end