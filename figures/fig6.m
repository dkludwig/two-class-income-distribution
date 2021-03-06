lorenz1983 = importlorenz('../data/irs1983.csv');
lorenz2018 = importlorenz('../data/irs2018.csv');
params = readtable('../data/params.csv', 'ReadRowNames', true);
fp = params('2018',:).fp;
fr = params('2018',:).fr;
fL = params('2018',:).fL;

markersize = 5;
linewidth = 1.2;
fontsize = 12;
legendbox = 'off';
figure('Position',[350,50,640,580])

%% Lorenz curve
mainaxes = axes(...
    'Position', [0.08,0.11,0.775,0.815],...
    'XLim', [0 1],...
    'YLim', [0 1],...
    'XTick', 0:0.1:1,...
    'YTick', 0:0.1:1,...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize,...
    'Box', 'on');
% set minor ticks to 1%
mainaxes.XAxis.MinorTickValues = 0:0.01:1;
mainaxes.YAxis.MinorTickValues = 0:0.01:1;
% labels
xlabel('Cumulative fraction of returns')
ylabel('Cumulative fraction of income')
title('Lorenz curves for income distribution',...
    'FontWeight', 'default',...
    'FontSize', fontsize)
hold on

% equality 45 degree curve (with gaps for Gini plot and labels)
plot([0 0.35], [0 0.35], 'k',...
    'LineWidth', linewidth)
plot([0.7 0.8], [0.7 0.8], 'k',...
    'LineWidth', linewidth)
plot([0.9 1], [0.9 1], 'k',...
    'LineWidth', linewidth)


% pure exponential fit curve
% use smaller step sizes for X near the top of the distribution in order
% for it to extend all the way to the top corner
X = [0:0.01:0.95, 0.951:0.001:0.995, 0.9951:0.0001:0.9999];
plot(X, X + (1-X) .* log(1-X), 'k',...
    'LineWidth', linewidth)
% rescaled exponential fit curve for 2018
plot(X, (1-fL)*(X + (1-X) .* log(1-X)), 'k--',...
    'LineWidth', linewidth)

% data points
plot(lorenz1983.frac_returns, lorenz1983.frac_income, 'rs',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize*1.1)
plot(lorenz2018.frac_returns, lorenz2018.frac_income, 'bo',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize)

% plot fp and fr point
plot(1-fp, 1-fr, 'md',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize*1.2)

% fp and fr annotations
plot([1-fp 1-fp],[1-fr 1], 'm:',...
    'LineWidth', linewidth)
text(0.794,0.842,...
    '$$f_r$$',...
    'Color', 'm',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)
text(0.829,0.845,...
    ' = 34%',...
    'Color', 'm',...
    'FontWeight', 'default')

plot([1-fp 1],[1-fr 1-fr], 'm:',...
    'LineWidth', linewidth)
text(0.87,0.375,...
    '$$f_p$$',...
    'Color', 'm',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)
text(0.904,0.378,...
    ' = 4%',...
    'Color', 'm',...
    'FontWeight', 'default')

% fL annotations
% first the |<-->| thing
annotation('doublearrow', [0.88, 0.88], [0.745, 0.925],...
    'Color', 'k',...
    'LineWidth', linewidth)
annotation('line', [0.87, 0.89], [0.745, 0.745],...
    'Color', 'k',...
    'LineWidth', linewidth)
annotation('line', [0.87, 0.89], [0.925, 0.925],...
    'Color', 'k',...
    'LineWidth', linewidth)

% fL label
text(1.04,0.88,...
    '$$f_L$$',...
    'Color', 'k',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)
text(1.075,0.883,...
    ' = 22%',...
    'Color', 'k',...
    'FontWeight', 'default')

% Lorenz labels and arrows
annotation('arrow', [0.587,0.587], [0.43,0.365],...
    'Color', 'k',...
    'LineWidth', linewidth)
annotation('arrow', [0.835,0.835], [0.45,0.61],...
    'Color', 'm',...
    'LineWidth', linewidth)
text(0.475,0.27, '\color{red}1983')
text(0.77,0.27, '\color{blue}2018')
text(0.36,0.47, 'Exponential distribution')
text(0.36,0.42, '$$ y = x + (1-x)ln(1-x)$$',...
    'Interpreter', 'latex')

text(0.61,0.14, 'Rescaled exponential')
text(0.68,0.097, 'distribution')
text(0.50,0.05, '$$y = (1-f_L)[x + (1-x)ln(1-x)]$$',...
    'Interpreter', 'latex')
annotation('arrow', [0.62,0.62], [0.24,0.30],...
    'Color', 'k',...
    'LineWidth', linewidth)

%% inset Gini plot
insetaxes = axes(....
    'Position', [0.15 0.55 0.45 0.35], ...
    'XLim', [1981 2019],...
    'YLim', [0 1],...
    'XTick', 1985:5:2015,...
    'XTickLabel', [],...
    'XMinorTick', 'on',...
    'Box', 'on',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
% manually do xticklabels for gini inset so they go inside the plot
for year = 1985:5:2015
   text(year-1.5, 0.07, string(year),...
       'Rotation', 45,...
       'Color', [0.15 0.15 0.15])
end
hold on

% gini = 0.5
plot([1981 2020], [0.5 0.5], 'k', ...
    'LineWidth', linewidth)

% data points
plot(1983:2018, params.gini,'bo',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% (1+fL)/2 theory for 1988-2018
theogini = (1 + params(string(1988:2018),:).fL)/2;
plot(1988:2018, theogini, 'r+',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)


% inset legend
plot(1993, 0.85, 'r+',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
text(1994, 0.85,...
    '$$(1+f_L)/2$$',...
    'Interpreter', 'latex',...
    'FontSize', fontsize)

plot(1993, 0.75, 'bo',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
text(1994, 0.75,...
    'Gini coefficient',...
    'FontSize', fontsize)

    
%% saving figure so that it isn't just 8.5" x 11"
% get the Position in inches, not pixels
set(gcf, 'Units', 'Inches');
figpos = get(gcf, 'Position');
% PaperSize is automatically [8.5, 11]
set(gcf, 'PaperSize', figpos(3:4));
saveas(gcf, 'fig6.pdf');


