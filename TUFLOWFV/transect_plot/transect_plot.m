function transect_plot(theStruct)

addpath(genpath('tuflowfv'));

ncfile = theStruct.ncfile;


if ~isfield(theStruct,'Depth')
    theStruct.Depth = 'Surface';
end


fielddata_matfile = theStruct.fielddata_matfile;
fielddata = theStruct.fielddata;

polygon_file = theStruct.polygon_file;

polygon_line = theStruct.polygon_line;

varname = theStruct.varname;
ylab = theStruct.ylab;
conv = theStruct.conv;

xl = theStruct.xl;
yl = theStruct.yl;
offset = theStruct.offset;

outname = theStruct.outname;
outdir = theStruct.outdir;
daterange = theStruct.daterange;

if ~exist(outdir,'dir')
    mkdir(outdir);
end

%________________________________________

surface_edge_color = [ 30  50  53]./255;
surface_face_color = [ 68 108 134]./255;
surface_line_color = [  0  96 100]./255;  %[69  90 100]./255;
col_pal            =[[176 190 197]./255;[120 144 156]./255;[130 167 214]./255];
median_line = [0 96 100]./255;
dimc = [0.9 0.9 0.9]; % dimmest (lightest) color

field = load(fielddata_matfile);
fdata = field.(fielddata);

fdata = add_secondary(fdata);


pline = shaperead(polygon_line);
fzone = shaperead(polygon_file);

switch varname
    case 'TN_TP'
        
        
        mdata = tfv_readnetcdf(ncfile,'names',{'WQ_DIAG_TOT_TN';'WQ_DIAG_TOT_TP'});
        mdata.(varname) = (mdata.WQ_DIAG_TOT_TN * 14/1000) ./ (mdata.WQ_DIAG_TOT_TP* 31/1000);
        
        mdata.(varname) = mdata.(varname) * conv;
        
        
        
    otherwise
        mdata = tfv_readnetcdf(ncfile,'names',{varname});
        mdata.(varname) = mdata.(varname) * conv;
        
end
adata = tfv_readnetcdf(ncfile,'timestep',1);
mtime = tfv_readnetcdf(ncfile,'time',1);

thetime = find(mtime.Time >= daterange(1) & ...
    mtime.Time < daterange(end));
datestr(mtime.Time(1))
datestr(mtime.Time(end))
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


for i = 1:length(pt_id)
    Cell_3D_IDs = find(adata.idx2==pt_id(i));
    surfIndex(i) = min(Cell_3D_IDs);
    botIndex(i) = max(Cell_3D_IDs);
    % geo_face_idx3 = adata.idx3(pt_id);
    %
    % [ucells,ind] = unique(geo_face_idx3);
    %
    %
    % ucellX = adata.cell_X(ucells);
    % ucellY = adata.cell_Y(ucells);
    %
    %
    % surface_data = mdata.(varname)(adata.idx3(tdat.idx3 > 0),:);
    
end
mdist = dist;

if strcmpi(theStruct.Depth,'Surface')==1
    uData =  mdata.(varname)(surfIndex,thetime);
else
    uData =  mdata.(varname)(botIndex,thetime);
end

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

fig1 = figure;%('position',[173         505        1597         420]);
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


% ggg = find(pdata.pred_lim_ts(3,:) == 0);
%
% pdata.dist(ggg)
%
% stop


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
                    cdist(1:length(sss),1) = thedist - theStruct.Polyoffset;
                    cdata = fdata.(sites{j}).(varname).Data(sss)*conv;
                    fielddata = [fielddata;cdata];
                    fielddist = [fielddist;cdist];
                end
            end
        end
    end
end




if ~isempty(fielddata)
    boxplot(fielddata,fielddist,'positions',unique(fielddist),'color','k','plotstyle','compact');
end
xlim(xl);
if ~isempty(yl)
    ylim(yl);
end
xlabs = [0:20:250];

set(gca,'xtick',xlabs,'xticklabel',xlabs);

ylabel(ylab,'fontsize',8);
%xlabel('Distance from Ocean (km)','fontsize',8);

if ~isempty(fielddata)
    box_vars = findall(gca,'Tag','Box');
end

text(0.05,1.02,[datestr(daterange(1),'dd/mm/yyyy'),' to ',datestr(daterange(end),'dd/mm/yyyy')],'units','normalized',...
    'fontsize',6,'color',[0.4 0.4 0.4]);

% if ~isempty(fielddata)
%     leg = legend('show');
%     set(leg,'location','NorthEast','fontsize',6);
%
% else
%     leg = legend('show');
%     set(leg,'location','NorthEast','fontsize',6);
% end

xlim(xl);
if ~isempty(yl)
    ylim(yl);
end
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
if ~isempty(fielddata)
    
    ah1=axes('position',get(gca,'position'),'visible','off');
    
    hLegend = legend(ah1,box_vars([1]), {'Field Data'},'location','NorthWest','fontsize',6);
    
    xlabel('Distance from Ocean (km)','fontsize',8);
    
end

text(0.5,-0.1,'Distance from Ocean (km)','units','normalized',...
    'fontsize',8,'color','k','horizontalalignment','center');


set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'PaperUnits', 'centimeters');
xSize = 16;
ySize = 8;
xLeft = (21-xSize)/2;
yTop = (30-ySize)/2;
set(gcf,'paperposition',[0 0 xSize ySize])



print(gcf,[outdir,outname],'-dpng','-opengl');

close

end

function fdata = add_secondary(fdata)

sites = fieldnames(fdata);

for i = 1:length(sites)
    
    if isfield(fdata.(sites{i}),'WQ_DIAG_TOT_TN') && ...
            isfield(fdata.(sites{i}),'WQ_DIAG_TOT_TP')
        
        
        
        TN_Date = fdata.(sites{i}).WQ_DIAG_TOT_TN.Date;
        TN_Data = fdata.(sites{i}).WQ_DIAG_TOT_TN.Data * 14/1000;
        TN_Depth = fdata.(sites{i}).WQ_DIAG_TOT_TN.Depth;
        
        TP_Date = fdata.(sites{i}).WQ_DIAG_TOT_TP.Date;
        TP_Data = fdata.(sites{i}).WQ_DIAG_TOT_TP.Data * 31/1000;
        TP_Depth = fdata.(sites{i}).WQ_DIAG_TOT_TP.Data;
        
        
        
        inc = 1;
        
        for j = 1:length(TN_Date)
            
            sss = find(TP_Date == TN_Date(j));% & ...
                %TP_Depth == TN_Depth(j));
            
            if ~isempty(sss)
                
                fdata.(sites{i}).TN_TP.Date(inc,1) = TN_Date(j);
                fdata.(sites{i}).TN_TP.Data(inc,1) = TN_Data(j) / TP_Data(sss(1));
                fdata.(sites{i}).TN_TP.Depth(inc,1) = TN_Depth(j);
                fdata.(sites{i}).TN_TP.X = fdata.(sites{i}).WQ_DIAG_TOT_TN.X;
                fdata.(sites{i}).TN_TP.Y = fdata.(sites{i}).WQ_DIAG_TOT_TN.Y;
                fdata.(sites{i}).TN_TP.Agency = fdata.(sites{i}).WQ_DIAG_TOT_TN.Agency;
                
                inc = inc + 1;
                
                
                
                %disp('Found TN:TP');
            end
        end
    end
end
end







