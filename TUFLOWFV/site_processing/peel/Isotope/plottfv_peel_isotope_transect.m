function plottfv_peel_isotope_transect(varname,outdir,sdate,edate,varargin)

%varname = 'WQ_DIAG_ISO_del15NNOx';
% varname = 'SAL';
% 
% filename = 'Summer SAL 2016.png';
% 
% ncfile = 'D:\Simulations\Peel\Peel_WQ_model_v7_2016_2017_Nth_Corner_Construction\Output\sim_2016_2017_Open_diag.nc';
% 
% addmodel = 1;
% 
% outdir = 'Images/';
% 
%  ylimits = [0 75];

addmodel = 0;
filename = 'isotope.png';
ylimits = [0 75];

for i = 1:2:length(varargin)-1

    switch varargin{i}
        case 'savename'
            filename = varargin{i+1};
        case 'ylim'
            ylimits = varargin{i+1};
        case 'addmodel'
            addmodel = varargin{i+1};
        case 'ncfile'
            ncfile = varargin{i+1};
        otherwise
            disp('Invalid option');
            stop;
    end
end

boxlength = 8;




if ~exist(outdir,'dir')
    mkdir(outdir);
end


extract_isodata(varname);

load iso.mat;

harvey_catch  = get_scatter_for_polygon(iso,varname,'Harvey_Catchment',sdate,edate);
harvey_river  = get_scatter_for_polygon(iso,varname,'Harvey_River',sdate,edate);
Mixing_DC  = get_scatter_for_polygon(iso,varname,'Mixing_DC',sdate,edate);
Ocean  = get_scatter_for_polygon(iso,varname,'Ocean',sdate,edate);
Mixing_PE  = get_scatter_for_polygon(iso,varname,'Mixing_PE',sdate,edate);
Punrack  = get_scatter_for_polygon(iso,varname,'Punrack',sdate,edate);
Dog_Hill  = get_scatter_for_polygon(iso,varname,'Dog_Hill',sdate,edate);
Serpentine_Catchment  = get_scatter_for_polygon(iso,varname,'Serpentine_Catchment',sdate,edate);


[harvey_data,harvey_dist,harvey_agency] = get_line_data_for_polygon(iso,varname,'Harvey_Est','SHP/Harvey.xy.txt',sdate,edate);
[murray_data,murray_dist,murray_agency] = get_line_data_for_polygon(iso,varname,'Murray_River','SHP/Murray.xy.txt',sdate,edate);
[serpentine_data,serpentine_dist,serpentine_agency] = get_line_data_for_polygon(iso,varname,'Serpentine_River','SHP/Serp.xy.txt',sdate,edate);


if addmodel
    
    [Adata,mTime,tdat] = import_model_data(ncfile,varname,sdate,edate);clear functions
    
    Mixing_DC_mod = get_scatter_for_polygon_model(Adata,mTime,tdat,'Mixing_DC');
    Ocean_mod = get_scatter_for_polygon_model(Adata,mTime,tdat,'Ocean');
    Mixing_PE_mod = get_scatter_for_polygon_model(Adata,mTime,tdat,'Mixing_PE');
    Harvey_River_mod = get_scatter_for_polygon_model(Adata,mTime,tdat,'Harvey_River');
    Dog_Hill_mod = get_scatter_for_polygon_model(Adata,mTime,tdat,'Dog_Hill');
    
    [Harvey_mData,Harvey_mDist] = get_line_data_for_model(Adata,mTime,tdat,'Harvey_Est','SHP/Harvey.xy.txt',sdate,edate);
    [Murray_mData,Murray_mDist] = get_line_data_for_model(Adata,mTime,tdat,'Murray_River','SHP/Murray.xy.txt',sdate,edate);
    [Serp_mData,Serp_mDist] = get_line_data_for_model(Adata,mTime,tdat,'Serpentine_River','SHP/Serp.xy.txt',sdate,edate);
end







figure('position',[304.333333333333          917.666666666667          2182.66666666667                       420]);

set(0,'defaultaxesfontsize',6);


%_________________________________________
ax1 = axes('position',[0.1 0.1 0.05 0.8], 'Color', 'None');
p1(1:length(harvey_catch),1) = -2;

if length(harvey_catch) < boxlength
    plot(ones(length(harvey_catch),1)-2,harvey_catch,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
else
    boxplot(ax1,harvey_catch,p1,'positions', -2,'colors','k','outliersize',2,'symbol','+k','widths',1);hold on
end

if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);

ax1.XAxis.Visible = 'off';

text(0.5,-0.05,{'Harvey';'Catchment'},'units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Harvey Catchment');

%_________________________________________
ax2 = axes('position',[0.15 0.1 0.05 0.8], 'Color', 'None');

p1(1:length(harvey_river),1) = -2;

if length(harvey_river) < boxlength
    plot(ones(length(harvey_river),1)-3,harvey_river,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
else
    boxplot(ax2,harvey_river,p1,'positions', -2,'colors','k','outliersize',2,'symbol','+k','widths',1);hold on
end
if addmodel
    p2(1:length(Harvey_River_mod),1) = 2;
    boxplot(ax2,Harvey_River_mod,p2,'positions', 2,'colors','b','outliersize',2,'symbol','+b','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);
ax2.XAxis.Visible = 'off';
ax2.YAxis.Visible = 'off';

text(0.5,-0.05,{'Harvey';'River'},'units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Harvey River');
clear p1 p2

%_________________________________________
ax3 = axes('position',[0.2 0.1 0.2 0.8], 'Color', 'None','fontsize',6);

%plot(harvey_dist,harvey_data,'k');hold on
plot(harvey_dist,harvey_data,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on

if addmodel
    plot(Harvey_mDist,Harvey_mData,'b','linewidth',1.5);
end

set(gca,'xdir','reverse');

xlabel('Distance (km)');

if ~isempty(ylimits)
    ylim(ylimits);
end

legend({'Harvey Estuary';'Harvey Model'});

title([regexprep(varname,'_',' '),' ',datestr(sdate,'mmm-yyyy')],'fontsize',10);

%ax2.XAxis.Visible = 'off';
ax3.YAxis.Visible = 'off';
box off
%_________________________________________
ax4 = axes('position',[0.4 0.1 0.05 0.8], 'Color', 'None');

p1(1:length(Mixing_DC),1) = -2;


if length(Mixing_DC) < boxlength
    plot(ones(length(Mixing_DC),1)-3,Mixing_DC,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
else
    boxplot(ax4,Mixing_DC,p1,'positions', -2,'colors','k','outliersize',2,'symbol','+k','widths',1);hold on
end
if addmodel
p2(1:length(Mixing_DC_mod),1) = 2;
boxplot(ax4,Mixing_DC_mod,p2,'positions', 2,'colors','b','outliersize',2,'symbol','+b','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5])
ax4.XAxis.Visible = 'off';
ax4.YAxis.Visible = 'off';

text(0.5,-0.05,'Mixing DC','units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Mixing D.C.');
clear p1 p2

%_________________________________________
ax5 = axes('position',[0.45 0.1 0.05 0.8], 'Color', 'None');
p1(1:length(Ocean),1) = -2;


if length(Ocean) < boxlength
    plot(ones(length(Ocean),1)-3,Ocean,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
else
    boxplot(ax5,Ocean,p1,'positions', -2,'colors','k','outliersize',2,'symbol','+k','widths',1);hold on
end
if addmodel
p2(1:length(Ocean_mod),1) = 2;
boxplot(ax5,Ocean_mod,p2,'positions', 2,'colors','b','outliersize',2,'symbol','+b','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);
ax5.XAxis.Visible = 'off';
ax5.YAxis.Visible = 'off';

text(0.5,-0.05,'Mixing Ocean','units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Mixing Ocean');
clear p1 p2
%_________________________________________
ax6 = axes('position',[0.5 0.1 0.05 0.8], 'Color', 'None');

p1(1:length(Mixing_PE),1) = -2;


if length(Mixing_PE) < boxlength
    plot(ones(length(Mixing_PE),1)-3,Mixing_PE,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
else
    boxplot(ax6,Mixing_PE,p1,'positions', -2,'colors','k','outliersize',2,'symbol','+k','widths',1);hold on
end
if addmodel
p2(1:length(Mixing_PE_mod),1) = 2;
boxplot(ax6,Mixing_PE_mod,p2,'positions', 2,'colors','b','outliersize',2,'symbol','+b','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);
ax6.XAxis.Visible = 'off';
ax6.YAxis.Visible = 'off';

text(0.5,-0.05,'Mixing PE','units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Mixing P.E.');
clear p1 p2

%_________________________________________
ax7 = axes('position',[0.55 0.1 0.2 0.8], 'Color', 'None');

% plot(murray_dist,murray_data,'k');hold on
% plot(serpentine_dist,serpentine_data,'r');hold on

plot(murray_dist,murray_data,'ok','markerfacecolor',[0.7 0.7 0.7] ,'markersize',3);hold on
plot(serpentine_dist,serpentine_data,'ok','markerfacecolor','c' ,'markersize',3);hold on

if addmodel
    plot(Murray_mDist,Murray_mData,'b','linewidth',1.5);
    plot(Serp_mDist,Serp_mData,'--b','linewidth',1.5);
end

legend({'Murray River';'Serpentine River';'Murray Model';'Serpentine Model'});

if ~isempty(ylimits)
    ylim(ylimits);
end
xlabel('Distance (km)');

%ax2.XAxis.Visible = 'off';
ax7.YAxis.Visible = 'off';
box off
%_________________________________________
ax8 = axes('position',[0.75 0.1 0.05 0.8], 'Color', 'None');

p1(1:length(Dog_Hill),1) = -2;


if length(Dog_Hill) < boxlength
    plot(ones(length(Dog_Hill),1)-3,Dog_Hill,'ok','markerfacecolor','c' ,'markersize',3);hold on
else
    boxplot(ax8,Dog_Hill,p1,'positions', -2,'colors','c','outliersize',2,'symbol','+c','widths',1);hold on
end
if addmodel
p2(1:length(Dog_Hill_mod),1) = 2;
boxplot(ax8,Dog_Hill_mod,p2,'positions', 2,'colors','b','outliersize',2,'symbol','+b','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);

ax8.XAxis.Visible = 'off';
ax8.YAxis.Visible = 'off';

text(0.5,-0.05,'Dog Hill','units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Dog Hill');
clear p1 p2

%_________________________________________
ax9 = axes('position',[0.8 0.1 0.05 0.8], 'Color', 'None');
p1(1:length(Punrack),1) = -2;

if length(Punrack) < boxlength
    plot(ones(length(Punrack),1)-3,Punrack,'ok','markerfacecolor','c' ,'markersize',3);hold on
else
    boxplot(ax9,Punrack,p1,'positions', -2,'colors','c','outliersize',2,'symbol','+c','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);

ax9.XAxis.Visible = 'off';
ax9.YAxis.Visible = 'off';

text(0.5,-0.05,{'Punrack';'Drain'},'units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Punrack Drain');
%_________________________________________
ax10 = axes('position',[0.85 0.1 0.05 0.8], 'Color', 'None');
p1(1:length(Serpentine_Catchment),1) = -2;

if length(Serpentine_Catchment) < boxlength
    plot(ones(length(Serpentine_Catchment),1)-3,Serpentine_Catchment,'ok','markerfacecolor','c' ,'markersize',3);hold on
else
    boxplot(Serpentine_Catchment,p1,'positions', -2,'colors','c','outliersize',2,'symbol','+c','widths',1);
end
if ~isempty(ylimits)
    ylim(ylimits);
end
xlim([-5 5]);

ax10.XAxis.Visible = 'off';
ax10.YAxis.Visible = 'off';
text(0.5,-0.05,{'Serpentine';'Catchment'},'units','normalized','horizontalalignment','center','fontsize',6);
%xlabel('Serpentine Catchment');

%_______________________________________________

set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 30;
ySize = 10;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])

saveas(gcf,[outdir,filename]);

close all;
