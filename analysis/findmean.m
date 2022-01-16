function mean_r = findmean(filename)
% FINDMEAN Finds mean income
%   mean_r = FINDMEAN(filename) accepts the full IRS data file and
%   calculates the mean income.

% The input data files have income bins in *descending* order, so first
% flip the table so that the income bins are in *ascending* order.
tablein = flipud(readtable(filename));

% mean_r = income of returns with r > $1 / # of returns with r > $1
mean_r = tablein.income(2)/tablein.returns(2);
end