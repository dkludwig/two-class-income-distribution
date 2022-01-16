this_cdf = import_cdf('../data/irs2018.csv');
interp = pchip(this_cdf.r, log(this_cdf.frac_returns));
idx = 3;
section = @(x) interp.coefs(idx,1)*(x - interp.breaks(idx)).^3 ...
                + interp.coefs(idx,2)*(x - interp.breaks(idx)).^2 ...
                + interp.coefs(idx,3)*(x - interp.breaks(idx)) ...
                + interp.coefs(idx,4);
figure
axes('YScale', 'log',...
    'XLim', [1, 30e3])
hold on
x = 1:100:30e3;
plot(x, exp(ppval(interp, x)), 'k')
plot(x, exp(section(x)),'r')
plot(this_cdf.r, this_cdf.frac_returns, 'bo')
% plot(Tinterp, exp(-1), 'ro', 'MarkerFaceColor', 'r')
% xlim([1e3, Tinterp*3])

% years = 1988:10:2018;
% params = readtable('params.csv', 'ReadRowNames', true);
% for year = years
%     filename = sprintf('../data/irs%d.csv', year);
%     lorenz = import_lorenz(filename);
%     this_cdf = import_cdf(filename);
%     disp(year)
%     
% %     disp(length(lorenz.frac_returns(...
% %         [this_cdf.r; Inf] > params(string(year),:).T)))
% %     ndroppeds = 1:(length(lorenz.frac_returns)-3);
%     ndroppeds = 1:10;
%     max_fL = 0;
%     best_ndropped = 0;
%     for ndropped = ndroppeds
%         ft = fittype({'x + (1-x) * log(1-x)'},...
%             'coefficients', {'a'});
%         mdl = fit(lorenz.frac_returns(1:end-ndropped),...
%             lorenz.frac_income(1:end-ndropped), ft);
%         if (1 - mdl.a)*100 > max_fL
%             max_fL = (1 - mdl.a)*100;
%             best_ndropped = ndropped;
%         end
%         X = 0:0.001:1;
%         figure('Position', [0,61,550,550])
%         plot(X, feval(mdl,X), 'b')
%         title(year)
%         xlim([0 1])
%         ylim([0 1])
%         hold on
%         text(0.1, 0.7, sprintf('ndropped = %d', ndropped))
%         text(0.1, 0.5, sprintf('f_L = %0.2f', (1-mdl.a)*100))
%         plot(lorenz.frac_returns(1:end-ndropped),...
%             lorenz.frac_income(1:end-ndropped), 'ro',...
%             'MarkerFaceColor', 'r')
%         plot(lorenz.frac_returns(end-ndropped+1:end),...
%             lorenz.frac_income(end-ndropped+1:end), 'ro')
%     end
%     disp(sprintf('best_ndropped = %d', best_ndropped))
%     disp(sprintf('max fL = %d', max_fL))
% end
