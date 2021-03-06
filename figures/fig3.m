%% settings
years = 1983:2018;
params = readtable('../data/params.csv', 'ReadRowNames', true);
allcpi = readtable('../data/cpi.csv');
cpi = allcpi.cpi(allcpi.year >= 1983 & allcpi.year <= 2018);
colors = readmatrix('colors.csv');

legendbox = 'off';
markersize = 2.5;
linewidth = 1.2;
fontsize = 12;
inflyear = 1983;
nominalylim = [0 80];
real2018ylim = [33 79];
allxlim = [1982 2019];
 
figure('Position',[400,40,500,700])

%% TOP: NOMINAL $ 
topleftaxes = axes(...
    'Position', [0.098,0.53,0.805,0.45],...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YLim', nominalylim,...
    'XTickLabel', [],...
    'XAxisLocation', 'bottom',...
    'Box', 'on',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
ylabel('Adjusted gross income in nominal k$')

% manually set the 1985-2015 xtick labels
for year = 1985:5:2015
   text(year-1.4, 5, num2str(year), 'Color', [0.15 0.15 0.15]) 
end
hold on

purple = 'm';
inflationfactors = cpi/cpi(inflyear-1982);
% actual time series' (divided by 1000 so the units are k$)
plot(years, params.mean_r/1000, '-o',...
    'Color', purple,...
    'MarkerFaceColor', purple,...
    'LineWidth', linewidth,...
    'MarkerSize', markersize)
plot(years, params.T/1000, '-o',...
    'Color', 'b',...
    'LineWidth', linewidth,...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize)
plot(years, params.median_r/1000, '-o',...
    'Color', 'r',...
    'LineWidth', linewidth,...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize)

% inflation-adjusted 1983 values
plot(years, params.T(inflyear-1982)/1000*inflationfactors,...
    '-',...
    'Color', 'b',...
    'LineWidth', linewidth)
plot(years, params.median_r(inflyear-1982)/1000*inflationfactors,...
    '-',...
    'Color', 'r',...
    'LineWidth', linewidth)

% default legend + variables done separately because death is imminent
legend({'Mean income',...
    'Income temperature',...
    'Median income',...
    ' ', ' '},...
    'Location','northwest',...
    'Box', 'off');
text(1995.4, 74.1, '$$\langle r \rangle$$',...
    'Color', 'm',...
    'Interpreter', 'latex')
text(1999.5, 69.2, '$$T$$',...
    'Color', 'b',...
    'Interpreter', 'latex')
text(1996.7, 64.8, '$$r_{med}$$',...
    'Color', 'r',...
    'Interpreter', 'latex')
text(1987.3, 59.2, '$$T(1983) \times$$',...
    'Color', 'k',...
    'Interpreter', 'latex')
text(1987.5, 54.7, '$$r_{med}(1983) \times$$',...
    'Color', 'k',...
    'Interpreter', 'latex')
text(1994, 59.7, 'inflation', 'FontSize', fontsize*0.9)
text(1995.4, 55.2, 'inflation', 'FontSize', fontsize*0.9)

toprightaxes = axes(...
    'Position', get(topleftaxes, 'Position'),...
    'Color', 'none',...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YLim', nominalylim,...
    'XTickLabel', [],...
    'XAxisLocation', 'top',...
    'YAxisLocation', 'right',...
    'Box', 'on',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);

%% BOTTOM: REAL $
% need to make two different axes to get two different spines
% 2018 axes are on bottom and plotted on
botleftaxes = axes(...
    'Position', [0.098,0.07,0.805,0.45],...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YLim', real2018ylim,...
    'YAxisLocation', 'right',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
xlabel('Year')
ylabel('Adjusted gross income in 2018 k$')
hold on

% plot time series, no inflation comparison here
inflationfactors = cpi/cpi(end); % real 2018 dollars
plot(years, params.mean_r/1000./inflationfactors,...
    '-o',...
    'Color', purple,...
    'MarkerFaceColor', purple,...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot(years, params.T/1000./inflationfactors,...
    '-o',...
    'Color', 'b',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot(years, params.median_r/1000./inflationfactors,...
    '-o',...
    'Color', 'r',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
% legend labels are manual
legend({' ',...
    ' ',...
    ' '},...
    'Location','northwest',...
    'Box', legendbox);
text(1987.3, 76, '$$\langle r \rangle /$$',...
    'Color', 'k',...
    'Interpreter', 'latex')
text(1987.3, 73, '$$T /$$',...
    'Color', 'k',...
    'Interpreter', 'latex')
text(1987.5, 70, '$$r_{med} /$$',...
    'Color', 'k',...
    'Interpreter', 'latex')
text(1990, 76, 'inflation', 'FontSize', fontsize*0.9)
text(1989.3, 73, 'inflation', 'FontSize', fontsize*0.9)
text(1991, 70, 'inflation', 'FontSize', fontsize*0.9)


% this is just to show 1980 $ as well
botrightaxes = axes(...
    'Position', get(botleftaxes, 'Position'),...
    'Color', 'none',...
    'TickDir', 'in',...
    'XMinorTick', 'on',...
    'XAxisLocation', 'top',...
    'XTickLabels', [],...
    'YAxisLocation', 'left',...
    'YLim', real2018ylim/cpi(end)*cpi(1),...
    'XLim', get(gca,'XLim'),...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
ylabel('Adjusted gross income in 1983 k$')

%% saving figure so that it isn't just 8.5" x 11"
% get the Position in inches, not pixels
set(gcf, 'Units', 'Inches');
figpos = get(gcf, 'Position');
% PaperSize is automatically [8.5, 11]
set(gcf, 'PaperSize', figpos(3:4));
saveas(gcf, 'fig3.pdf');

