%function plottfv_polygon(conf)

clear; close all;

%conf='configs/Coorong/Coorong_eWater_comparison.m';
%conf='configs/Coorong/Coorong_resuspension_check_allvars_development_20220314.m';
%conf='configs/Coorong/Coorong_resuspension_check_allvars_development_good.m';
%conf='configs/Coorong/Coorong_resuspension_check_allvars_PH_4PFTs.m';
conf='configs/Coorong/Coorong_eWater_comparison_linux_PH_GEN15.m';
%--------------------------------------------------------------------------
disp('plottfv_polygon: START')
disp('')
addpath(genpath('configs'));
addpath(genpath('../tuflowfv'));

run(conf);
warning('off','all')
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
if exist('add_vdata','var') == 0
    add_vdata = 0;
end

if exist('isHTML','var') == 0
    isHTML = 1;
end
if ~exist('htmloutput','var')
    htmloutput = outputdirectory;
end

if ~exist('add_error','var')
    add_error = 1;
end

if ~exist('add_human','var')
    add_human = 0;
end

if ~exist('fieldrange_min','var')
    fieldrange_min = 200;
end

if exist('validation_minmax','var') == 0
    validation_minmax = 0;
end

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
if ~exist('add_coorong','var')
    add_coorong = 0;
end

if ~exist('start_plot_ID','var')
    start_plot_ID = 1;
end

if ~exist('end_plot_ID','var')
    end_plot_ID = length(varname);
end

if ~exist('validation_raw','var')
    validation_raw = 0;
    
end

if validation_raw
    validation_minmax = 0;
end

if ~exist('alph','var')
    alph = 0.5;
end

if ~isfield(def,'visible')
    def.visible = 'on';
end

if ~exist('fielddata_matfile','var')
    fielddata_matfile = ['matfiles/',fielddata,'.mat'];
end

if ~exist('surface_offset','var')
    surface_offset = 0;
end



isConv = 0;

if ~exist('plotmodel','var')
    plotmodel = 1;
end
if plotmodel
    allvars = tfv_infonetcdf(ncfile(1).name);
end

shp = shaperead(polygon_file);
if ~exist('sites','var')
    sites = [1:1:1:length(shp)];
end
disp('SHP sites:')
disp(sites)

if ~exist('isFieldRange','var')
    isFieldRange = 0;
end

max_depth = 5000;
if ~exist('depth_range','var')
    depth_range = [0.5 max_depth];
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

if ~plotmodel
    add_error = 0;
end

for kk = 1:length(shp)
    shp(kk).Name = regexprep(shp(kk).Name,' ','_');
    shp(kk).Name = regexprep(shp(kk).Name,'\.','');
end


%--------------------------------------------------------------------------



%--------------------------------------------------------------------------
% Color Palette (Default)
% Checkout this link for color palette options: https://htmlcolors.com/flat-colors

surface_edge_color = [ 30  50  53]./255;
surface_face_color = [ 68 108 134]./255;
surface_line_color = [  0  96 100]./255;  %[69  90 100]./255;
col_pal            =[[176 190 197]./255;[162 190 197]./255;[150 190 197]./255];

bottom_edge_color = [33  33  33]./255;
bottom_face_color = [141 110 99]./255;
bottom_line_color = [62  39  35]./255;
col_pal_bottom    =[[215 204 200]./255; [200 204 200]./255; [185 204 200]./255 ];
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
% Load Field Data and Get site names
field = load(fielddata_matfile);
fdata = field.(fielddata); clear field;
sitenames = fieldnames(fdata);

for i = 1:length(sitenames)
    vars = fieldnames(fdata.(sitenames{i}));
    X(i) = fdata.(sitenames{i}).(vars{1}).X;
    Y(i) = fdata.(sitenames{i}).(vars{1}).Y;
end
%--------------------------------------------------------------------------

%--------------------------------------------------------------------------
if plotmodel
    for mod = 1:length(ncfile)
        disp(ncfile(mod).name);
        tdata = tfv_readnetcdf(ncfile(mod).name,'timestep',1);
        all_cells(mod).X = double(tdata.cell_X);
        all_cells(mod).Y = double(tdata.cell_Y);
        
        if isfield(ncfile(mod),'tfv')
            ttdata = tfv_readnetcdf(ncfile(mod).tfv,'names','D');
        else
            if sum(strcmpi(allvars,'D')) == 1
                ttdata = tfv_readnetcdf(ncfile(mod).name,'names','D');
            else
                tttdata = tfv_readnetcdf(ncfile(mod).name,'names',{'cell_Zb';'H'}); clear functions
                ttdata.D = tttdata.H - tttdata.cell_Zb;clear tttdata;
            end
        end
        %ttdata = tfv_readnetcdf(ncfile(mod).name,'names','D');
        
        d_data(mod).D = ttdata.D;
        ttdata_1 = tfv_readnetcdf(ncfile(mod).name,'names',{'layerface_Z';'NL'});
        d_data(mod).layerface = ttdata_1.layerface_Z;
        d_data(mod).NL = ttdata_1.NL;
        d_data(mod).rawGeo = tdata;
        
        dat = tfv_readnetcdf(ncfile(mod).name,'time',1);
        d_data(mod).tdate = dat.Time;

    end
end
if plotmodel
    allvars = tfv_infonetcdf(ncfile(1).name);
end
clear ttdata ttdata_1
%D = 0;
%--------------------------------------------------------------------------

if add_vdata
    vdataout = import_vdata(vdata);
end



%--------------------------------------------------------------------------
for var = start_plot_ID:end_plot_ID
    
    savedir = [outputdirectory,varname{var},'/'];
    mkdir(savedir);
    mkdir([savedir,'eps/']);
    loadname = varname{var};
    
    
    if plotmodel
        
        diagVar = regexp(loadname,'DIAG');
        
        for mod = 1:length(ncfile)
            disp(['Loading Model ',num2str(mod)]);
            loadname = varname{var};
            
            switch varname{var}
                
                case 'OXYPC'
                    
                    oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_AED_OXYGEN_OXY'});clear functions
                    tra = tfv_readnetcdf(ncfile(mod).name,'names',{'TRACE_1'});
                    raw(mod).data.OXYPC = tra.TRACE_1 ./ oxy.WQ_AED_OXYGEN_OXY;
                    clear tra oxy
                    
                case 'WindSpeed'
                    
                    oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});clear functions
                    raw(mod).data.WindSpeed = sqrt(power(oxy.W10_x,2) + power(oxy.W10_y,2));
                    clear  oxy
                    
                case 'WindDirection'
                    
                    oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'W10_x';'W10_y'});clear functions
                    raw(mod).data.WindDirection = (180 / pi) * atan2(-1*oxy.W10_x,-1*oxy.W10_y);
                    clear  oxy
                    
                case 'WQ_DIAG_PHY_TCHLA'
                    
                    if sum(strcmpi(allvars,'WQ_DIAG_PHY_TCHLA')) == 0
                        tchl = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN';'WQ_PHY_CRYPT';'WQ_PHY_DIATOM';'WQ_PHY_DINO';'WQ_PHY_BGA'});clear functions
                        raw(mod).data.WQ_DIAG_PHY_TCHLA = (((tchl.WQ_PHY_GRN / 50)*12) + ...
                            ((tchl.WQ_PHY_CRYPT / 50)*12) + ...
                            ((tchl.WQ_PHY_DIATOM / 26)*12) + ...
                            ((tchl.WQ_PHY_DINO / 40)*12) + ...
                            ((tchl.WQ_PHY_BGA / 40)*12));
                        clear tchl
                    else
                        raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
                    end
                    
                case 'V'
                    
                    oxy = tfv_readnetcdf(ncfile(mod).name,'names',{'V_x';'V_y'});clear functions
                    raw(mod).data.V = sqrt(power(oxy.V_x,2) + power(oxy.V_y,2));
                    clear tra oxy
                    
                case 'ON'
                    
                    %                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                    %                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                    %                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                    %                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
                    %                 raw(mod).data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);
                    DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});clear functions
                    PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});clear functions
                    raw(mod).data.ON = DON.WQ_OGM_DON + PON.WQ_OGM_PON;
                    clear DON PON
                    
                    % case 'WQ_DIAG_TOT_TN'
                    %
                    %     %                 TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});
                    %     %                 AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                    %     %                 NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                    %     %                 GRN = tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
                    %     %                 raw(mod).data.ON = TN.WQ_DIAG_TOT_TN - AMM.WQ_NIT_AMM - NIT.WQ_NIT_NIT - (GRN.WQ_PHY_GRN .* 0.15);
                    %     NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});
                    %     AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});
                    %     DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});
                    %     DONR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});
                    %     PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_PON'});
                    %     CPOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_CPOM'});
                    %     GRN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});
                    %     BGA =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_BGA'});
                    %     CRYPT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_CRYPT'});
                    %     DIATOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_DIATOM'});
                    %     DINO =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_DINO'});
                    %     raw(mod).data.WQ_DIAG_TOT_TN = DON.WQ_OGM_DON + DONR.WQ_OGM_DONR + PON.WQ_OGM_PON + NIT.WQ_NIT_NIT + AMM.WQ_NIT_AMM + ...
                    %         (CPOM.WQ_OGM_CPOM.* 0.005) + (GRN.WQ_PHY_GRN.*0.15) + (BGA.WQ_PHY_BGA.*0.15) + ...
                    %         (CRYPT.WQ_PHY_CRYPT.*0.15) + (DIATOM.WQ_PHY_DIATOM.*0.15) + (DINO.WQ_PHY_DINO.*0.15);
                    %     clear TN AMM NIT
                    
                case 'OP'
                    
                    %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                    %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                    %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                    DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});clear functions
                    PON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POP'});clear functions
                    raw(mod).data.OP = DON.WQ_OGM_DOP + PON.WQ_OGM_POP;
                    clear TP FRP
                    
                case 'TN_CHX'
                    TN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TN'});clear functions
                    CPOM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_CPOM'});clear functions
                    raw(mod).data.TN_CHX = TN.WQ_DIAG_TOT_TN - CPOM.WQ_OGM_CPOM;
                    clear TP FRP
                    
                case 'WQ_OGM_DON'
                    
                    %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                    %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                    %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                    DON =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DON'});clear functions
                    if sum(strcmpi(allvars,'WQ_OGM_DONR')) > 0
                        DONR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DONR'});clear functions
                        raw(mod).data.WQ_OGM_DON = DON.WQ_OGM_DON + DONR.WQ_OGM_DONR;
                    else
                        raw(mod).data.WQ_OGM_DON = DON.WQ_OGM_DON;% + DONR.WQ_OGM_DONR;
                    end
                    clear DON DONR
                    
                case 'WQ_OGM_DOC'
                    
                    %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                    %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                    %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                    DOC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOC'});clear functions
                    if sum(strcmpi(allvars,'WQ_OGM_DOCR')) > 0
                        DOCR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOCR'});clear functions
                        raw(mod).data.WQ_OGM_DOC = DOC.WQ_OGM_DOC + DOCR.WQ_OGM_DOCR;
                    else
                        raw(mod).data.WQ_OGM_DOC = DOC.WQ_OGM_DOC;% + DOCR.WQ_OGM_DOCR;
                    end
                    clear DOC DOCR
                    
                case 'WQ_OGM_DOP'
                    
                    %                 TP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_DIAG_TOT_TP'});
                    %                 FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});
                    %                 raw(mod).data.OP = TP.WQ_DIAG_TOT_TP - FRP.WQ_PHS_FRP;
                    DOP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOP'});clear functions
                    if sum(strcmpi(allvars,'WQ_OGM_DOPR')) > 0
                        DOPR =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_DOPR'});clear functions
                        raw(mod).data.WQ_OGM_DOP = DOP.WQ_OGM_DOP + DOPR.WQ_OGM_DOPR;
                    else
                        raw(mod).data.WQ_OGM_DOP = DOP.WQ_OGM_DOP;% + DOPR.WQ_OGM_DOPR;
                    end
                    clear DOP DOPR
                    
                case 'TURB'
                    
                    SS1 =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NCS_SS1'});clear functions
                    POC =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_OGM_POC'});clear functions
                    GRN =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHY_GRN'});clear functions
                    raw(mod).data.TURB = (SS1.WQ_NCS_SS1 .* 2.356)  + (GRN.WQ_PHY_GRN .* 0.1) + (POC.WQ_OGM_POC / 83.333333 .* 0.1);
                    clear SS1 POC GRN
                    
                    sites = fieldnames(fdata);
                    for bdb = 1:length(sites)
                        if isfield(fdata.(sites{bdb}),'WQ_DIAG_TOT_TURBIDITY')
                            fdata.(sites{bdb}).TURB = fdata.(sites{bdb}).WQ_DIAG_TOT_TURBIDITY;
                        end
                    end
                    
                case 'ECOLI'
                    
                    ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});clear functions
                    ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});clear functions
                    raw(mod).data.ECOLI = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) ;
                    clear ECOLI_F ECOLI_A
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI = fdata.(thesites{bdb}).ECLOI;
                        end
                    end
                    
                case 'ECOLI_TOTAL'
                    
                    ECOLI_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_F'});clear functions
                    ECOLI_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_A'});clear functions
                    ECOLI_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ECOLI_D'});clear functions
                    raw(mod).data.ECOLI_TOTAL = (ECOLI_F.WQ_PAT_ECOLI_F)  +  (ECOLI_A.WQ_PAT_ECOLI_A) + (ECOLI_D.WQ_PAT_ECOLI_D) ;
                    clear ECOLI_F ECOLI_A ECOLI_D
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_TOTAL = fdata.(thesites{bdb}).ECLOI;
                        end
                    end
                    
                case 'ECOLI_PASSIVE'
                    
                    ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR1'});clear functions
                    raw(mod).data.ECOLI_PASSIVE = (ECOLI_P.WQ_TRC_TR1) ;
                    clear ECOLI_P
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_PASSIVE = fdata.(thesites{bdb}).ECLOI;
                        end
                    end
                    
                case 'ECOLI_SIMPLE'
                    
                    ECOLI_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});clear functions
                    raw(mod).data.ECOLI_SIMPLE = (ECOLI_P.WQ_TRC_TR2) ;
                    clear ECOLI_P
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ECLOI')
                            fdata.(thesites{bdb}).ECOLI_SIMPLE = fdata.(thesites{bdb}).ECLOI;
                        end
                    end
                    
                case 'ENTEROCOCCI'
                    
                    ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});clear functions
                    ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});clear functions
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
                    
                    ENT_F =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_F'});clear functions
                    ENT_A =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_A'});clear functions
                    ENT_D =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PAT_ENTEROCOCCI_D'});clear functions
                    raw(mod).data.ENTEROCOCCI_TOTAL = (ENT_F.WQ_PAT_ENTEROCOCCI_F)  +  (ENT_A.WQ_PAT_ENTEROCOCCI_A) + (ENT_D.WQ_PAT_ENTEROCOCCI_D) ;
                    clear ENT_F ENT_A ENT_D
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_TOTAL = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'ENTEROCOCCI_PASSIVE'
                    
                    ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR2'});clear functions
                    raw(mod).data.ENTEROCOCCI_PASSIVE = (ENT_P.WQ_TRC_TR2) ;
                    clear ENT_P
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_PASSIVE = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'ENTEROCOCCI_SIMPLE'
                    
                    ENT_P =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_TRC_TR4'});clear functions
                    raw(mod).data.ENTEROCOCCI_SIMPLE = (ENT_P.WQ_TRC_TR4) ;
                    clear ENT_P
                    
                    thesites = fieldnames(fdata);
                    for bdb = 1:length(thesites)
                        if isfield(fdata.(thesites{bdb}),'ENT')
                            fdata.(thesites{bdb}).ENTEROCOCCI_SIMPLE = fdata.(thesites{bdb}).ENT;
                        end
                    end
                    
                case 'HSI_CYANO'
                    TEM =  tfv_readnetcdf(ncfile(mod).name,'names',{'TEMP'});clear functions
                    SAL =  tfv_readnetcdf(ncfile(mod).name,'names',{'SAL'});clear functions
                    NIT =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_NIT'});clear functions
                    AMM =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_NIT_AMM'});clear functions
                    FRP =  tfv_readnetcdf(ncfile(mod).name,'names',{'WQ_PHS_FRP'});clear functions
                    DEP =  tfv_readnetcdf(ncfile(mod).name,'names',{'D'});clear functions
                    V_x =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_x'});clear functions
                    V_y =  tfv_readnetcdf(ncfile(mod).name,'names',{'V_y'});clear functions
                    
                    %------ temperature
                    %The numbers I've used for Darwin Reservoir cyanobacteria are:
                    %Theta_growth (v) = 1.08;
                    %T_std = 28; %T_opt = 34; %T_max = 40;
                    k =  4.1102;
                    a = 35.0623;
                    b =  0.1071;
                    v =  1.0800;
                    fT = v.^(TEM.TEMP-20)-v.^(k.*(TEM.TEMP-a))+b;
                    
                    %------ nitrogen
                    KN = 4;                %   in mmol/m3
                    fN = (NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM) ./ (KN+(NIT.WQ_NIT_NIT+AMM.WQ_NIT_AMM));
                    
                    %------ phosphorus
                    KP = 0.15;    % in mmol/m3
                    fP = FRP.WQ_PHS_FRP./(KP+FRP.WQ_PHS_FRP);
                    
                    %------ salinity
                    KS = 5;                %   in PSU
                    fS = KS ./ (KS+(SAL.SAL));
                    fS(SAL.SAL<KS/2.)=1;
                    
                    %------ stratification/velocity
                    KV = 0.5;
                    V = (V_x.V_x.*V_x.V_x + V_y.V_y.*V_y.V_y).^0.5; %   in m/s
                    fV = KV ./ (KV+V);
                    fV(V<0.05)=0.;
                    
                    raw(mod).data.HSI_CYANO = ( fT .* min(fN,fP) .* fS .* fV);
                    raw(mod).data.HSI_CYANO(raw(mod).data.HSI_CYANO<0.5) = 0;
                    
                    clear fT;
                    
                otherwise
                    
                    raw(mod).data = tfv_readnetcdf(ncfile(mod).name,'names',{loadname});clear functions
                    
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
    end
    
    
    c_units = [];
    for site = sites %1:length(shp)
        
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
        
        figure('visible',def.visible);
        
        for mod = 1:length(ncfile)
            if plotmodel
                tic
                [data(mod),c_units,isConv] = tfv_getmodeldatapolygon_quick(raw(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp(site).X,shp(site).Y,{loadname},d_data(mod).D,depth_range,d_data(mod).layerface,d_data(mod).NL,surface_offset,0,d_data(mod).rawGeo,d_data(mod).tdate);clear functions
                toc
                % tic
                %[data(mod),c_units,isConv] = tfv_getmodeldatapolygon(raw(mod).data,ncfile(mod).name,all_cells(mod).X,all_cells(mod).Y,shp(site).X,shp(site).Y,{loadname},d_data(mod).D,depth_range);
                %toc
                %save data.mat data -mat
                %save data1.mat data1 -mat;
                
            end
            
			xdata_dt = [];
            ydata_dt = [];
            incc=1;					
            for lev = 1:length(plotdepth)
                
                if strcmpi(plotdepth{lev},'bottom') == 1
                    if plotmodel
                        if isfield(data,'date')
                            if mod == 1 | Range_ALL == 1
                                %
                                
                                if isRange_Bottom
                                    fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc,col_pal_bottom(1,:));hold on
                                    %fig = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(1,:),data(mod).pred_lim_ts_b(2*nn-1,:),dimc);hold on
                                    set(fig,'DisplayName',[ncfile(mod).legend,' (Botm Range)']);
                                    set(fig,'FaceAlpha', alph);
                                    hold on
                                    
                                    for plim_i=2:(nn-1)
                                        fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal_bottom(plim_i,:));
                                        %fig2 = fillyy(data(mod).date_b,data(mod).pred_lim_ts_b(plim_i,:),data(mod).pred_lim_ts_b(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1));
                                        set(fig2,'HandleVisibility','off');
                                        set(fig2,'FaceAlpha', alph);
                                    end
                                    uistack(fig, 'bottom');
                                    uistack(fig2,'bottom');
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
                            agencyused2 = [];
                            site_string = ['     field: '];
		                    xdata_dt=[];
                            ydata_dt=[];
                            for j = 1:length(sss)
                                if isfield(fdata.(sitenames{sss(j)}),varname{var})
                                    
                                    
                                    xdata_t = [];
                                    ydata_t = [];
                                    
                                    if ~validation_raw
                                        
                                        [xdata_ta,ydata_ta,ydata_max_ta,ydata_min_ta] = get_field_at_depth(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,...
                                            fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});
                                        
                                    else
                                        [xdata_ta,ydata_ta,ydata_max_ta,ydata_min_ta] = get_field_at_depth_raw(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,...
                                            fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});
                                    end
                                    
                                    gfg = find(xdata_ta >= def.datearray(1) & xdata_ta <= def.datearray(end));
                                    
                                    if ~isempty(gfg)
                                        xdata_t = xdata_ta(gfg);
                                        ydata_t = ydata_ta(gfg);
                                        if ~validation_raw
                                            ydata_max_t = ydata_max_ta(gfg);
                                            ydata_min_t = ydata_min_ta(gfg);
                                        else
                                            ydata_max_t = [];
                                            ydata_min_t = [];
                                        end
                                    end
                                    
                                    if ~isempty(xdata_t)
                                        
                                        
                                        if ~validation_raw
                                            [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);
                                            [~,ydata_max_d] = process_daily(xdata_t,ydata_max_t);
                                            [~,ydata_min_d] = process_daily(xdata_t,ydata_min_t);
                                        else
                                            xdata_d =  xdata_t;
                                            ydata_d = ydata_t;
                                            ydata_max_d = [];
                                            ydata_min_d = [];
                                        end
                                        
										
										
										
                                        [ydata_d,c_units,isConv] = tfv_Unit_Conversion(ydata_d,varname{var});
                                        [ydata_max_d,~,~] = tfv_Unit_Conversion(ydata_max_d,varname{var});
                                        [ydata_min_d,~,~] = tfv_Unit_Conversion(ydata_min_d,varname{var});
                                        
                                        ydata_dt=[ydata_dt ydata_d];


										
                                        if isfield(fdata.(sitenames{sss(j)}).(varname{var}),'Agency')
                                            if strcmp(fdata.(sitenames{sss(j)}).(varname{var}).Agency,'ALS')==1
                                                agency='DEW ALS';
                                            elseif strcmp(fdata.(sitenames{sss(j)}).(varname{var}).Agency,'AWQC (DEW)')==1
                                                agency='DEW AWQC';
                                            else
                                            agency = fdata.(sitenames{sss(j)}).(varname{var}).Agency;
                                            end
                                        else
                                            agency = 'DEW';
                                        end
                                        
                                        site_string = [site_string,' ',sitenames{sss(j)},'(',agency,'),'];
                                        
                                        %                     if strcmpi(agency,'DEWNR')
                                        [mface,mcolor,agencyname] = sort_agency_information_Coorong(agency);
                                        agencyused2 = [agencyused2;{agencyname}];
                                        if plotvalidation
                                            fgf = sum(strcmpi(agencyused2,agencyname));
                                            
                                            if fgf > 1
                                                fp = plot(xdata_d,ydata_d,mface,...
                                                    'markeredgecolor',bottom_edge_color,'markerfacecolor',mcolor,'markersize',3,'HandleVisibility','off');hold on
                                                uistack(fp,'top');
                                                
                                                if validation_minmax
                                                    fp = plot(xdata_d,ydata_max_d,'r+',...
                                                        'HandleVisibility','off');hold on
                                                    fp = plot(xdata_d,ydata_min_d,'r+',...
                                                        'HandleVisibility','off');hold on
                                                end
                                                uistack(fp,'top');
                                                
                                            else
                                                fp = plot(xdata_d,ydata_d,mface,...
                                                    'markeredgecolor',bottom_edge_color,'markerfacecolor',mcolor,'markersize',3,'displayname',[agency, ' Bot']);hold on
                                                if validation_minmax
                                                    fp = plot(xdata_d,ydata_max_d,'r+',...
                                                        'HandleVisibility','off');hold on
                                                    fp = plot(xdata_d,ydata_min_d,'r+',...
                                                        'HandleVisibility','off');hold on
                                                end
                                                uistack(fp,'top');
                                            end
                                            
                                            if isYlim
                                                if ~isempty(def.cAxis(var).value)
                                                    ggg = find(ydata_d > def.cAxis(var).value(2));
                                                    
                                                    if ~isempty(ggg)
                                                        agencyused2 = [agencyused2;{'Outside Range'}];
                                                        fgf = sum(strcmpi(agencyused2,'Outside Range'));
                                                        rdata = [];
                                                        rdata(1:length(ggg),1) = def.cAxis(var).value(2);
                                                        
                                                        hhh = find(ydata_d(ggg) >= def.datearray(1) & ...
                                                            ydata_d(ggg) <= def.datearray(end));
                                                        
                                                        if ~isempty(hhh)
                                                            if fgf > 1
                                                                fp = plot(xdata_d(ggg),rdata,'k+',...
                                                                    'markersize',4,'linewidth',1,'HandleVisibility','off');hold on
                                                                uistack(fp,'top');
                                                                
                                                            else
                                                                fp = plot(xdata_d(ggg),rdata,'k+',...
                                                                    'markersize',4,'linewidth',1,'displayname','Outside Range');hold on
                                                                uistack(fp,'top');
                                                            end
                                                        end
                                                    end
                                                end
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
                    
                    
                    
                    
                    if plotmodel
                        [xdata,ydata] = tfv_averaging(data(mod).date_b,data(mod).pred_lim_ts_b(3,:),def);
                        if diagVar>0 % removes inital zero value (eg in diganostics)
                            xdata(1:2) = NaN;
                        end
                    end
                    %                 xdata = data(mod).date;
                    %                 ydata = data(mod).pred_lim_ts(3,:);
                    if plotmodel
                        plot(xdata,ydata,'color',ncfile(mod).colour{lev},'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' (Botm Median)'],...
                            'linestyle',ncfile(mod).symbol{1});hold on
                        plotdate(1:length(xdata),mod) = xdata;
                        plotdata(1:length(ydata),mod) = ydata;
                    end
                    
                    
                    
                    if add_error
                        MatchedData_bottom=[];
                        if exist('xdata_d','var') && ~isempty(xdata_dt)
                            % [v, loc_obs, loc_sim] = intersect(floor(xdata_t*10)/10, floor(xdata*10)/10);
                            % MatchedData_obs_surf=ydata_t(loc_obs);
                            % MatchedData_sim_surf=ydata(loc_sim);
                            
                            disp('find field data ...');
                            alldayso=floor(xdata_dt);
                            unidayso=unique(alldayso);
                            obsData(:,1)=unidayso;
                            
                            for uuo=1:length(unidayso)
                                tmpinds=find(alldayso==unidayso(uuo));
                                tmpydatatt=ydata_dt(tmpinds);
                                obsData(uuo,2)=mean(tmpydatatt(~isnan(tmpydatatt)));
                                clear tmpydatatt;
                            end
                            
                            alldays=floor(xdata);
                            unidays=unique(alldays);
                            simData(:,1)=unidays;
                            
                            for uu=1:length(unidays)
                                tmpinds=find(alldays==unidays(uu));
                                simData(uu,2)=mean(ydata(tmpinds));
                            end
                            
                            [v, loc_obs, loc_sim] = intersect(obsData(:,1), simData(:,1));
                            MatchedData_bottom = [v obsData(loc_obs,2) simData(loc_sim,2)];
                            clear simData obsData v loc* alldays unidays
                            clear xdata_dt ydata_dt xdata_d ydata_d
                        end
                        
                    end
                    
                else
                    if plotmodel
                        if isfield(data,'date')
                            if mod == 1 | Range_ALL == 1
                                
                                if isRange
                                    %
                                    fig = fillyy(data(mod).date,data(mod).pred_lim_ts(1,:),data(mod).pred_lim_ts(2*nn-1,:),dimc,col_pal(mod,:));hold on
                                    set(fig,'DisplayName',[ncfile(mod).legend,' (Range)']); %Surf
                                    set(fig,'FaceAlpha', alph);
                                    hold on
                                    
                                    for plim_i=2:(nn-1)
                                        fig2 = fillyy(data(mod).date,data(mod).pred_lim_ts(plim_i,:),data(mod).pred_lim_ts(2*nn-plim_i,:),dimc.*0.9.^(plim_i-1),col_pal(plim_i,:));
                                        set(fig2,'HandleVisibility','off');
                                        set(fig2,'FaceAlpha', alph);
                                        
                                    end
                                    uistack(fig,'bottom');
                                    uistack(fig2,'bottom');
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
                            site_string = ['     field: '];
                            agencyused = [];
                            for j = 1:length(sss)
                                if isfield(fdata.(sitenames{sss(j)}),varname{var})
                                    xdata_t = [];
                                    ydata_t = [];
                                    
                                    if ~validation_raw
                                        
                                        [xdata_ta,ydata_ta,ydata_max_ta,ydata_min_ta] = get_field_at_depth(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,...
                                            fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});
                                        
                                    else
                                        [xdata_ta,ydata_ta,ydata_max_ta,ydata_min_ta] = get_field_at_depth_raw(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,...
                                            fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});
                                    end
                                    
                                    %                                     [xdata_ta,ydata_ta,ydata_max_ta,ydata_min_ta] = get_field_at_depth(fdata.(sitenames{sss(j)}).(varname{var}).Date,fdata.(sitenames{sss(j)}).(varname{var}).Data,fdata.(sitenames{sss(j)}).(varname{var}).Depth,plotdepth{lev});
                                    
                                    
                                    
                                    gfg = find(xdata_ta >= def.datearray(1) & xdata_ta <= def.datearray(end));
                                    
                                    if ~isempty(gfg)
                                        
                                        xdata_t = xdata_ta(gfg);
                                        ydata_t = ydata_ta(gfg);
                                        if ~validation_raw
                                            ydata_max_t = ydata_max_ta(gfg);
                                            ydata_min_t = ydata_min_ta(gfg);
                                        else
                                            ydata_max_t = [];
                                            ydata_min_t = [];
                                        end
                                    end
                                    
                                    
                                    if ~isempty(xdata_t)
                                        
                                        
                                        if ~validation_raw
                                            [xdata_d,ydata_d] = process_daily(xdata_t,ydata_t);
                                            [~,ydata_max_d] = process_daily(xdata_t,ydata_max_t);
                                            [~,ydata_min_d] = process_daily(xdata_t,ydata_min_t);
                                        else
                                            xdata_d =  xdata_t;
                                            ydata_d = ydata_t;
                                            ydata_max_d = [];
                                            ydata_min_d = [];
                                        end
                                        
                                        
                                        [ydata_d,c_units,isConv] = tfv_Unit_Conversion(ydata_d,varname{var});
                                        [ydata_max_d,~,~] = tfv_Unit_Conversion(ydata_max_d,varname{var});
                                        [ydata_min_d,~,~] = tfv_Unit_Conversion(ydata_min_d,varname{var});

										xdata_dt=[xdata_dt xdata_d'];
                                        ydata_dt=[ydata_dt ydata_d];
										
										
										
                                        if isfield(fdata.(sitenames{sss(j)}).(varname{var}),'Agency')
                                            if strcmp(fdata.(sitenames{sss(j)}).(varname{var}).Agency,'ALS')==1
                                                agency='DEW ALS';
                                            elseif strcmp(fdata.(sitenames{sss(j)}).(varname{var}).Agency,'AWQC (DEW)')==1
                                                agency='DEW AWQC';
                                            else
                                            agency = fdata.(sitenames{sss(j)}).(varname{var}).Agency;
                                            end
                                        else
                                            agency = 'DEW';
                                        end
                                        site_string = [site_string,' ',sitenames{sss(j)},'(',agency,'),'];
                                        %                     if strcmpi(agency,'DEWNR')
                                        [mface,mcolor,agencyname] = sort_agency_information_Coorong(agency);
                                        agencyused = [agencyused;{agencyname}];
                                        
                                        if plotvalidation
                                            fgf = sum(strcmpi(agencyused,agencyname));
                                            
                                            if fgf > 1
                                                %fp = plot(xdata_d,ydata_d,mface,'markerfacecolor',mcolor ,'markersize',3,'HandleVisibility','off');hold on
                                                fp = plot(xdata_d,ydata_d,mface,'markeredgecolor',surface_edge_color,'markerfacecolor',mcolor,'markersize',3,'HandleVisibility','off');hold on
                                                uistack(fp,'top');
                                                if validation_minmax
                                                    
                                                    fp = plot(xdata_d,ydata_max_d,'+','color',[0.6 0.6 0.6],...
                                                        'HandleVisibility','off');hold on
                                                    fp = plot(xdata_d,ydata_min_d,'+','color',[0.6 0.6 0.6],...
                                                        'HandleVisibility','off');hold on
                                                end
                                                uistack(fp,'top');
                                            else
                                                fp = plot(xdata_d,ydata_d,mface,'markeredgecolor',surface_edge_color,'markerfacecolor',mcolor,'markersize',3,'displayname',[agency]);hold on; %,' Surf'
                                                uistack(fp,'top');
                                                if validation_minmax
                                                    
                                                    fp = plot(xdata_d,ydata_max_d,'+','color',[0.6 0.6 0.6],...
                                                        'HandleVisibility','off');hold on
                                                    fp = plot(xdata_d,ydata_min_d,'+','color',[0.6 0.6 0.6],...
                                                        'HandleVisibility','off');hold on
                                                end
                                                uistack(fp,'top');
                                            end
                                            
                                            if isYlim
                                                
                                                if ~isempty(def.cAxis(var).value)
                                                    
                                                    ggg = find(ydata_d > def.cAxis(var).value(2));
                                                    
                                                    if ~isempty(ggg)
                                                        agencyused = [agencyused;{'Outside Range'}];
                                                        fgf = sum(strcmpi(agencyused,'Outside Range'));
                                                        rdata = [];
                                                        rdata(1:length(ggg),1) = def.cAxis(var).value(2);
                                                        hhh = find(xdata_d(ggg) >= def.datearray(1) & ...
                                                            xdata_d(ggg) <= def.datearray(end));
                                                        
                                                        if ~isempty(hhh)
                                                            if fgf > 1
                                                                
                                                                fp = plot(xdata_d(ggg),rdata,'k+',...
                                                                    'markersize',4,'linewidth',1,'HandleVisibility','off');hold on
                                                                uistack(fp,'top');
                                                                
                                                            else
                                                                
                                                                fp = plot(xdata_d(ggg),rdata,'k+',...
                                                                    'markersize',4,'linewidth',1,'displayname','Outside Range');hold on
                                                                uistack(fp,'top');
                                                            end
                                                            uistack(fp,'top');
                                                            
                                                        end
                                                    end
                                                end
                                            end
                                            %
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
                    
                    
                    
                    if plotmodel
                        [xdata,ydata] = tfv_averaging(data(mod).date,data(mod).pred_lim_ts(3,:),def);
                        if diagVar>0 % removes inital zero value (eg in diganostics)
                            xdata(1:2) = NaN;
                        end
                    end
                    %                 xdata = data(mod).date;
                    %                 ydata = data(mod).pred_lim_ts(3,:);
                    if plotmodel
                        mod
                        plot(xdata,ydata,'color',ncfile(mod).colour{1},'linewidth',0.5,'DisplayName',[ncfile(mod).legend,' (Median)'],...
                            'linestyle',ncfile(mod).symbol{1});hold on
                        plotdate(1:length(xdata),mod) = xdata;
                        plotdata(1:length(ydata),mod) = ydata;
                    end
                    if add_error
                        MatchedData_surf=[];
                        if (exist('xdata_dt','var') && ~isempty(xdata_dt))
                            % [v, loc_obs, loc_sim] = intersect(floor(xdata_t*10)/10, floor(xdata*10)/10);
                            % MatchedData_obs_surf=ydata_t(loc_obs);
                            % MatchedData_sim_surf=ydata(loc_sim);
                            
                            disp('find field data ...');
                            alldayso=floor(xdata_dt);
                            unidayso=unique(alldayso);
                            obsData(:,1)=unidayso;
                            
                            for uuo=1:length(unidayso)
                                tmpinds=find(alldayso==unidayso(uuo));
                                tmpydatatt=ydata_dt(tmpinds);
                                obsData(uuo,2)=mean(tmpydatatt(~isnan(tmpydatatt)));
                                clear tmpydatatt;
                            end
                            
                            alldays=floor(xdata);
                            unidays=unique(alldays);
                            simData(:,1)=unidays;
                            
                            for uu=1:length(unidays)
                                tmpinds=find(alldays==unidays(uu));
                                simData(uu,2)=mean(ydata(tmpinds));
                            end
                            
                            [v, loc_obs, loc_sim] = intersect(obsData(:,1), simData(:,1));
                            MatchedData_surf = [v obsData(loc_obs,2) simData(loc_sim,2)];
                            clear simData obsData v loc* alldays unidays
                            clear xdata_d ydata_d xdata_dt ydata_dt
                        end
                    end
                    
                    %end
                    
                end
                
                
                
                
                
            end
            
        end
        
        
        % Optional code to add long-term montly observed data percentile
        % bands ontoplots
        if isFieldRange
            shp(site).Name
            outdata = calc_data_ranges(fdata,shp(site).X,shp(site).Y,fieldprctile,varname{var});
            
            if sum(~isnan(outdata.low)) > fieldrange_min
                
                plot(outdata.Date,outdata.low, 'color',surface_edge_color,'linestyle',':','displayname',['Obs \itP_{',num2str(fieldprctile(1)),'}']);hold on
                plot(outdata.Date,outdata.high,'color',surface_edge_color,'linestyle',':','displayname',['Obs \itP_{',num2str(fieldprctile(2)),'}']);hold on
                
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
        
        grid on;
        
        if isConv
            if isylabel
                if add_human
                    ylabel([regexprep(loadname_human,'_',' '),' (',c_units,')'],'fontsize',8,'color',[0.0 0.0 0.0],'horizontalalignment','center');
                else
                    ylabel([regexprep(loadname,'_',' '),' (',c_units,')'],'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
                end
            end
            % BB TURN ONtext(1.02,0.5,[regexprep(loadname,'_',' '),' (',c_units,')'],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'rotation',90,'horizontalalignment','center');
        else
            if isylabel
                if add_human
                    ylabel([regexprep(loadname_human,'_',' '),' (model units)'],'fontsize',8,'color',[0.0 0.0 0.0],'horizontalalignment','center');
                else
                    
                    ylabel([regexprep(loadname,'_',' '),' '],'fontsize',6,'color',[0.4 0.4 0.4],'horizontalalignment','center');
                end
            end
            % BB TURN ONtext(1.02,0.5,[regexprep(loadname,'_',' '),' (model units)'],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'rotation',90,'horizontalalignment','center');
        end
        
        
        if (depth_range(2)==max_depth)
            depdep = 'max';
        else
            depdep = [num2str(depth_range(2)),'m'];
        end
        % BB TURN ONtext(0.92,1.02,[num2str(depth_range(1)),' : ',depdep],'units','normalized','fontsize',5,'color',[0.4 0.4 0.4],'horizontalalignment','center');
        
        
        if add_triangle
            plot(triangle_date + 1,def.cAxis(var).value(1),'marker','v',...
                'HandleVisibility','off',...
                'markerfacecolor',[0.7 0.7 0.7],'markeredgecolor','k','markersize',3);%'color',[0.7 0.7 0.7]);
        end
        
        
        if add_vdata
            
            for vd = 1:length(vdataout)
                
                %varname{var}
                %site
                if vdataout(vd).polygon == site & ...
                        isfield(vdataout(vd).Data,varname{var})
                    
                    [vd_data,~,~] = tfv_Unit_Conversion(vdataout(vd).Data.(varname{var}).vdata,varname{var});
                    
                    plot(vdataout(vd).Data.(varname{var}).Date,vd_data,...
                        vdataout(vd).plotcolor,'displayname',vdataout(vd).legend);
                end
            end
        end
                
            
            
        
        
        
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
        
        %         if strcmpi({loadname},'TEMP')
        %             plot([datenum(2015,01,01) datenum(2019,01,01)],[17 17],'--k');
        %             plot([datenum(2015,01,01) datenum(2019,01,01)],[25 25],'--k');
        %         end
        
        %xlim([def.datearray(1) def.datearray(end)]);
        xlim([datenum(2019,11,1) def.datearray(end)]);
        if isYlim
            if ~isempty(def.cAxis(var).value)
                ylim([def.cAxis(var).value]);
            end
        else
            def.cAxis(var).value = get(gca,'ylim');
            def.cAxis(var).value(1) = 0;
            %    ylim([def.cAxis(var).value]);
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
        
        
        
        %         if isylabel
        %
        %             %                    if isempty(units)
        %             %                        units = fdata.(sitenames{site}).(varname{var}).Units;
        %             %                    end
        %
        %             ylabel(ylab,...
        %                 'FontSize',def.ylabelsize);
        %         end
        
        
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
        %% adding error output
        if add_error
            MatchedData_obs=[];
            MatchedData_sim=[];
            
            if (exist('MatchedData_surf','var') && ~isempty(MatchedData_surf))
                MatchedData_obs=[MatchedData_obs, MatchedData_surf(:,2)];
                MatchedData_sim=[MatchedData_sim, MatchedData_surf(:,3)];
            end
            if (exist('MatchedData_bottom','var') && ~isempty(MatchedData_bottom))
                MatchedData_obs=[MatchedData_obs', MatchedData_bottom(:,2)'];
                MatchedData_sim=[MatchedData_sim', MatchedData_bottom(:,3)'];
            end
            clear MatchedData_surf MatchedData_bottom
            
            if length(MatchedData_obs)>10
                
                if size(MatchedData_obs,2)>1
                    [stat_mae,stat_r,stat_rms,stat_nash,stat_nmae,stat_nrms]=do_error_calculation_2layers(MatchedData_obs',MatchedData_sim');
                else
                    [stat_mae,stat_r,stat_rms,stat_nash,stat_nmae,stat_nrms]=do_error_calculation_2layers(MatchedData_obs,MatchedData_sim);
                end
                
                devia=(mean(MatchedData_sim)-mean(MatchedData_obs))/mean(MatchedData_obs);
                
                if abs(devia)>10
                    deviaS='Out of range';
                    deviaSn=NaN;
                else
                    deviaS=[num2str(devia*100,'%3.2f'),'%'];
                    deviaSn=devia*100;
                end
                str{1}=['R = ',num2str(stat_r,'%1.4f')];
                str{2}=['BIAS = ',deviaS];
                % str{3}=['NMAE = ',num2str(stat_nmae,'%1.4f')];
                % str{4}=['NRMS = ',num2str(stat_nrms,'%1.4f')];
                str{3}=['MAE = ',num2str(stat_mae,'%3.2f'),' (', num2str(stat_nmae*100,'%3.2f'),'%)'];
                str{4}=['RMS = ',num2str(stat_rms,'%3.2f'),' (', num2str(stat_nrms*100,'%3.2f'),'%)'];
                if exist('isSaveErr','var') && isMEF
                    str{5}=['nash = ',num2str(stat_nash,'%1.4f')];
                end
                hlp=get(leg,'Position');
                dim=[hlp(1) 0.1 0.15 0.3];
                ha=annotation('textbox',dim,'String',str,'FitBoxToText','on');
                set(ha,'FontSize',5);
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).R=stat_r;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).BIAS=deviaSn;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).MAE=stat_mae;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).RMS=stat_rms;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).NMAE=stat_nmae;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).NRMS=stat_nrms;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).MEF=stat_nash;
                clear str stat*;
            else
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).R=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).BIAS=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).MAE=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).RMS=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).NMAE=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).NRMS=NaN;
                errorMatrix.(regexprep(shp(site).Name,' ','_')).(loadname).MEF=NaN;
            end
            
        end
        %  clear obsData simData v loc_obs loc_sim xdata_tt ydata_tt MatchedData*;
        
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
        
    if add_error && ~exist('isSaveErr','var') 
        clear errorMatrix
    end
    end
    
    if isHTML
        
        create_html_for_directory_onFly(savedir,varname{var},htmloutput);
        
    end
end
%--------------------------------------------------------------------------


%--------------------------------------------------------------------------
if isHTML
    create_html_for_directory(outputdirectory,htmloutput);
end

disp('')
disp('plottfv_polygon: DONE')
%--------------------------------------------------------------------------
if add_error
    if exist('isSaveErr','var') && isSaveErr
        save(ErrFilename,'errorMatrix','-mat');
    end
end