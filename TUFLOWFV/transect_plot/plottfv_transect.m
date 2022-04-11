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

if exist('add_trigger_values','var') == 0
	add_trigger_values = 0
	
end
if ~exist('add_human','var')
    add_human = 0;
end
if exist('add_shapefile_label','var') == 0
	add_shapefile_label = 0
end
if exist('single_precision','var') == 0
	single_precision = 0;
end
if exist('use_matfiles','var') == 0
	use_matfiles = 0;
end


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

if ~exist('plot_array','var')
	plot_array = [];
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

if ~exist('clip_depth','var')
    clip_depth = 0.00;
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

if add_trigger_values
	[snum,sstr] = xlsread(trigger_file,'A2:D1000');
	
	trigger_vars = sstr(:,1);
	trigger_values = snum(:,1);
	trigger_label = sstr(:,3);
end
	
	
	



for i = 1:length(sitenames)
    vars = fieldnames(fdata.(sitenames{i}));
    X(i) = fdata.(sitenames{i}).(vars{1}).X;
    Y(i) = fdata.(sitenames{i}).(vars{1}).Y;
end


if use_matfiles
disp('Using Pre Processed Matfiles');
	for i = 1:length(ncfile)
		ncfile(i).dir = regexprep(ncfile(i).name,'.nc','/');
	end
end


if isempty(plot_array)
	plot_array = [start_plot_ID:end_plot_ID];
end



for var = plot_array
    
    
    
    
    
    savedir = [outputdirectory,varname{var},'/'];
    mkdir(savedir);
    loadname = varname{var};
    
    disp(['Plotting ',loadname]);
    
    for mod = 1:length(ncfile)
        %switch varname{var}
        %    
        %    case 'TN_TP'
        %        oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
        %        tra = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
        %        raw(mod).data.TN_TP = (oxy.WQ_DIAG_TOT_TN* 14/1000) ./ (tra.WQ_DIAG_TOT_TP* 31/1000);
        %        
        %        
        %    case 'ECOLI'
        %        
        %        ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});
        %        ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});
        %        raw(mod).data.ECOLI = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) ;
        %        clear ECOLI_F ECOLI_A
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ECLOI')
        %                fdata.(thesites{bdb}).ECOLI = fdata.(thesites{bdb}).ECLOI;
        %            end
        %        end
        %        
        %    case 'ECOLI_TOTAL'
        %        
        %        ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});
        %        ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});
        %        ECOLI_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_D'});
        %        raw(mod).data.ECOLI_TOTAL = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) + (ECOLI_D.WQ_PAT_ECOLI_D) ;
        %        clear ECOLI_F ECOLI_A ECOLI_D
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ECLOI')
        %                fdata.(thesites{bdb}).ECOLI_TOTAL = fdata.(thesites{bdb}).ECLOI;
        %            end
        %        end
        %        
        %    case 'ECOLI_PASSIVE'
        %        
        %        ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR1'});
        %        raw(mod).data.ECOLI_PASSIVE = (ECOLI_P.WQ_TRC_TR1) ;
        %        clear ECOLI_P
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ECLOI')
        %                fdata.(thesites{bdb}).ECOLI_PASSIVE = fdata.(thesites{bdb}).ECLOI;
        %            end
        %        end
        %        
        %    case 'ECOLI_SIMPLE'
        %        
        %        ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR1'});
        %        raw(mod).data.ECOLI_SIMPLE = (ECOLI_P.WQ_TRC_TR1) ;
        %        clear ECOLI_P
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ECLOI')
        %                fdata.(thesites{bdb}).ECOLI_SIMPLE = fdata.(thesites{bdb}).ECLOI;
        %            end
        %        end
        %        
        %    case 'ENTEROCOCCI'
        %        
        %        ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});
        %        ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});
        %        %ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});
        %        raw(mod).data.ENTEROCOCCI = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A)  ;
        %        clear ENT_F ENT_A
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ENT')
        %                fdata.(thesites{bdb}).ENTEROCOCCI = fdata.(thesites{bdb}).ENT;
        %            end
        %        end
        %        
        %    case 'ENTEROCOCCI_TOTAL'
        %        
        %        ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});
        %        ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});
        %        ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});
        %        raw(mod).data.ENTEROCOCCI_TOTAL = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A) + (ENT_D.WQ_PAT_ENTEROCOCCI_D) ;
        %        clear ENT_F ENT_A ENT_D
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ENT')
        %                fdata.(thesites{bdb}).ENTEROCOCCI_TOTAL = fdata.(thesites{bdb}).ENT;
        %            end
        %        end
        %        
        %    case 'ENTEROCOCCI_PASSIVE'
        %        
        %        ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});
        %        raw(mod).data.ENTEROCOCCI_PASSIVE = (ENT_P.WQ_TRC_TR2) ;
        %        clear ENT_P
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ENT')
        %                fdata.(thesites{bdb}).ENTEROCOCCI_PASSIVE = fdata.(thesites{bdb}).ENT;
        %            end
        %        end
        %        
        %    case 'ENTEROCOCCI_SIMPLE'
        %        
        %        ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});
        %        raw(mod).data.ENTEROCOCCI_SIMPLE = (ENT_P.WQ_TRC_TR2) ;
        %        clear ENT_P
        %        
        %        thesites = fieldnames(fdata);
        %        for bdb = 1:length(thesites)
        %            if isfield(fdata.(thesites{bdb}),'ENT')
        %                fdata.(thesites{bdb}).ENTEROCOCCI_SIMPLE = fdata.(thesites{bdb}).ENT;
        %            end
        %        end
        %        
        %    case 'HSI_CYANO'
        %        TEM =  tfv_readnetcdf(ncfile(mod).name,'names',{'TEMP'});
        %        SAL =  tfv_readnetcdf(ncfile(mod).name,'names',{'SAL'});
        %        NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
        %        AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
        %        FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
        %        DEP =  tfv_readnetcdf(ncfile(mod).name,'names',{'D'});
        %        V_x =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_x'});
        %        V_y =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_y'});
        %        
        %        %------ temperature
        %        %The numbers I've used for Darwin Reservoir cyanobacteria are:
        %        %Theta_growth (v) = 1.08;
        %        %T_std = 28; %T_opt = 34; %T_max = 40;
        %        k =  4.1102;
        %        a = 35.0623;
        %        b =  0.1071;
        %        v =  1.0800;
        %        fT = v.^(TEM.TEMP-20)-v.^(k.*(TEM.TEMP-a))+b;
        %        
        %        %------ nitrogen
        %        KN = 4;                %   in mmol/m3
        %        fN = (NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM) ./ (KN+(NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM));
        %        
        %        %------ phosphorus
        %        KP = 0.15;    % in mmol/m3
        %        fP = FRP.WQ_PHS_FRP./(KP+FRP.WQ_PHS_FRP);
        %        
        %        %------ salinity
        %        KS = 5;                %   in PSU
        %        fS = KS ./ (KS+(SAL.SAL));
        %        fS(SAL.SAL<KS/2.)=1;
        %        
        %        %------ stratification/velocity
        %        KV = 0.5;
        %        V = (V_x.V_x.*V_x.V_x + V_y.V_y.*V_y.V_y).^0.5; %   in m/s
        %        fV = KV ./ (KV+V);
        %        fV(V<0.05)=0.;
        %        
        %        raw(mod).data.HSI_CYANO = ( fT .* min(fN,fP) .* fS .* fV);
        %        raw(mod).data.HSI_CYANO(raw(mod).data.HSI_CYANO<0.5) = 0;
        %        
        %        clear fT;
        %        
        %    otherwise
        %        raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});
        %end
        
		[raw(mod).data,fdata]  = import_netcdf_data(ncfile,mod,varname,var,fdata,loadname,allvars,single_precision,use_matfiles);clear functions
		
		
        tdata = tfv_readnetcdf(ncfile(mod).name,'timestep',1);
        all_cells(mod).X = double(tdata.cell_X);
        all_cells(mod).Y = double(tdata.cell_Y);
        
        if sum(strcmpi(allvars,'D')) == 1
            ttdata = tfv_readnetcdf(ncfile(mod).name,'names','D');
        else
            tttdata = tfv_readnetcdf(ncfile(mod).name,'names',{'cell_Zb';'H'}); clear functions
            ttdata.D = tttdata.H - tttdata.cell_Zb;clear tttdata;
        end
        
        d_data(mod).D = ttdata.D;
        
    end
    
    for tim = 1:length(def.pdates)
        
        for mod = 1:length(ncfile)
            
            [data(mod),c_units,isConv] = tfv_getmodelpolylinedata(raw(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp,{loadname},def.pdates(tim).value,isSurf,isSpherical,d_data(mod).D,clip_depth,use_matfiles);
        c_units
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
		if add_shapefile_label
			dist(1,1) = 0;
			for gdg = 1:length(shp)
				sdata(gdg,1) = shp(gdg).X;
				sdata(gdg,2) = shp(gdg).Y;
				labels(gdg,1) = {shp(gdg).Name};
			end
			for hhh = 2:length(shp)
				dist(hhh,1) = sqrt(power((sdata(hhh,1) - sdata(hhh-1,1)),2) + power((sdata(hhh,2)- sdata(hhh-1,2)),2)) + dist(hhh-1,1);
			end
			dist = dist / 1000;
			%dist
			%labels
			if length(dist) > 15
				set(gca,'xtick',dist(1:2:end),'xticklabels',labels(1:2:end),'fontsize',4);
			else
				set(gca,'xtick',dist,'xticklabels',labels,'fontsize',4);
			end
			set(gca,'XTickLabelRotation',90)
		end	
		

		
		
        
		if add_human
            ylabel([regexprep(varname_human{var},'_',' '),' (',c_units,')'],'fontsize',10,'color',[0.4 0.4 0.4],'horizontalalignment','center');
		else
			if strcmpi(loadname,'TN_TP') == 0
				ylabel([regexprep(loadname,'_',' '),' (',c_units,')'],'fontsize',10,'color',[0.4 0.4 0.4],'horizontalalignment','center');
			else
				ylabel([regexprep(loadname,'_',':'),' (',c_units,')'],'fontsize',10,'color',[0.4 0.4 0.4],'horizontalalignment','center');
			end
		end

        
        xlabel(def.xlabel,'fontsize',10,'color',[0.4 0.4 0.4],'horizontalalignment','center');
        
        if isSurf
            text(0.05,1.05,[datestr(def.pdates(tim).value(1),'dd/mm/yyyy'),' to ',datestr(def.pdates(tim).value(end),'dd/mm/yyyy'),': Surface'],'units','normalized',...
                'fontsize',8,'color',[0.4 0.4 0.4]);
        else
            text(0.05,1.05,[datestr(def.pdates(tim).value(1),'dd/mm/yyyy'),' to ',datestr(def.pdates(tim).value(end),'dd/mm/yyyy'),': Bottom'],'units','normalized',...
                'fontsize',8,'color',[0.4 0.4 0.4]);
        end
        

		if add_trigger_values
		
		trig = find(strcmpi(trigger_vars,loadname) == 1);
		
			if ~isempty(trig)
			
				plot([def.xlim(1) def.xlim(end)],[trigger_values(trig) trigger_values(trig)],'--r','DisplayName',trigger_label{trig});
			end
		end
		
		
		
        
        if addmarker
            
            HH=gca; HH.XAxis.TickLength = [0 0];
            
            load(markerfile);
            
            yl = get(gca,'ylim');
            yl_r = (yl(2) - yl(1)) * 0.01;
            
            yx(1:length(marker.Dist)) = yl(2);
            scatter(marker.Start,yx- yl_r,12,'V','filled','MarkerFaceColor','k','HandleVisibility','off');
            
            %for kkk = 1:length(marker.Dist)
            %    text(marker.Dist(kkk),yl(2)+ yl_r,['ERZ ',num2str(marker.Label(kkk))],'fontsize',4,'horizontalalignment','center');
            %end
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
                    text(gca,udist(i),mval,['n=',num2str(length(sss))],'fontsize',6,'horizontalalignment','center');
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
