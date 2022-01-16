params = readtable('../data/params.csv', 'ReadRowNames', true);
years = 1983:2018;
markersize = 3;
linewidth = 1.2;
fontsize = 11;
thisxlim = [1981 2019];
thisylim = [0 45];


fig = figure('Position', [500,100,600,550]);
leftaxes = axes(...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'YLim', thisylim,... 
    'XLim', thisxlim,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
hold on

% top 1%
plot(years, params.top1tax*100, 'k-o',...
    'MarkerFaceColor', 'k',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot(years,params.top1inc*100, 'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% bottom 50%
plot(years, params.bot50inc*100, 'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot(years, params.bot50tax*100, 'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
xlabel('Year')
ylabel('Percentage share')
text(1983.2,35.3, 'Tax share of the top 1%')
text(2001.9,24.9, 'Income share of the top 1%')
text(2000.8,9.9, 'Income share of the bottom 50%')
text(1984.2,2.4,'Tax share of the bottom 50%')

rightaxes = axes(...
    'Position', get(leftaxes, 'Position'),...
    'Color', 'none',...
    'XLim', thisxlim,...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'YLim', thisylim,...
    'YAxisLocation', 'right',...
    'XAxisLocation', 'top',...
    'XTickLabel', [],...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);

%% print to pdf
set(gcf, 'Units', 'Inches');
figpos = get(gcf, 'Position');
% PaperSize is automatically [8.5, 11]
set(gcf, 'PaperSize', figpos(3:4));
saveas(gcf, 'fig8.pdf');
