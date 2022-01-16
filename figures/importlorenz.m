 function tableout = importlorenz(filename)
%IMPORTLORENZ Get (income) Lorenz curve data
%   tableout = IMPORTLORENZ(filename) outputs a table with column
%   'frac_returns' which gives the fraction of returns with income < r and
%   with column 'frac_income' which gives the fraction of total income
%   earned by returns with income < r. The parameterizing cutoff incomes r
%   are given by the income bins used by the IRS to report the distribution
%   of income in a given year (but are not included in this table).


% The input data files have income bins in *descending* order, so first flip
% the table so that the income bins are in *ascending* order.
tablein = flipud(readtable(filename));

% The input data files include returns with zero and negative income. We
% follow the World Bank's PovCalNet and SEDLAC (see technical document) in
% dropping these returns from our distributions. The first elements of each
% array are 0, as 0% of returns earn 0% of the total income. Elements in
% general give the fraction of returns and total income of those with
% income $1 < r < bin, where the income bins range from $1 to $Inf, making
% the last element of each array 1. The input data files cumulate returns
% and income *above* r, so we need to switch the cumulation as well.
tableout = table();
tableout.frac_returns = ...
    [0;
    % The second element is the total number of returns (as we are dropping
    % returns with zero and negative incomes).
    tablein.returns(2) - tablein.returns(3:end); % switch cumulation
    tablein.returns(2)] / tablein.returns(2); % normalize to total
tableout.frac_income = ...
    [0;
    % The second element is the total income (as we are dropping
    % returns with zero and negative incomes).
    tablein.income(2) - tablein.income(3:end); % switch cumulation
    tablein.income(2)] / tablein.income(2); % normalize to total

 end