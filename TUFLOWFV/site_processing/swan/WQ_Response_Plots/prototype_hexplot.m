function prototype_hexplot

load Load.mat;
load swan.mat;
shp = shaperead('ERZnew.shp');

addpath(genpath('honeycomb'));


% The configuration stuff.

the_poly = 4;

fvar = 'WQ_PHS_FRP';
lvar = 'TP_kg';

fvar_conv = 14/1000;

years = 2007:01:2018;

mbins(1).val = [1 2 3];
mbins(2).val = [4 5 6];
mbins(3).val = [7 8 9];
mbins(4).val = [10 11 12];

deltaT_Text = '3 Months';

% for i = 1:12
%     mbins(i).val =  [ i i ];
% end


lsites = fieldnames(Load);
fsites = fieldnames(swan);

allsites = {...
    'Bennett_Inflow',...
    'Ellenbrook_Inflow',...
    'Helena_Inflow',...
    'Jane_Inflow',...
    'Susannah_Inflow',...
    'Upper_Swan_Inflow',...
    };


% Plot 1 configs................................................

xtext_1 = 'TP (kg)';
ytext_1 = 'FRP (mg/L)';
xlim_1 = [0 100];
ylim_1 = [0 0.3];
honeybins_1 = [100 400];
title_1 = 'Zone 3 (Local)';

% Plot 2 configs.................................................

ytext_2 = 'FRP (mg/L)';
xtext_2 = '$$\overline{TP}^*_{inf}$$'
honeybins_2 = [25 100];
xlim_2 = [0 5];
ylim_2 = [0 0.3];
title_2 = 'Zone 3 (Local)';

% Plot 3 configs..................................................

ytext_3 = 'FRP (mg/L)';
xtext_3 = '$$\overline{TP}^*_{inf}$$'
xlim_3 = [0 50];
ylim_3 = [0 0.3];
honeybins_3 = [30 30];
title_3 = 'Zone 3 (Local + Upstream)';

% The runtime stuff

int = 1;
the_lsites = [];
for i = 1:length(lsites)
    if inpolygon(Load.(lsites{i}).X,Load.(lsites{i}).Y,shp(the_poly).X,shp(the_poly).Y)
        the_lsites{int,1} = lsites{i};
        int = int + 1;
    end
end

%the_lsites{int} = 'Upper_Swan_Inflow';

int = 1;
the_fsites = [];
for i = 1:length(fsites)
    
    if isfield(swan.(fsites{i}),fvar)
        if inpolygon(swan.(fsites{i}).(fvar).X,swan.(fsites{i}).(fvar).Y,shp(the_poly).X,shp(the_poly).Y)
            the_fsites{int,1} = fsites{i};
            int = int + 1;
        end
    end
end

the_field = [];
the_field_counter = [];
int = 1;
%Field Loop

for i = 1:length(years)
    for j = 1:length(mbins)
        
        % Get the field data for ALL the sites inside the polygon for the
        % specific 3 month period
        [the_field_Mon,field_count] = get_field_data(swan,the_fsites,fvar,years(i),mbins(j).val);
        
        % Counts up the number of field samples found in all sites for the
        % year/month bin.
        the_field_counter(int,1) = field_count;
        
        the_field = [the_field;the_field_Mon];
        
        int = int + 1;
    end
end

the_field = the_field * fvar_conv;

% Inflow Loop This is disconnected as we might look at different period of
% inflow vs field data

the_load_local = [];
the_load_local_Q = [];
the_load_region_Q = [];
int = 1;

for i = 1:length(years)
    for j = 1:length(mbins)
        % Get the inflow data for ALL the sites inside the polygon for the
        % specific 3 month period & all data from region as specified by
        % allsites
        [local_total,local_Q,group_Q] = get_inflow_data(Load,the_lsites,allsites,lvar,years(i),mbins(j).val);
        
        
        % Match the number of field samples in this date range
        td = [];
        tdn = [];
        tda = [];
        
        td(1:the_field_counter(int),1) = local_total;
        tdn(1:the_field_counter(int),1) = local_Q;
        tda(1:the_field_counter(int),1) = group_Q;
        
        
        
        
        the_load_local = [the_load_local;td];
        the_load_local_Q = [the_load_local_Q;tdn];
        the_load_region_Q = [the_load_region_Q;tda];
        
        
        
        int = int + 1;
    end
end









% Plotting.......................................................

fig = figure;
set(fig,'defaultTextInterpreter','latex')
set(0,'DefaultAxesFontName','Times')

subplot(1,3,1)
set(gca,'TickLabelInterpreter','latex')

honeycomb(the_load_local,the_field,honeybins_1);
set(gca,'ylim',ylim_1);
set(gca,'xlim',xlim_1);

ylabel(ytext_1,'fontsize',8);
xlabel(xtext_1,'fontsize',8);
title(title_1,'fontsize',8);

% text(0.5,0.9,['  \DeltaT = ',deltaT_Text],'units','normalized','FontSize',6);
% text(0.5,0.85,['#\DeltaT = ',num2str(length(years)*length(mbins))],'units','normalized','FontSize',6);
% text(0.5,0.8,['n = ',num2str(length(the_field)),' Samples'],'units','normalized','FontSize',6);


subplot(1,3,2)
set(gca,'TickLabelInterpreter','latex')

honeycomb(the_load_local_Q,the_field,honeybins_2);
set(gca,'ylim',ylim_2);
set(gca,'xlim',xlim_2);

ylabel(ytext_2,'fontsize',8);
h = xlabel(xtext_2,'fontsize',8);
title(title_2,'fontsize',8);

% text(0.5,0.9,['  \DeltaT = ',deltaT_Text],'units','normalized','FontSize',6);
% text(0.5,0.85,['#\DeltaT = ',num2str(length(years)*length(mbins))],'units','normalized','FontSize',6);
% text(0.5,0.8,['n = ',num2str(length(the_field)),' Samples'],'units','normalized','FontSize',6);


subplot(1,3,3)
set(gca,'TickLabelInterpreter','latex')

honeycomb(the_load_region_Q,the_field,honeybins_3);
set(gca,'ylim',ylim_3);
set(gca,'xlim',xlim_3);

ylabel(ytext_3,'fontsize',8);
h = xlabel(xtext_2,'fontsize',8);
title(title_3,'fontsize',8);

text(0.5,0.9,['  $$\Delta$$T = ',deltaT_Text],'units','normalized','FontSize',6);
text(0.5,0.85,['\#','$$\Delta$$T = ',num2str(length(years)*length(mbins))],'units','normalized','FontSize',6);
text(0.5,0.8,['n = ',num2str(length(the_field)),' Samples'],'units','normalized','FontSize',6);

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 21;
ySize = 6;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,'Honeycomb Zone 3.png');

close all;


end

% Internal Functions

function [the_field,field_count] = get_field_data(swan,the_fsites,var,theyear,themonths)



the_field = [];
field_count = 0;

for k = 1:length(the_fsites)
    
    
    sss = find(swan.(the_fsites{k}).(var).Date >= datenum(theyear,themonths(1),1) & ...
        swan.(the_fsites{k}).(var).Date < datenum(theyear,themonths(end)+1,1));
    
    xdata = [];
    
    if ~isempty(sss)
        
        thedata = swan.(the_fsites{k}).(var).Data(sss);
        
        gg = find(~isnan(thedata) == 1);
        
        xdata = thedata(gg);
        
    end
    
    if ~isempty(xdata)
        the_field = [the_field;xdata];
        
        field_count = field_count + length(xdata);
        
    end
end

end

function [local_total,local_Q,group_Q] = get_inflow_data(Load,the_lsites,alsites,lvar,theyear,themonths)



local_total = 0;
local_Q = 0;

for k = 1:length(the_lsites)
    ttt = find(Load.(the_lsites{k}).Date >= datenum(theyear,themonths(1),1) & ...
        Load.(the_lsites{k}).Date < datenum(theyear,themonths(1)+1,1));
    
    
    local_total = local_total + sum(Load.(the_lsites{k}).(lvar)(ttt));
    
    local_Q = local_Q + (sum(Load.(the_lsites{k}).(lvar)(ttt) ./ Load.(the_lsites{k}).ML(ttt)));
    
end

group_Q = 0;
for k = 1:length(alsites)
    ttt = find(Load.(alsites{k}).Date >= datenum(theyear,themonths(1),1) & ...
        Load.(alsites{k}).Date < datenum(theyear,themonths(1)+1,1));
    
    
    group_Q = group_Q + (sum(Load.(alsites{k}).(lvar)(ttt) ./ Load.(alsites{k}).ML(ttt)));
    
end
end



