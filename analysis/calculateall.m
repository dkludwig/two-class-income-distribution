years = (1983:2018)';
% number of points in upper class to fit to Pareto power law
nfits = [repmat(3, [10,1]);
           repmat(2, [7,1]);
           repmat(6, [19,1])];
% number of points in upper class to drop in fitting fL
ndrops = [repmat(3, [7,1]);
         repmat(4, [5,1]);
         8; 8; 7;
         repmat(8, [16,1])];

% --------------------------
% allocate arrays
params = array2table(zeros(length(years), 20),...
    'VariableNames', {'median_r', 'mean_r', 'T', 'expcoeff', 'alpha',...
    'paretocoeff', 'rstar', 'r0', 'alphai', 'fp', 'fr', 'fr_expected',...
    'ft', 'gini', 'taxgini', 'fL', 'bot50inc', 'bot50tax', 'top1inc',...
    'top1tax'},...
    'RowNames', string(years));

% calculate parameters
for i=1:length(years)
    disp(years(i))
    % import and format data
    filename = sprintf('../data/irs%d.csv', years(i));
    thiscdf = importcdf(filename);
    lorenz = importlorenz(filename);
    taxlorenz = importtaxlorenz(filename);
    
    % get median income and average income
    params.median_r(i) = findmedian(thiscdf.r, thiscdf.frac_returns);
    params.mean_r(i) = findmean(filename);
    
    % fit exponential and Pareto sections
    [params.T(i), params.expcoeff(i)] = ... 
        findT(thiscdf.r, thiscdf.frac_returns);
    [params.alpha(i), params.paretocoeff(i)] = ...
        findalpha(thiscdf.r, thiscdf.frac_returns, nfits(i));
    
    % using T, find r0 and alphai using interpolated fit
    [params.r0(i), params.alphai(i)] = ...
        findr0_alphai(thiscdf.r, thiscdf.frac_returns, params.T(i));
    
    % find intersection of fits at (rstar, fp)
    [params.rstar(i), params.fp(i)] = findrstar_fp(params.T(i),...
        params.expcoeff(i), params.alpha(i), params.paretocoeff(i));
    
    % use to find fr and gini
    params.fr(i) = 1 - findshare(lorenz.frac_returns,...
        lorenz.frac_income, 1-params.fp(i));
    params.gini(i) = findgini(lorenz.frac_returns, lorenz.frac_income);
    
    % find expected fr based on other fit parameters:
    % fr' = fp * alpha/(alpha - 1) * (r*/<r>)
    params.fr_expected(i) = params.fp(i) * params.alpha(i)... 
        /(params.alpha(i) - 1) * params.rstar(i) / params.mean_r(i);
    
    % find tax versions of f and gini
    params.ft(i) = 1 - findshare(taxlorenz.frac_returns,...
        taxlorenz.frac_tax, 1-params.fp(i));
    params.taxgini(i) = findgini(taxlorenz.frac_returns,...
        taxlorenz.frac_tax);
    
    % find fraction of total income earned above exponential starting in
    % 1988
    if years(i) >= 1988
        j = years(i) - 1987;
        params.fL(i) = findfL(lorenz.frac_returns,...
            lorenz.frac_income, ndrops(j));
    end
    
    % get the shares of income earned by and tax revenue from the bottom
    % 50% and top 1% of returns
    params.bot50inc(i) = findshare(lorenz.frac_returns,...
           lorenz.frac_income, 0.5);
    params.bot50tax(i) = findshare(taxlorenz.frac_returns,...
           taxlorenz.frac_tax, 0.5);
       
    params.top1inc(i) = 1 - findshare(lorenz.frac_returns,...
           lorenz.frac_income, 0.99);
    params.top1tax(i) = 1 - findshare(taxlorenz.frac_returns,...
           taxlorenz.frac_tax, 0.99);
end
