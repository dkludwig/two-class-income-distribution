%% data import
% get cdfs from 1983-2018
years = 1983:2018;
cdfs = containers.Map('KeyType','double','ValueType','any');
for year = years
    filename = sprintf('../data/irs%d.csv', year);
    cdfs(year) = importcdf(filename);
end
% get fit parameters for 1983-2018
params = readtable('../data/params.csv', 'ReadRowNames', true);

%% parameters to tweak
mainxlim = [0.01 1200];
mainylim = [0.003 4000];
insetXMax = 5.2;
cutoffYear = 1999; % last year in group 1
shiftfactor = 0.65;
legendFontSize = 9;
legendCol1X = 120;
legendCol2X = 450;
legendYMax = 2500; % with respect to leftAxes
linewidth = 1;
fontsize = 12;

%% axes settings
figure1 = figure('Position',[300 50 800 700]);
axesPos=[0.1 0.08 0.80 0.85];

% black axis spine on the left
leftAxes = axes(...
    'YMinorTick',   'on',...  
    'YTick',        10.^(-3:3),...
    'YTickLabel',   {'', '0.01%', '0.1%','1%','10%','100%','','',''},...   
    'YScale',       'log',...
    'XTick',        10.^(-2:2),...
    'XMinorTick',   'on',...
    'XTickLabel',   {'','0.1','1','10','100',''},...
    'Position',     axesPos,...
    'XScale',       'log',...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
xlim(leftAxes, mainxlim);  
ylim(leftAxes, mainylim);
xlabel('Rescaled adjusted gross income,');
% put r/T separately so it can be in LaTeX
text(31.2,1.2e-3,'$$\frac{r}{T}$$', 'Interpreter', 'latex')
ylabel('Cumulative percent of returns');
hold(leftAxes, 'on')

% all labels in loglog plot are with respect to leftAxis
text(.1,30, '1983-1999');
text(.1,300, '2000-2018','Color','r');
text(.02,2000, 'Data Source: IRS Publication 1304','Color','k');

% red axis spine on the right, 2018 k$ on the top
convfactor = params.T(end)/1000;
rightAxes = axes(...
    'Color',        'none',...
    'YMinorTick',   'on',... 
    'YTickLabel',   {'', '0.001%','0.01%','0.1%','1%','10%','100%',''},...
    'YScale',       'log',...
    'YTick',        10.^(-4:2),...
    'XTickLabel',   {'1', '10', '100', '1,000', '10,000'},...
    'YColor',       'r',...    
    'YAxisLocation','right',...
    'XMinorTick',   'on',...
    'XScale',       'log',...
    'XAxisLocation','top',...
    'Position',     axesPos,...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize); %same position

xlabel('Adjusted gross income in the USA in 2018 (k$)');
xlim(rightAxes, mainxlim*convfactor);
ylim(rightAxes, mainylim/10);
%redo this myself later
hold(rightAxes, 'on')


% loglin inset axes in the bottom left
insetAxes = axes(...
    'YScale',       'log',...
    'YMinorTick',   'on',...
    'XMinorTick',   'on',...
    'YTick',        10.^(-1:3),...
    'XTick',        0:6,...
    'YTickLabel',   {'','1%','10%','100%','{\color{red}100%}',''},...
    'XTickLabel',   {'0','1','2','3','4','5','6'},...
    'Color',        'none',...
    'FontSize',     10,...
    'Position',     [0.17 0.13 0.35 0.45],...
    'LabelFontSizeMultiplier', 1,...
    'FontSize', fontsize,...
    'DefaultTextFontSize', fontsize);
xlim(insetAxes,[0 insetXMax]);
ylim(insetAxes,[0.3 2000]);
hold(insetAxes, 'on')

text(1,2e0, sprintf('1983-%d', cutoffYear));
text(2.7,20e1, sprintf('%d-2018', cutoffYear+1),'Color','r');

%% exponential fit lines
% exponential fit lines in loglog
X = 0.02:0.01:5.5;
line(leftAxes, X, 100*exp(-X), 'Color', 'k', 'LineWidth', linewidth);
line(leftAxes, X, 1000*exp(-X), 'Color', 'k', 'LineWidth', linewidth);

% exponential fit lines in loglin inset
line(insetAxes, X, 100*exp(-X), 'Color', 'k', 'LineWidth', linewidth);
line(insetAxes, X, 1000*exp(-X), 'Color', 'k', 'LineWidth', linewidth);

%% plotting data points
% fix color choices later
colors = readmatrix('colors.csv');
markers = 'osx^d*p+h>';
for year = years
    i = year - years(1) + 1; % to index into params
    X = cdfs(year).r;
    % plot cdfs in two groups
    if year <= cutoffYear
        Y = cdfs(year).frac_returns * 100;
        color = colors(mod(year-years(1),length(colors))+1,:);
        marker = markers(mod(year-years(1),length(markers))+1);
    else
        Y = cdfs(year).frac_returns * 1000;
        color = colors(mod(year-cutoffYear-1,length(colors))+1,:);
        marker = markers(mod(year-cutoffYear-1,length(markers))+1);
    end
    
    % pareto fit lines for tail in loglog (none for inset)
    xfit = params.rstar(i):X(end);
    
    % plot scaled x-values r/T vs the fit values at the original r
    if year<=cutoffYear
        line(leftAxes,...
            xfit/params.T(i),...
            100*params.paretocoeff(i)*xfit.^(-params.alpha(i)),...
            'Color', color, 'LineWidth', linewidth)
    else
        line(leftAxes,...
            xfit/params.T(i),...
            1000*params.paretocoeff(i)*xfit.^(-params.alpha(i)),...
            'Color', color, 'LineWidth', linewidth)
    end
    
    % plot data points
    scatter(leftAxes, X/params.T(i), Y,...
        'Marker', marker,...
        'MarkerEdgeColor', color,...
        'DisplayName', num2str(year),...
        'LineWidth', linewidth)
    scatter(insetAxes, X/params.T(i), Y,...
        'Marker', marker,...
        'MarkerEdgeColor', color,...
        'LineWidth', linewidth)
end

%% legend
% matlab legend function leaves unnecessary space between markers and labels
% so the legend needs to be done manually

for year = years
   % need to shift year labels down by the same amount each round, which
   % means we need to multiply by a constant factor < 1 since the yscale is log
   % roughly: font of 10 goes with 0.6, 9 & 0.65
   
   if year<=cutoffYear % column 1 of legend
       % 1996 starts at y=2500, then shifts down each round by factor of 0.6
       color = colors(mod(year-years(1),length(colors))+1,:);
       marker = markers(mod(year-years(1),length(markers))+1);
       
       numShifts = cutoffYear-year;
       text(leftAxes,legendCol1X,legendYMax*shiftfactor^numShifts,...
           num2str(year),'Color',color, 'FontWeight','Bold')
       plot(leftAxes,0.85*legendCol1X, legendYMax*shiftfactor^numShifts,...
           'o','Color',color, 'Marker', marker, 'MarkerSize',6,...
           'LineWidth', linewidth)
   else % column 2 of legend
       color = colors(mod(year-cutoffYear-1,length(colors))+1,:);
       marker = markers(mod(year-cutoffYear-1,length(markers))+1);
        
       numShifts = 2018-year;
       text(leftAxes,legendCol2X,legendYMax*shiftfactor^numShifts,...
           num2str(year), 'Color',color, 'FontWeight', 'bold')
       plot(leftAxes,0.85*legendCol2X, legendYMax*shiftfactor^numShifts,...
           'o','Color',color, 'Marker', marker, 'MarkerSize',6,...
           'LineWidth', linewidth)
   end
end

%% saving figure so that it isn't just 8.5" x 11"
%get the Position in inches, not pixels
set(gcf, 'Units', 'Inches');
figpos = get(gcf, 'Position');
% PaperSize is automatically [8.5, 11]
set(gcf, 'PaperSize', figpos(3:4));
saveas(gcf, 'fig1.pdf');
