function plottfv_transect(conf)
%BB 11
close all;


%--------------------------------------------------------------------------
disp('plottfv_transect: START')
disp('')
addpath(genpath('configs'));
addpath(genpath('../tuflowfv'));

run(conf);
warning('off','all')

if exist('isHTML','var') == 0
    isHTML = 1;
end
if ~exist('htmloutput','var')
    htmloutput = outputdirectory;
end

if ~isfield(def,'export_shapefile')
    def.export_shapefile = 0;
end

if ~exist('start_plot_ID','var')
    start_plot_ID = 1;
end

if ~exist('end_plot_ID','var')
    end_plot_ID = length(varname);
end

if ~exist('alph','var')
    alph = 0.5;
end

if ~exist('isSurf','var')
    isSurf = 1;
end

if ~exist('plotvalidation','var')
    plotvalidation = 1;
end

if ~isfield(def,'visible')
    def.visible = 'on';
end

if ~exist('fielddata_matfile','var')
    fielddata_matfile = ['matfiles/',fielddata,'.mat'];
end

if ~isfield(def,'boxlegend')
    def.boxlegend = 'northeast';
end
if ~isfield(def,'rangelegend')
    def.rangelegend = 'northwest';
end

if ~exist('thevars_conv','var')
    thevars_conv = 1;
end

if ~exist('preproc','var')
preproc = 0;
end

if ~exist('addmarker','var')
addmarker = 0;
end

if ~exist('isSpherical','var')
    isSpherical = 0;
end

isConv = 0;


allvars = tfv_infonetcdf(ncfile(1).name);

shp = shaperead(points_file);

% Need to add more colour palates. One for each simulation
def.col_pal(1).value =[[176 190 197]./255;[162 190 197]./255;[150 190 197]./255];
def.col_pal(2).value =[[215 204 200]./255; [200 204 200]./255; [185 204 200]./255 ];

def.median_line(1).value = [0 96 100]./255;
def.median_line(2).value = [0 0 0];

dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
pred_lims = [0.05,0.25,0.5,0.75,0.95];
num_lims = length(pred_lims);
nn = (num_lims+1)/2;
% Load Field Data and Get site names
field = load(fielddata_matfile);
fdata = field.(fielddata);
sitenames = fieldnames(fdata);

for i = 1:length(sitenames)
    vars = fieldnames(fdata.(sitenames{i}));
    X(i) = fdata.(sitenames{i}).(vars{1}).X;
    Y(i) = fdata.(sitenames{i}).(vars{1}).Y;
end


%for var = start_plot_ID:end_plot_ID





savedir = [outputdirectory,varname{1},'/'];
mkdir(savedir);
loadname = varname{1};

disp(['Plotting ',loadname]);

for mod = 1:length(ncfile)
    
    if ~preproc
        for k = 1:length(thevars)
            disp(thevars{k});
            td = tfv_readnetcdf(ncfile(mod).name,'names',thevars(k));
            
            
            switch thevars{k}
                case 'WQ_OGM_DON'
                    if sum(strcmpi(allvars,'WQ_OGM_DONR')) == 1
                        td2 = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});
                        td.(thevars{k}) = td.(thevars{k}) + td2.WQ_OGM_DONR;
                    end
                    
                case 'WQ_OGM_DOP'
                    if sum(strcmpi(allvars,'WQ_OGM_DOPR')) == 1
                        td2 = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOPR'});
                        td.(thevars{k}) = td.(thevars{k}) + td2.WQ_OGM_DOPR;
                    end
                otherwise
            end
            raw(mod).data(k).Val = td.(thevars{k})  * thevars_conv; clear td;
        end
    else
       %data1 = compile_tracer_sim(ncfile(mod).name);
       load(datafile);
       for k = 1:length(thevars)
           raw(mod).data(k).Val = data1.(loadname).(thevars{k}) * thevars_conv;
       end
    end 
        
        

    tdata = tfv_readnetcdf(ncfile(mod).name,'timestep',1);
    all_cells(mod).X = double(tdata.cell_X);
    all_cells(mod).Y = double(tdata.cell_Y);
    
    
end

for tim = 1:length(def.pdates)
    
    for mod = 1:length(ncfile)
        
        for k = 1:length(thevars)
            
            rd(mod).data.(thevars{k}) = raw(mod).data(k).Val;
            [data(mod),c_units,isConv] = tfv_getmodelpolylinedata_stacked(rd(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp,thevars(k),def.pdates(tim).value,isSurf,isSpherical);
            
            pData(:,k) = data(mod).pred_lim_ts(3,:);
            
            clear rd;
            
        end
    end
    
    
    
    
    if plotvalidation
        fielddata = [];
        fielddist = [];
        [fielddata,fielddist] = tfv_getfielddata_boxregion(fdata,shp,def,isSurf,varname{1},def.pdates(tim).value,isSpherical);
        
    end
    
    
    
    
    fig1 = figure('visible',def.visible);
    set(fig1,'defaultTextInterpreter','latex')
    set(0,'DefaultAxesFontName','Times')
    set(0,'DefaultAxesFontSize',6)
    
    cmap = parula(length(thevars));
    
    for mod = 1:length(ncfile)
        
        %         fig = fillyy(data(mod).dist,data(mod).pred_lim_ts(1,:),data(mod).pred_lim_ts(2*nn-1,:),dimc,def.col_pal(mod).value(1,:));hold on
        %         %fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc);hold on
        %         set(fig,'DisplayName',[ncfile(mod).legend,' (Range)']);
        %         set(fig,'FaceAlpha', alph);
        %         hold on
        %
        %         for plim_i=2:(nn-1)
        %             fig2 = fillyy(data(mod).dist,data(mod).pred_lim_ts(plim_i,:),data(mod).pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),def.col_pal(mod).value(plim_i,:));
        %             %fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1));
        %             set(fig2,'HandleVisibility','off');
        %             set(fig2,'FaceAlpha', alph);
        %         end
        %
        %         plot(data(mod).dist,data(mod).pred_lim_ts(3,:),'color',def.median_line(mod).value,'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' (Median)']);
        H = area(data(mod).dist,pData);hold on
        
    end
    
    for kk = 1:length(thevars)
        H(kk).FaceColor = cmap(kk,:);
    end
    
    
    leg = legend(regexprep(thevars,'_',' '));
    set(leg,'location',def.rangelegend,'fontsize',6);
    
    box_vars = [];
    if plotvalidation
        if ~isempty(fielddata)
            boxplot(fielddata,fielddist,'positions',unique(fielddist),'color','k','plotstyle','compact');
            box_vars = findall(gca,'Tag','Box');
        end
    end
    
    if ~isempty(def.cAxis(1).value)
        ylim(def.cAxis(1).value);
    end
    
    xlim(def.xlim);
    
    if ~isempty(def.xticks)
        set(gca,'xtick',def.xticks,'xticklabel',def.xticks);
    end
    
    ylabel([regexprep(loadname,'_',' '),' (',c_units,')'],'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
    
    xlabel(def.xlabel,'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
    
    if isSurf
        text(0.05,1.05,[datestr(def.pdates(tim).value(1),'dd/mm/yyyy'),' to ',datestr(def.pdates(tim).value(end),'dd/mm/yyyy'),': Surface'],'units','normalized',...
            'fontsize',6,'color',[0.4 0.4 0.4]);
    else
        text(0.05,1.05,[datestr(def.pdates(tim).value(1),'dd/mm/yyyy'),' to ',datestr(def.pdates(tim).value(end),'dd/mm/yyyy'),': Bottom'],'units','normalized',...
            'fontsize',6,'color',[0.4 0.4 0.4]);
    end
    
    if addmarker
        
        HH=gca; HH.XAxis.TickLength = [0 0];
        
        load marker.mat;
        
        yl = get(gca,'ylim');
        yl_r = (yl(2) - yl(1)) * 0.01;
        
        yx(1:length(marker.Dist)) = yl(2);
        scatter(marker.Start,yx- yl_r,12,'V','filled','MarkerFaceColor','k','HandleVisibility','off');
        

        
        for kkk = 1:length(marker.Dist)
            text(marker.Dist(kkk),yl(2)+ yl_r,['ERZ ',num2str(marker.Label(kkk))],'fontsize',4,'horizontalalignment','center');
        end
    end
        
    
    
    
    if ~isempty(box_vars)
        udist = unique(fielddist);
        
        yl = get(gca,'ylim');
        
        ryl = yl(2)-yl(1);
        
        offset = ryl * 0.03;
        
        
        for i = 1:length(udist)
            
            if udist(i) < def.xlim(end)
                
                sss = find(fielddist == udist(i));
                
                mval = max(fielddata(sss));
                
                mval = mval + offset;
                text(gca,udist(i),mval,['n=',num2str(length(sss))],'fontsize',5,'horizontalalignment','center');
            end
        end
        
    end
    
    if ~isempty(box_vars)
        
        ah1=axes('position',get(gca,'position'),'visible','off');
        
        hLegend = legend(ah1,box_vars([1]), {'Field Data'},'location',def.boxlegend,'fontsize',6);
        
        xlabel('Distance from Ocean (km)','fontsize',8);
        
    end
    
    
    set(gcf, 'PaperPositionMode', 'manual');
    set(gcf, 'PaperUnits', 'centimeters');
    xSize = def.dimensions(1);
    ySize = def.dimensions(2);
    xLeft = (21-xSize)/2;
    yTop = (30-ySize)/2;
    set(gcf,'paperposition',[0 0 xSize ySize])
    
    if isSurf
        image_name = [datestr(def.pdates(tim).value(1),'yyyy-mm-dd'),'_',datestr(def.pdates(tim).value(end),'yyyy-mm-dd'),'_Surface.png'];
    else
        image_name = [datestr(def.pdates(tim).value(1),'yyyy-mm-dd'),'_',datestr(def.pdates(tim).value(end),'yyyy-mm-dd'),'_Bottom.png'];
    end
    finalname = [savedir,image_name];
    
    print(gcf,finalname,'-opengl','-dpng');
    
    close;
    
    
end

if isHTML
    
    create_html_for_directory_onFly(savedir,varname{1},htmloutput);
    
end
%end
