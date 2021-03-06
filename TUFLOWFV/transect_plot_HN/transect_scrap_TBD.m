clear all; close all;

addpath(genpath('tuflowfv'));

ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';

fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';

polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';

varname = 'WQ_DIAG_TOT_TN';
ylab = 'TN (mg/L)';
conv = 14/1000;

xl = [0 250];
yl = [0 3];
offset = 0.1;

outname = 'HN_V4_A5_Transect_TN.png';

daterange = datenum(2017,09:10,01);

surface_edge_color = [ 30  50  53]./255;
surface_face_color = [ 68 108 134]./255;
surface_line_color = [  0  96 100]./255;  %[69  90 100]./255;
col_pal            =[[176 190 197]./255;[255 159 0]./255;[255 129 0]./255];
median_line = [0 96 100]./255;


dimc = [0.9 0.9 0.9]; % dimmest (lightest) color

field = load(fielddata_matfile);
fdata = field.(fielddata);

pline = shaperead(polygon_line);
fzone = shaperead(polygon_file);

mdata = tfv_readnetcdf(ncfile,'names',{varname});
mdata.(varname) = mdata.(varname) * conv;
adata = tfv_readnetcdf(ncfile,'timestep',1);
mtime = tfv_readnetcdf(ncfile,'time',1);

thetime = find(mtime.Time >= daterange(1) & ...
    mtime.Time < daterange(end));

%__________________________________________________________________________

% Model Processing

for i = 1:length(pline)
    data(i,1) = pline(i).X;
    data(i,2) = pline(i).Y;
end

dist(1,1) = 0;

for i = 2:length(pline)
    
    dist(i,1) = sqrt(power((data(i,1) - data(i-1,1)),2) + power((data(i,2)- data(i-1,2)),2)) + dist(i-1,1);
    
end

dist = dist / 1000; % convert to km

geo_x = double(adata.cell_X);
geo_y = double(adata.cell_Y);

dtri = DelaunayTri(geo_x,geo_y);

query_points(:,1) = data(~isnan(data(:,1)),1);
query_points(:,2) = data(~isnan(data(:,2)),2);

pt_id = nearestNeighbor(dtri,query_points);

geo_face_idx3 = adata.idx3(pt_id);

[ucells,ind] = unique(geo_face_idx3);
mdist = dist(ind);

ucellX = adata.cell_X(ucells);
ucellY = adata.cell_Y(ucells);
uData = mdata.(varname)(ucells,thetime);

pred_lims = [0.05,0.25,0.5,0.75,0.95];
 num_lims = length(pred_lims);
        nn = (num_lims+1)/2;
[ix,iy] = size(uData);


inc = 1;
for i = 1:ix
    xd = uData(i,:);
    if sum(isnan(xd)) < length(xd)
        xd(isnan(xd)) = mean(xd(~isnan(xd)));
        pdata.pred_lim_ts(:,inc) = plims(xd,pred_lims)';
        pdata.dist(inc,1) = mdist(i);
        inc = inc + 1;
    end
end

fig1 = figure('position',[173         505        1597         420]);
set(fig1,'defaultTextInterpreter','latex')
set(0,'DefaultAxesFontName','Times')
set(0,'DefaultAxesFontSize',6)

ax = get(gca);

fig = fillyy(pdata.dist,pdata.pred_lim_ts(1,:),pdata.pred_lim_ts(2*nn-1,:),dimc,col_pal(1,:));hold on
set(fig,'DisplayName','Model Range');
hold on

for plim_i=2:(nn-1)
    fig2 = fillyy(pdata.dist,pdata.pred_lim_ts(plim_i,:),pdata.pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal(plim_i,:));
    set(fig2,'HandleVisibility','off');
end

plot(pdata.dist,pdata.pred_lim_ts(3,:),'color',median_line,'linewidth',0.5,'DisplayName','Model Median');
leg = legend('show');
set(leg,'location','NorthEast','fontsize',6);

%_________________________________________________________________________________________________________

sites = fieldnames(fdata);

fielddata = [];
fielddist = [];

for i = 1:length(fzone)
    thedist = str2num(fzone(i).Name);
    
    for j = 1:length(sites)
        
        if isfield(fdata.(sites{j}),varname)
            
            if inpolygon(fdata.(sites{j}).(varname).X,fdata.(sites{j}).(varname).Y,fzone(i).X,fzone(i).Y);
                
                sss = find(fdata.(sites{j}).(varname).Date >= daterange(1) & ...
                    fdata.(sites{j}).(varname).Date < daterange(end));
                
                if ~isempty(sss)
                    cdist = [];
                    cdist(1:length(sss),1) = thedist - 5;
                    cdata = fdata.(sites{j}).(varname).Data(sss)*conv;
                    fielddata = [fielddata;cdata];
                    fielddist = [fielddist;cdist];
                end
            end
        end
    end
end





boxplot(fielddata,fielddist,'positions',unique(fielddist));               

xlim(xl);
ylim(yl);
xlabs = [0:20:250];

set(gca,'xtick',xlabs,'xticklabel',xlabs);

xlabel('Distance from Ocean (km)','fontsize',8);
ylabel(ylab,'fontsize',8);
box_vars = findall(gca,'Tag','Box');


text(0.05,1.02,[datestr(daterange(1),'dd/mm/yyyy'),' to ',datestr(daterange(end),'dd/mm/yyyy')],'units','normalized',...
    'fontsize',6,'color',[0.4 0.4 0.4]);

xlim(xl);
ylim(yl);
xlabs = [0:20:250];
udist = unique(fielddist);

for i = 1:length(udist)
    
    if udist(i) < xl(end)
    
    sss = find(fielddist == udist(i));
    
    mval = max(fielddata(sss));
    
    mval = mval + offset;
    text(gca,udist(i),mval,['n=',num2str(length(sss))],'fontsize',5,'horizontalalignment','center');
    end
end
ah1=axes('position',get(gca,'position'),'visible','off');

hLegend = legend(ah1,box_vars([1]), {'Field Data'},'location','NorthWest','fontsize',6);

  set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = 16;
        ySize = 6;
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])



saveas(gcf,outname);

close





