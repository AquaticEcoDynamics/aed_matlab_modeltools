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

if ~exist('isSpherical','var')
    isSpherical = 0;
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

if exist('isRange','var') == 0
    isRange = 0;
end

if ~exist('addmarker','var')
addmarker = 0;
end
if ~exist('markerfile','var')
markerfile = 'marker2.mat';
end
isConv = 0;


allvars = tfv_infonetcdf(ncfile(1).name);

shp = shaperead(points_file);

% Need to add more colour palates. One for each simulation
def.col_pal(1).value =[[176 190 197]./255;[162 190 197]./255;[150 190 197]./255];
def.col_pal(2).value =[[215 204 200]./255; [200 204 200]./255; [185 204 200]./255 ];

def.median_line(1).value = [0 96 100]./255;
def.median_line(2).value = [0 0 0];
def.median_line(3).value = 'g';
def.median_line(4).value = 'b';

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


for var = start_plot_ID:end_plot_ID





    savedir = [outputdirectory,varname{var},'/'];
    mkdir(savedir);
    loadname = varname{var};

    disp(['Plotting ',loadname]);

    for mod = 1:length(ncfile)
        switch varname{var}

            case 'TN_TP'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                tra = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                raw(mod).data.TN_TP = (oxy.WQ_DIAG_TOT_TN* 14/1000) ./ (tra.WQ_DIAG_TOT_TP* 31/1000);


                case 'ECOLI'
                    
                    ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});
                    ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});
                    raw(mod).data.ECOLI = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) ;
                    clear ECOLI_F ECOLI_A
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI = fdata.(thesites{bdb}).ECLOI;
                        end
                    end

                case 'ECOLI_TOTAL'
                    
                    ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});
                    ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});
                    ECOLI_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_D'});
                    raw(mod).data.ECOLI_TOTAL = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) + (ECOLI_D.WQ_PAT_ECOLI_D) ;
                    clear ECOLI_F ECOLI_A ECOLI_D
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_TOTAL = fdata.(thesites{bdb}).ECLOI;
                        end
                    end

                case 'ECOLI_PASSIVE'
                    
                    ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR1'});
                    raw(mod).data.ECOLI_PASSIVE = (ECOLI_P.WQ_TRC_TR1) ;
                    clear ECOLI_P  
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_PASSIVE = fdata.(thesites{bdb}).ECLOI;
                        end
                    end

                case 'ECOLI_SIMPLE'
                    
                    ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR3'});
                    raw(mod).data.ECOLI_SIMPLE = (ECOLI_P.WQ_TRC_TR3) ;
                    clear ECOLI_P  
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_SIMPLE = fdata.(thesites{bdb}).ECLOI;
                        end
                    end
                    
                case 'ENTEROCOCCI'
                    
                    ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});
                    ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});
                    %ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});
                   raw(mod).data.ENTEROCOCCI = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A)  ;
                    clear ENT_F ENT_A 
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'ENTEROCOCCI_TOTAL'
                    
                    ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});
                    ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});
                    ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});
                   raw(mod).data.ENTEROCOCCI_TOTAL = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A) + (ENT_D.WQ_PAT_ENTEROCOCCI_D) ;
                    clear ENT_F ENT_A ENT_D
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_TOTAL = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'ENTEROCOCCI_PASSIVE'
                    
                    ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});
                    raw(mod).data.ENTEROCOCCI_PASSIVE = (ENT_P.WQ_TRC_TR2) ;
                    clear ENT_P  
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_PASSIVE = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'ENTEROCOCCI_SIMPLE'
                    
                    ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR4'});
                    raw(mod).data.ENTEROCOCCI_SIMPLE = (ENT_P.WQ_TRC_TR4) ;
                    clear ENT_P  
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_SIMPLE = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                    
                    
            otherwise
                raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});
        end
        
        tdata = tfv_readnetcdf(ncfile(mod).name,'timestep',1);
        all_cells(mod).X = double(tdata.cell_X);
        all_cells(mod).Y = double(tdata.cell_Y);





    end

    for tim = 1:length(def.pdates)

        for mod = 1:length(ncfile)
            
            [data(mod),c_units,isConv] = tfv_getmodelpolylinedata(raw(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp,{loadname},def.pdates(tim).value,isSurf,isSpherical);
        end
        clear functions;


        if plotvalidation
            fielddata = [];
            fielddist = [];
            [fielddata,fielddist] = tfv_getfielddata_boxregion(fdata,shp,def,isSurf,loadname,def.pdates(tim).value,isSpherical);

        end
        clear functions;



        fig1 = figure('visible',def.visible);
        set(fig1,'defaultTextInterpreter','latex')
        set(0,'DefaultAxesFontName','Times')
        set(0,'DefaultAxesFontSize',6)

        for mod = 1:length(ncfile)
            if isRange
                fig = fillyy(data(mod).dist,data(mod).pred_lim_ts(1,:),data(mod).pred_lim_ts(2*nn-1,:),dimc,def.col_pal(mod).value(1,:));hold on
                %fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc);hold on
                set(fig,'DisplayName',[ncfile(mod).legend,' (Range)']);
                set(fig,'FaceAlpha', alph);
                hold on

                for plim_i=2:(nn-1)
                    fig2 = fillyy(data(mod).dist,data(mod).pred_lim_ts(plim_i,:),data(mod).pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),def.col_pal(mod).value(plim_i,:));
                    %fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1));
                    set(fig2,'HandleVisibility','off');
                    set(fig2,'FaceAlpha', alph);
                end
            end
            plot(data(mod).dist,data(mod).pred_lim_ts(3,:),'color',def.median_line(mod).value,'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' (Median)']);hold on

        end

        leg = legend('show');
        set(leg,'location',def.rangelegend,'fontsize',6);

        box_vars = [];
        if plotvalidation
            if ~isempty(fielddata)
                boxplot(fielddata,fielddist,'positions',unique(fielddist),'color','k','plotstyle','compact');
                box_vars = findall(gca,'Tag','Box');
            end
        end

        if ~isempty(def.cAxis(var).value)
            ylim(def.cAxis(var).value);
        end

        xlim(def.xlim);

        if ~isempty(def.xticks)
            set(gca,'xtick',def.xticks,'xticklabel',def.xticks);
        end
        if strcmpi(loadname,'TN_TP') == 0
         ylabel([regexprep(loadname,'_',' '),' (',c_units,')'],'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
        else
          ylabel([regexprep(loadname,'_',':'),' (',c_units,')'],'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
        end

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
        
        load(markerfile);
        
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


    end

    if isHTML

        create_html_for_directory_onFly(savedir,varname{var},htmloutput);

    end
end
