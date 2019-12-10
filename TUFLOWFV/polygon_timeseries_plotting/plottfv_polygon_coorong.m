function plottfv_polygon(conf)

close all;

addpath(genpath('configs'));
run(conf);

warning('off','all')


if exist('isRange','var') == 0
    isRange = 1;
end

if exist('Range_ALL','var') == 0
    Range_ALL = 0;
end

if exist('isRange_Bottom','var') == 0
    isRange_Bottom = 0;
end

if ~exist('custom_datestamp','var')
    custom_datestamp = 0;
end

if ~exist('add_triangle','var')
    add_triangle = 0;
end

isConv = 0;

allvars = tfv_infonetcdf(ncfile(1).name);

shp = shaperead(polygon_file);

if ~exist('plotmodel','var')
    plotmodel = 1;
end

max_depth = 5000;
if ~exist('depth_range','var')
    depth_range = [0 max_depth];
end

if exist('plotsite','var')
    shp_t = shp;
    clear shp;
    inc = 1;
    disp('Removing plotting sites');
    for bhb = 1:length(shp_t)

        if ismember(shp_t(bhb).Plot_Order,plotsite)

            shp(inc) = shp_t(bhb);
            inc = inc + 1;
        end
    end
end

col_pal = [[255 195 77]./255;[255 159 0]./255;[255 129 0]./255];
col_pal = [[255 195 77]./255;[255 159 0]./255;[255 129 0]./255];

%col_pal_bottom = [[0.8 0.8 0.8];[0.5 0.5 0.5];[0.3 0.3 0.3]];
col_pal_bottom = [[0.627450980392157         0.796078431372549                         1];...
    [0.0549019607843137         0.525490196078431         0.968627450980392];...
    [0.0509803921568627         0.403921568627451         0.968627450980392]];

bottom_edge_color = [0.0509803921568627         0.215686274509804         0.968627450980392];

% Load Field Data and Get site names
field = load(['matfiles/',fielddata,'.mat']);
fdata = field.(fielddata);
sitenames = fieldnames(fdata);

for i = 1:length(sitenames)
    vars = fieldnames(fdata.(sitenames{i}));
    X(i) = fdata.(sitenames{i}).(vars{1}).X;
    Y(i) = fdata.(sitenames{i}).(vars{1}).Y;
end

for mod = 1:length(ncfile)
    tdata = tfv_readnetcdf(ncfile(mod).name,'timestep',1);
    all_cells(mod).X = double(tdata.cell_X);
    all_cells(mod).Y = double(tdata.cell_Y);

    % name2 = 'Z:\Busch\Studysites\Peel\2018_Modelling\Peel_WQ_Model_v4_benthic\Output\benthic_08flow\sim_2016_Open_2D.nc';
    ttdata = tfv_readnetcdf(ncfile(mod).name,'names','D');
    %ttdata = tfv_readnetcdf(ncfile(mod).name,'names','D');
    d_data(mod).D = ttdata.D;
end


allvars = tfv_infonetcdf(ncfile(1).name);



clear ttdata
%D = 0;

for var = 1:length(varname)

    savedir = [outputdirectory,varname{var},'/'];
    mkdir(savedir);
    mkdir([savedir,'eps/']);


    for mod = 1:length(ncfile)
        disp(['Loading Model ',num2str(mod)]);
        loadname = varname{var};

        switch varname{var}

            case 'OXYPC'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_AED_OXYGEN_OXY'});
                tra = tfv_readnetcdf(ncfile(mod).name,'names',{'TRACE_1'});

                raw(mod).data.OXYPC = tra.TRACE_1 ./ oxy.WQ_AED_OXYGEN_OXY;
                clear tra oxy
            case 'WindSpeed'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});
                
                raw(mod).data.WindSpeed = sqrt(power(oxy.W10_x,2) + power(oxy.W10_y,2));
                clear  oxy
                
            case 'WindDirection'
                
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});

                raw(mod).data.WindDirection = (180 / pi) * atan2(-1*oxy.W10_x,-1*oxy.W10_y);
                
                clear  oxy
                
                
            case 'WQ_DIAG_PHY_TCHLA'
                
                if sum(strcmpi(allvars,'WQ_DIAG_PHY_TCHLA')) == 0
                
                    tchl = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN';'WQ_PHY_CRYPT';'WQ_PHY_DIATOM';'WQ_PHY_DINO';'WQ_PHY_BGA'});

                    raw(mod).data.WQ_DIAG_PHY_TCHLA = (((tchl.WQ_PHY_GRN / 50)*12) + ...
                        ((tchl.WQ_PHY_CRYPT / 50)*12) + ...
                        ((tchl.WQ_PHY_DIATOM / 26)*12) + ...
                        ((tchl.WQ_PHY_DINO / 40)*12) + ...
                        ((tchl.WQ_PHY_BGA / 40)*12));
                    clear tchl
                else
                  raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});
                end

            case 'V'
                oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'V_x';'V_y'});

                raw(mod).data.V = sqrt(power(oxy.V_x,2) + power(oxy.V_y,2));
                clear tra oxy

            case 'ON'
                %                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                %                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                %                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                %                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
                %                 raw(mod).data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);

                DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});
                PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});
                raw(mod).data.ON = DON.WQ_OGM_DON + PON.WQ_OGM_PON;

                clear DON PON


            case 'TN'
                %                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                %                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                %                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                %                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
                %                 raw(mod).data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);
                NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});
                PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});
                raw(mod).data.TN = DON.WQ_OGM_DON + PON.WQ_OGM_PON + NIT.WQ_NIT_NIT + AMM.WQ_NIT_AMM;

                clear TN AMM NIT


            case 'OP'
                %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                %
                %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});
                PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POP'});
                raw(mod).data.OP = DON.WQ_OGM_DOP + PON.WQ_OGM_POP;
                clear TP FRP


            case 'WQ_OGM_DON'
                %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                %
                %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});

                if sum(strcmpi(allvars,'WQ_OGM_DONR')) > 0

                    DONR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});
                    raw(mod).data.WQ_OGM_DON = DON.WQ_OGM_DON + DONR.WQ_OGM_DONR;



                else
                    raw(mod).data.WQ_OGM_DON = DON.WQ_OGM_DON;% + DONR.WQ_OGM_DONR;

                end
                clear DON DONR
            case 'WQ_OGM_DOC'
                %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                %
                %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                DOC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOC'});

                if sum(strcmpi(allvars,'WQ_OGM_DOCR')) > 0

                    DOCR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOCR'});
                    raw(mod).data.WQ_OGM_DOC = DOC.WQ_OGM_DOC + DOCR.WQ_OGM_DOCR;

                else
                    raw(mod).data.WQ_OGM_DOC = DOC.WQ_OGM_DOC;% + DOCR.WQ_OGM_DOCR;
                end

                clear DOC DOCR

            case 'WQ_OGM_DOP'
                %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                %
                %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                DOP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});

                if sum(strcmpi(allvars,'WQ_OGM_DOPR')) > 0

                    DOPR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOPR'});
                    raw(mod).data.WQ_OGM_DOP = DOP.WQ_OGM_DOP + DOPR.WQ_OGM_DOPR;

                else
                    raw(mod).data.WQ_OGM_DOP = DOP.WQ_OGM_DOP;% + DOPR.WQ_OGM_DOPR;
                end

                clear DOP DOPR



            case 'TURB'
                SS1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NCS_SS1'});
                POC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POC'});
                GRN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});

                raw(mod).data.TURB = (SS1.WQ_NCS_SS1 .* 2.356)  + (GRN.WQ_PHY_GRN .* 0.1) + (POC.WQ_OGM_POC / 83.333333 .* 0.1);

                clear TP FRP

                sites = fieldnames(fdata);
                for bdb = 1:length(sites)
                    if isfield(fdata.(sites{bdb}),'WQ_DIAG_TOT_TURBIDITY')
                        fdata.(sites{bdb}).TURB = fdata.(sites{bdb}).WQ_DIAG_TOT_TURBIDITY;
                    end
                end

            otherwise

                raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});
        end
    end

    clear functions


    switch varname{var}

        case 'WQ_OXY_OXY'
            ylab = 'Oxygen (mg/L)';
        case 'SAL'
            ylab = 'Salinity (psu)';
        case 'TEMP'
            ylab = 'Temperature (C)';
        otherwise
            ylab = '';
    end

    for site = 1:length(shp)


        isepa = 0;
        isdewnr = 0;

        dimc = [0.9 0.9 0.9]; % dimmest (lightest) color
        pred_lims = [0.05,0.25,0.5,0.75,0.95];
        num_lims = length(pred_lims);
        nn = (num_lims+1)/2;

        leg_inc = 1;


        inpol = inpolygon(X,Y,shp(site).X,shp(site).Y);

        sss = find(inpol == 1);

        disp(strcat(' >>> var',num2str(var),'=',varname{var},'; site=',num2str(site),[': ',regexprep(shp(site).Name,'_',' ')]))

        epa_leg = 0;
        dewnr_leg = 0;


        for mod = 1:length(ncfile)

            [data(mod),c_units,isConv] = tfv_getmodeldatapolygon(raw(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp(site).X,shp(site).Y,{loadname},d_data(mod).D,depth_range);


            for lev = 1:length(plotdepth)

                if strcmpi(plotdepth{lev},'bottom') == 1
                  if isfield(data,'date')
                        if mod == 1 | Range_ALL == 1
                            %
                            if isRange_Bottom
                                fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc,col_pal_bottom(1,:));hold on
                                %fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc);hold on
                                set(fig,'DisplayName',[ncfile(mod).legend,' Bottom (Range)']);
                                hold on

                                for plim_i=2:(nn-1)
                                    fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal_bottom(plim_i,:));
                                    %fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1));
                                    set(fig2,'HandleVisibility','off');
                                end
                            end
                        end

                        if mod == 1
                            if ~isempty(sss)
                                fplotw = 0;
                                fplotm = 0;
                                fplots = 0;
                                fplotmu = 0;

                                site_string = ['     field: '];
                                for j = 1:length(sss)
                                    if isfield(fdata.(sitenames{sss(j)}),varname{var})


                                        xdata_t = [];
                                        ydata_t = [];

                                        [xdata_t,ydata_t] = get_field_at_depth(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});


                                        if ~isempty(xdata_t)

                                            [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);

                                            [ydata_d,c_units,isConv] = tfv_Unit_Conversion(ydata_d,varname{var});

                                            if isfield(fdata.(sitenames{sss(j)}).(varname{var}),'Agency')
                                                agency = fdata.(sitenames{sss(j)}).(varname{var}).Agency;
                                                
                                            else
                                                agency = 'WIR';
                                            end

                                            site_string = [site_string,' ',sitenames{sss(j)},'(',agency,'),'];

                                            %                     if strcmpi(agency,'DEWNR')

                                            if plotvalidation
                                                switch agency
                                                    case 'WIR'
                                                        if fplotw
                                                            fp = plot(xdata_d,ydata_d,'o',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none' ,'markersize',3,'HandleVisibility','off');hold on
                                                        else
                                                            fp = plot(xdata_d,ydata_d,'o',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',3,'displayname','WIR Bottom');hold on
                                                            fplotw = 1;
                                                        end
                                                        uistack(fp,'top');
                                                    case 'MAFRL'

                                                        %if min(data(mod).date < datenum(2002,01,01))

                                                        if fplotm
                                                            fp = plot(xdata_d,ydata_d,'p',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',2,'HandleVisibility','off');hold on
                                                        else
                                                            fp = plot(xdata_d,ydata_d,'p',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',2,'displayname','MAFRL Bottom');hold on
                                                            fplotm = 1;
                                                        end
                                                        uistack(fp,'top');

                                                        %end
                                                    case 'SCU'
                                                        if fplots
                                                            fp = plot(xdata_d,ydata_d,'d',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',4,'HandleVisibility','off');hold on
                                                        else
                                                            fp = plot(xdata_d,ydata_d,'d',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',4,'displayname','SCU Bottom');hold on
                                                            fplots = 1;
                                                        end
                                                        uistack(fp,'top');
                                                    case 'MU'
                                                        if fplotmu
                                                            fp = plot(xdata_d,ydata_d,'s',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',4,'HandleVisibility','off');hold on
                                                        else
                                                            fp = plot(xdata_d,ydata_d,'s',...
                                                                'markeredgecolor',bottom_edge_color,'markerfacecolor','none','markersize',4,'displayname','MU Bottom');hold on
                                                            fplotmu = 1;
                                                        end
                                                        uistack(fp,'top');
                                                    otherwise
                                                end
                                            end

                                        end
                                    end


                                end
                                if(strlength(site_string)>7)
                                  disp(site_string)
                                end
                                clear site_string;
                            end
                        end





                        [xdata,ydata] = tfv_averaging(data(mod).date_b,data(mod).pred_lim_ts_b(3,:),def);

                        %                 xdata = data(mod).date;
                        %                 ydata = data(mod).pred_lim_ts(3,:);
                        if plotmodel
                            plot(xdata,ydata,'color',ncfile(mod).colour{lev},'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' Bottom (Median)'],...
                                'linestyle',ncfile(mod).symbol{1});hold on
                        end
                        plotdate(1:length(xdata),mod) = xdata;
                        plotdata(1:length(ydata),mod) = ydata;

                    end




                else
                    if plotmodel
                        if isfield(data,'date')
                            if mod == 1 | Range_ALL == 1

                                if isRange
                                    %
                                    fig = fillyy(data(mod).date,data(mod).pred_lim_ts(1,:),data(mod).pred_lim_ts(2*nn-1,:),dimc,col_pal(1,:));hold on
                                    set(fig,'DisplayName',[ncfile(mod).legend,' Surface (Range)']);
                                    hold on

                                    for plim_i=2:(nn-1)
                                        fig2 = fillyy(data(mod).date,data(mod).pred_lim_ts(plim_i,:),data(mod).pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal(plim_i,:));
                                        set(fig2,'HandleVisibility','off');
                                    end
                                end
                            end
                        end
                    end
                    if mod == 1
                        if ~isempty(sss)
                            fplotw = 0;
                            fplotm = 0;
                            fplots = 0;
                            fplotmu = 0;
                            for j = 1:length(sss)
                                if isfield(fdata.(sitenames{sss(j)}),varname{var})
                                    xdata_t = [];
                                    ydata_t = [];
                                    [xdata_t,ydata_t] = get_field_at_depth(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});

                                    if ~isempty(xdata_t)


                                        [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);

                                        [ydata_d,c_units,isConv] = tfv_Unit_Conversion(ydata_d,varname{var});

                                        if isfield(fdata.(sitenames{sss(j)}).(varname{var}),'Agency')
                                            agency = fdata.(sitenames{sss(j)}).(varname{var}).Agency;
                                        else
                                            agency = 'WIR';
                                        end

                                        %                     if strcmpi(agency,'DEWNR')

                                        if plotvalidation
                                            switch agency
                                                case 'WIR'
                                                    if fplotw
                                                        fp = plot(xdata_d,ydata_d,'ok','markerfacecolor',[255/255 61/255 9/255] ,'markersize',3,'HandleVisibility','off');hold on
                                                    else
                                                        fp = plot(xdata_d,ydata_d,'ok','markerfacecolor',[255/255 61/255 9/255],'markersize',3,'displayname','WIR Surface');hold on
                                                        fplotw = 1;
                                                    end
                                                    uistack(fp,'top');
                                                case 'MAFRL'

                                                    % if min(data(mod).date) < datenum(2002,01,01)

                                                    if fplotm
                                                        fp = plot(xdata_d,ydata_d,'pk','markerfacecolor',[232/255 90/255 24/255],'markersize',2,'HandleVisibility','off');hold on
                                                    else
                                                        fp = plot(xdata_d,ydata_d,'pk','markerfacecolor',[232/255 90/255 24/255],'markersize',2,'displayname','MAFRL Surface');hold on
                                                        fplotm = 1;
                                                    end
                                                    uistack(fp,'top');
                                                    %end
                                                case 'SCU'
                                                    if fplots
                                                        fp = plot(xdata_d,ydata_d,'dk','markerfacecolor',[255/255 111/255 4/255],'markersize',4,'HandleVisibility','off');hold on
                                                    else
                                                        fp = plot(xdata_d,ydata_d,'dk','markerfacecolor',[255/255 111/255 4/255],'markersize',4,'displayname','SCU Surface');hold on
                                                        fplots = 1;
                                                    end
                                                    uistack(fp,'top');
                                                case 'MU'
                                                    if fplotmu
                                                        fp = plot(xdata_d,ydata_d,'sk','markerfacecolor',[232/255 90/255 24/255],'markersize',4,'HandleVisibility','off');hold on
                                                    else
                                                        fp = plot(xdata_d,ydata_d,'sk','markerfacecolor',[232/255 90/255 24/255],'markersize',4,'displayname','MU Surface');hold on
                                                        fplotmu = 1;
                                                    end
                                                    uistack(fp,'top');
                                                otherwise
                                            end
                                        end


                                    end
                                end

                            end
                        end
                    end





                    [xdata,ydata] = tfv_averaging(data(mod).date,data(mod).pred_lim_ts(3,:),def);

                    %                 xdata = data(mod).date;
                    %                 ydata = data(mod).pred_lim_ts(3,:);
                    if plotmodel
                        plot(xdata,ydata,'color',ncfile(mod).colour{1},'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' Surface (Median)'],...
                            'linestyle',ncfile(mod).symbol{1});hold on
                    end
                    plotdate(1:length(xdata),mod) = xdata;
                    plotdata(1:length(ydata),mod) = ydata;

                    %end

                end





            end

        end

        %          if strcmpi({loadname},'WQ_OXY_OXY') == 1 & strcmpi(shp(site).Name,'Murray_Bridge') == 1
        %              plot(mon.YSI.MBO.Time,mon.YSI.MBO.ODO_Conc,'color','m','linestyle',':','displayname','YSI Monitoring Data')
        %
        %              plot(Monitoring.YSI.MBO.Time,Monitoring.YSI.MBO.ODO_Conc,'color','m','linestyle',':','displayname','YSI Monitoring Data')
        % %             plot(target.A4261156.Date,target.A4261156.Data);
        %          end
        %          if strcmpi({loadname},'WQ_OXY_OXY') == 1 & strcmpi(shp(site).Name,'TailemBend') == 1
        %              plot(Monitoring.YSI.TAILEM.Time,Monitoring.YSI.TAILEM.ODO_Conc,'color','m','linestyle',':','displayname','YSI Monitoring Data')
        % %             plot(target.A4261156.Date,target.A4261156.Data);
        %          end

        if isConv
            %ylabel([regexprep({loadname},'_',' '),' (',c_units,')'],'fontsize',6,'color',[0.4 0.4 0.4],);
            text(1.02,0.5,[regexprep(loadname,'_',' '),' (',c_units,')'],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'rotation',90,'horizontalalignment','center');
        else
            text(1.02,0.5,[regexprep(loadname,'_',' '),' (model units)'],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'rotation',90,'horizontalalignment','center');
        end


        if (depth_range(2)==max_depth)
          depdep = 'max';
        else
          depdep = [num2str(depth_range(2)),'m'];
        end
        text(0.15,1.02,[num2str(depth_range(1)),' : ',depdep],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'horizontalalignment','center');


        if add_triangle
            plot(triangle_date + 1,def.cAxis(var).value(1),'marker','v',...
                'HandleVisibility','off',...
                'markerfacecolor',[0.7 0.7 0.7],'markeredgecolor','k','markersize',3);%'color',[0.7 0.7 0.7]);
        end

%         if strcmpi({loadname},'TEMP')
%             plot([datenum(2015,01,01) datenum(2019,01,01)],[17 17],'--k');
%             plot([datenum(2015,01,01) datenum(2019,01,01)],[25 25],'--k');
%         end

        if add_coorong
        yrange = def.cAxis(var).value(2) - def.cAxis(var).value(1);
            y10 = yrange* 0.1;
            y20 = y10*2;
            y30 = y10 * 3;
            
            % Add life stage information
            [yyyy,~,~] = datevec(def.datearray);
            
            years = unique(yyyy);
            for st = 1:length(years)
                
                pt = plot([datenum(years(st),01,01) datenum(years(st),01,01)],[def.cAxis(var).value(1) def.cAxis(var).value(end)],'--k');
                set(pt,'HandleVisibility','off');
                pt = plot([datenum(years(st),09,01) datenum(years(st),09,01)],[def.cAxis(var).value(1) def.cAxis(var).value(end)],'--k');
                set(pt,'HandleVisibility','off');
                
                st1 = plot([datenum(years(st),04,01) (datenum(years(st),04,01)+120)],...
                    [(def.cAxis(var).value(2)-y10) (def.cAxis(var).value(2)-y10)],'k');
                set(st1,'HandleVisibility','off');
                
                st1 = plot([datenum(years(st),06,01) (datenum(years(st),06,01)+120)],...
                    [(def.cAxis(var).value(2)-y20) (def.cAxis(var).value(2)-y20)],'k');
                set(st1,'HandleVisibility','off');
                
                st1 = plot([datenum(years(st),08,01) (datenum(years(st),08,01)+150)],...
                    [(def.cAxis(var).value(2)-y30) (def.cAxis(var).value(2)-y30)],'k');
                set(st1,'HandleVisibility','off');
                
            end

        end

            

        xlim([def.datearray(1) def.datearray(end)]);
        if isYlim
            ylim([def.cAxis(var).value]);
        else
            def.cAxis(var).value = get(gca,'ylim');
            def.cAxis(var).value(1) = 0;
            ylim([def.cAxis(var).value]);
        end

        if ~custom_datestamp
            %disp('hi')
            set(gca,'Xtick',def.datearray,...
                'XTickLabel',datestr(def.datearray,def.dateformat),...
                'FontSize',def.xlabelsize);
        else
            new_dates = def.datearray  - zero_day;
            new_dates = new_dates - 1;

            ttt = find(new_dates >= 0);


            set(gca,'Xtick',def.datearray(ttt),...
                'XTickLabel',num2str(new_dates(ttt)'),...
                'FontSize',def.xlabelsize);
        end



        if isylabel

            %                    if isempty(units)
            %                        units = fdata.(sitenames{site}).(varname{var}).Units;
            %                    end

            ylabel(ylab,...
                'FontSize',def.ylabelsize);
        end


        %         if sum(strcmp(valid_vars,varname{var})) > 0
        %             if isylabel
        %
        %                 if isempty(units)
        %                     units = fdata.(sitenames{site}).(varname{var}).Units;
        %                 end
        %
        %                 ylabel([regexprep(fdata.(sitenames{site}).(varname{var}).Variable_Name,'_',' '),' (',...
        %                     units,')'],...
        %                     'FontSize',def.ylabelsize);
        %             end
        %         end
        if istitled
            %             if sum(strcmp(valid_vars,varname{var})) > 0
            %                 if isfield(fdata.(sitenames{site}).(varname{var}),'Title')
            title([regexprep(shp(site).Name,'_',' ')],...
                'FontSize',def.titlesize,...
                'FontWeight','bold');
            %                 end
            %             else
            %                 if isfield(fdata.(sitenames{site}).SAL,'Title')
            %                     title(fdata.(sitenames{site}).SAL.Title,...
            %                         'FontSize',def.titlesize,...
            %                         'FontWeight','bold');
            %                 end
            %             end
        end
        if exist('islegend','var')
            if islegend
                leg = legend('show');
                set(leg,'location',def.legendlocation,'fontsize',def.legendsize);
            end
        else
            leg = legend('location',def.legendlocation);
            set(leg,'fontsize',def.legendsize);
        end

        %         if strcmp(varname{var},'WQ_AED_OXYGEN_OXY') == 1
        %
        %             plot([def.datearray(1) def.datearray(end)],[2 2],...
        %                 'color',[0.4 0.4 0.4],'linestyle','--');
        %
        %             plot([def.datearray(1) def.datearray(end)],[4 4],...
        %                 'color',[0.4 0.4 0.4],'linestyle','--');
        %
        %         end

        %--% Paper Size
        set(gcf, 'PaperPositionMode', 'manual');
        set(gcf, 'PaperUnits', 'centimeters');
        xSize = def.dimensions(1);
        ySize = def.dimensions(2);
        xLeft = (21-xSize)/2;
        yTop = (30-ySize)/2;
        set(gcf,'paperposition',[0 0 xSize ySize])

        %             if isfield(fdata.(sitenames{site}).SAL,'Order')
        %                 final_sitename = [sprintf('%04d',fdata.(sitenames{site}).SAL.Order),'_',sitenames{site},'.png'];
        %             else
        %                 final_sitename = [sitenames{site},'.png'];
        %             end

        %        tVar = fieldnames(fdata.(sitenames{site}));

        %         if isfield(fdata.(sitenames{site}).(tVar{1}),'Order')
        %             final_sitename = [sprintf('%04d',fdata.(sitenames{site}).SAL.Order),'_',sitenames{site},'.eps'];
        %         else
        %
        %         end
        %final_sitename = [sprintf('%04d',shp(site).Plot_Order),'_',shp(site).Name,'.eps'];
        if isfield(shp(site),'Plot_Order')
            final_sitename = [sprintf('%04d',shp(site).Plot_Order),'_',shp(site).Name,'.eps'];
        else
            final_sitename = [shp(site).Name,'.eps'];
        end
        finalname = [savedir,'eps/',final_sitename];
        finalname_p = [savedir,final_sitename];

        if exist('filetype','var')
            if strcmpi(filetype,'png');
                %print(gcf,finalname,'-depsc2');
                print(gcf,'-dpng',regexprep(finalname_p,'.eps','.png'),'-opengl');
                %print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');
            else
                %                     print(gcf,'-depsc2',finalname,'-painters');
                %                     print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');

                %                 disp('eps');
                %print(gcf,finalname,'-depsc2');
                %disp('png');
                saveas(gcf,regexprep(finalname_p,'.eps','.png'));
            end
        else
            %                 print(gcf,'-depsc2',finalname,'-painters');
            %                 print(gcf,'-dpng',regexprep(finalname,'.eps','.png'),'-opengl');

            %             disp('eps');
            %print(gcf,finalname,'-depsc2');
            %disp('png');
            saveas(gcf,regexprep(finalname_p,'.eps','.png'));
        end

        %tfv_export_conc(regexprep(finalname,'.eps','.csv'),plotdate,plotdata,ncfile);

        close all force

        clear data

    end
end

create_html_for_directory(outputdirectory);
