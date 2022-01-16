function tableout=importcdf(filename)
%IMPORTCDF Get (complementary) cumulative distribution function data
%   tableout = IMPORTCDF(filename) outputs a table with column
%   'frac_returns' which gives the fraction of returns with income greater
%   than the corresponding element in column 'r'. These parameterizing
%   incomes r are given by the income bins used by the IRS to report the
%   distribution of income in a given year.

% The input data files have income bins in *descending* order, so first
% flip the table so that the income bins are in *ascending* order.
tablein = flipud(readtable(filename));

% The input data files include returns with zero and negative income. We
% follow the World Bank's PovCalNet (see technical document) in dropping
% these returns from our distributions. Therefore, the total number of
% returns is the second element of the input 'returns' array, which
% corresponds to an income of $1 in the 'r' array.
tableout = table(...
    tablein.r(2:end),...
    tablein.returns(2:end)/tablein.returns(2),... % normalize to total
    'VariableNames',{'r','frac_returns'});

end