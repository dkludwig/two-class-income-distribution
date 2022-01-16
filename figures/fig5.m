%% settings
allparams = readtable('../data/params.csv', 'ReadRowNames', true);
years1 = 1983:1992;
params1 =  allparams(string(years1),:);
years2 = 1993:1999;
params2 =  allparams(string(years2),:);
years3 = 2000:2018;
params3 = allparams(string(years3),:);

topaxespos = [0.12 0.54 0.76 0.44];
botaxespos = [0.12 0.06 0.76 0.44];
markersize = 2.5;
linewidth = 1.2;
fontsize = 12;
topleftylim = [0 60];
toprightylim = [0.5 10];
botleftylim = [0 33];
botrightylim = [1 6];
allxlim = [1981 2019];
legendbox = 'off';
figure('Position',[350,0,530,760])

set(0, 'DefaultTextInterpreter', 'default')
set(0, 'DefaultLegendInterpreter', 'default')
set(0, 'DefaultAxesTickLabelInterpreter', 'default')
%% TOP: fractions by themselves
% make axes for ft and fr on the left
topleftaxes = axes(...
    'Position', topaxespos,...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'YLim', topleftylim,...
    'YTick', 0:10:topleftylim(2),...
    'YTickLabel', ["0%" "10%" "20%" "30%" "40%" "50%" "60%"],...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
ylabel(['Percent of \color{magenta}tax \color[rgb]{0.15 0.15 0.15}and',...
    ' \color{blue}income \color[rgb]{0.15 0.15 0.15}in tail'])
hold on

% need to do 5 plot calls for each time series, 3 for the solid sections
% and 2 for the dashed switch region
% ft on top in magenta
plot(years1, params1.ft*100,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993], allparams(["1992" "1993"],:).ft*100,...
    'm:',...
    'LineWidth', linewidth)
plot(years2, params2.ft*100,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000], allparams(["1999" "2000"],:).ft*100,...
    'm:',...
    'LineWidth', linewidth)
plot(years3, params3.ft*100,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% fr' in the middle in black
plot(years1, params1.fr_expected*100,...
    'k-o',...
    'MarkerFaceColor', 'k',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993], allparams(["1992" "1993"],:).fr_expected*100,...
    'k:',...
    'LineWidth', linewidth)
plot(years2, params2.fr_expected*100,...
    'k-o',...
    'MarkerFaceColor', 'k',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000], allparams(["1999" "2000"],:).fr_expected*100,...
    'k:',...
    'LineWidth', linewidth)
plot(years3, params3.fr_expected*100,...
    'k-o',...
    'MarkerFaceColor', 'k',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% fr in the middle in blue
plot(years1, params1.fr*100,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993], allparams(["1992" "1993"],:).fr*100,...
    'b:',...
    'LineWidth', linewidth)
plot(years2, params2.fr*100,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000], allparams(["1999" "2000"],:).fr*100,...
    'b:',...
    'LineWidth', linewidth)
plot(years3, params3.fr*100,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% top right axes for fp curve
toprightaxes = axes('Position', get(topleftaxes, 'Position'),...
    'Color', 'none',...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YLim', toprightylim,...
    'XTickLabel', [],...
    'YTick', 1:toprightylim(2),...
    'YTickLabel', ["1%" "2%" "3%" "4%" "5%" "6%" "7%" "8%" "9%" "10%"],...
    'YAxisLocation', 'right',...
    'XAxisLocation', 'top',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
% do right ylabel manually
text(2023,2.5,['Percent of \color{red}population ',...
    '\color[rgb]{0.15 0.15 0.15}in tail'],...
    'Rotation', 90)
hold on

plot(years1, params1.fp*100,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993],...
    allparams(["1992" "1993"],:).fp*100,...
    'r:',...
    'LineWidth', linewidth)
plot(years2, params2.fp*100,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000],...
    allparams(["1999" "2000"],:).fp*100,...
    'r:',...
    'LineWidth', linewidth)
plot(years3, params3.fp*100,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)


%% BOTTOM: ratios of fractions
botleftaxes = axes(...
    'Position', botaxespos,...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'YLim', botleftylim,...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
xlabel('Year')
% leave spaces in ylabel and fill with latex formatting
ylabel('Ratios of tax           and income           to population')
text(botleftaxes, 1977.5, 6.5, '$$f_t/f_p$$',...
    'Color', 'm',...
    'Interpreter', 'latex',...
    'FontSize', 1.1*fontsize,...
    'Rotation', 90)
text(botleftaxes, 1977.5, 22, '$$f_r/f_p$$',...
    'Color', 'b',...
    'Interpreter', 'latex',...
    'FontSize', 1.1*fontsize,...
    'Rotation', 90)
hold on

% ft/fp on top, magenta
plot(years1, params1.ft ./ params1.fp,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993],...
    allparams(["1992" "1993"],:).ft ./ allparams(["1992" "1993"],:).fp,...
    'm:',...
    'LineWidth', linewidth)
plot(years2, params2.ft ./ params2.fp,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000],...
    allparams(["1999" "2000"],:).ft ./ allparams(["1999" "2000"],:).fp,...
    'm:',...
    'LineWidth', linewidth)
plot(years3, params3.ft ./ params3.fp,...
    'm-o',...
    'MarkerFaceColor', 'm',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% fr/fp in the middle in blue
plot(years1, params1.fr ./ params1.fp,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993],...
    allparams(["1992" "1993"],:).fr ./ allparams(["1992" "1993"],:).fp,...
    'b:',...
    'LineWidth', linewidth)
plot(years2, params2.fr ./ params2.fp,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000],...
    allparams(["1999" "2000"],:).fr ./ allparams(["1999" "2000"],:).fp,...
    'b:',...
    'LineWidth', linewidth)
plot(years3, params3.fr ./ params3.fp,...
    'b-o',...
    'MarkerFaceColor', 'b',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

% second axes for ft / fr
botrightaxes = axes(...
    'Position', get(botleftaxes,'Position'),...
    'Color', 'none',...
    'XLim', allxlim,...
    'XMinorTick', 'on',...
    'YMinorTick', 'on',...
    'YLim', botrightylim,...
    'YAxisLocation', 'right',...
    'XAxisLocation', 'top',...
    'XTickLabel', [],...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
% leave room at the end for latex formatting
ylabel('Ratio of tax to income fractions     ')
text(botleftaxes, 2022, 28, '$$f_t/f_r$$',...
    'Color', 'r',...
    'Interpreter', 'latex',...
    'FontSize', 1.1*fontsize,...
    'Rotation', 90)

hold on
% ft / fr on the bottom in red, dilated
plot(years1, params1.ft ./ params1.fr,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1992 1993],...
    allparams(["1992" "1993"],:).ft ./ allparams(["1992" "1993"],:).fr,...
    'r:',...
    'LineWidth', linewidth)
plot(years2, params2.ft ./ params2.fr,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)
plot([1999 2000],...
    allparams(["1999" "2000"],:).ft ./ allparams(["1999" "2000"],:).fr,...
    'r:',...
    'LineWidth', linewidth)
plot(years3, params3.ft ./ params3.fr,...
    'r-o',...
    'MarkerFaceColor', 'r',...
    'MarkerSize', markersize,...
    'LineWidth', linewidth)

%% labels and arrows
% top plot
text(topleftaxes, 1989.5, 52, 'Tail fraction of tax')
text(topleftaxes, 2001.8, 51.5, '$$f_t$$',...
    'Color', 'm',...
    'FontSize', 1.2*fontsize,...
    'Interpreter', 'latex')
text(topleftaxes, 1997, 36.5, 'Tail fractions of income     ,')
text(topleftaxes, 2012.8, 36, '$$f_r$$',...
    'Color', 'b',...
    'FontSize', 1.2*fontsize,...
    'Interpreter', 'latex')
text(topleftaxes, 2015.4, 36, "$$f_r'$$",...
    'Color', 'k',...
    'FontSize', 1.2*fontsize,...
    'Interpreter', 'latex')
text(topleftaxes, 1997, 7, 'Tail fraction of population')
text(topleftaxes, 2014.2, 6.5, '$$f_p$$',...
    'Color', 'r',...
    'FontSize', 1.2*fontsize,...
    'Interpreter', 'latex')

% bottom plot
text(botleftaxes, 1988, 22, '$$f_t/f_p$$',...
    'Color', 'm',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)
text(botleftaxes, 1990, 12, '$$f_r/f_p$$',...
    'Color', 'b',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)
text(botleftaxes, 1993, 3.5, '$$f_t/f_r$$',...
    'Color', 'r',...
    'Interpreter', 'latex',...
    'FontSize', 1.2*fontsize)

% top arrows
annotation('arrow', [0.32 0.22], [0.81 0.81],...
    'Color', 'm',...
    'LineWidth', linewidth)
annotation('arrow', [0.40 0.30], [0.71 0.71],...
    'Color', 'b',...
    'LineWidth', linewidth)
annotation('arrow', [0.75 0.85], [0.64 0.64],...
    'Color', 'r',...
    'LineWidth', linewidth)

% bottom arrows
annotation('arrow', [0.21 0.14], [0.37 0.37],...
    'Color', 'm',...
    'LineWidth', linewidth)
annotation('arrow', [0.24 0.14], [0.255 0.255],...
    'Color', 'b',...
    'LineWidth', linewidth)
annotation('arrow', [0.74 0.84], [0.1 0.1],...
    'Color', 'r',...
    'LineWidth', linewidth)

%% saving figure so that it isn't just 8.5" x 11"
% get the Position in inches, not pixels
set(gcf, 'Units', 'Inches');
figpos = get(gcf, 'Position');
% PaperSize is automatically [8.5, 11]
set(gcf, 'PaperSize', figpos(3:4));
saveas(gcf, 'fig5.pdf');



