
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm_noALS.mat';
%fielddata = 'UA';
fielddata = 'cllmm';
polygon_file = '../../../CDM/gis/supplementary/Coorong/Coorong_obs_sites.shp';
%polygon_file = '../../../CDM/gis/supplementary/Coorong_IC_regions.shp';
%polygon_file = './GDSTN_Polygons_200m_v2_C3.shp';

%sites = [17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration

% NCS_ss1
% TRC_age
% OXY_oxy
% SIL_rsi
% NIT_amm
% NIT_nit
% PHS_frp
% PHS_frp_ads
% OGM_doc
% OGM_poc
% OGM_don
% OGM_pon
% OGM_dop
% OGM_pop
% PHY_grn


% VAR Configuration________________________________________________________
varname = {...
    'H',...
 'SAL',...
 'TEMP',...
 'WQ_NCS_SS1',...
 'WQ_SIL_RSI',...
 'WQ_DIAG_HAB_RUPPIA_HSI',...
 'WQ_DIAG_TOT_TN',...
 'WQ_DIAG_TOT_TP',...
 'WQ_DIAG_PHY_TCHLA',...
     'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_DIAG_TOT_TP',...
    'WQ_PHS_FRP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'WQ_PHY_GRN',...
    'WQ_OGM_POP',...
    'WQ_OGM_DOP',...
    'WQ_OGM_PON',...
    'WQ_OGM_DON',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
%     'WQ_DIAG_MA2_TMALG',...
%     'WQ_MA2_ULVA',...
%     'WQ_DIAG_MA2_MAG_BEN',...
%     'WQ_DIAG_MA2_ULVA_FI',...
%     'WQ_DIAG_MA2_ULVA_FNIT',...
%     'WQ_DIAG_MA2_ULVA_FPHO',...
%     'WQ_DIAG_MA2_ULVA_FT',...
%     'WQ_DIAG_MA2_ULVA_FSAL',...
%     'WQ_DIAG_MA2_ULVA_FI_BEN',...
%     'WQ_DIAG_MA2_ULVA_FNIT_BEN',...
%     'WQ_DIAG_MA2_ULVA_FPHO_BEN',...
%     'WQ_DIAG_MA2_ULVA_FT_BEN',...
%     'WQ_DIAG_MA2_ULVA_FSAL_BEN',...
%     'WQ_DIAG_MA2_IN',...
%     'WQ_DIAG_MA2_IP',...
%     'WQ_DIAG_MA2_IN_BEN',...
%     'WQ_DIAG_MA2_IP_BEN',...
%     'WQ_DIAG_MA2_GPP',...
%     'WQ_DIAG_MA2_PUP',...
%     'WQ_DIAG_MA2_NUP',...
%     'WQ_DIAG_MA2_NMP',...
%     'WQ_DIAG_MA2_GPP_BEN',...
%     'WQ_DIAG_MA2_NMP_BEN',...
%     'WQ_DIAG_MA2_HSI',...
%     'WQ_DIAG_MA2_EXTC',...
%     'WQ_DIAG_MA2_PARC',...
%     'WQ_DIAG_MA2_HGTC',...
%     'WQ_DIAG_MA2_ULVA_C2P',...
%     'WQ_DIAG_MA2_ULVA_C2N',...
%     'WQ_DIAG_MA2_ULVA_N2P',...
%     'WQ_DIAG_MA2_ULVA_C2P_BEN',...
%     'WQ_DIAG_MA2_ULVA_C2N_BEN',...
%     'WQ_DIAG_MA2_ULVA_N2P_BEN',...
%     'WQ_DIAG_MA2_RSP_BEN',...
%     'WQ_DIAG_MA2_PUP_BEN',...
%     'WQ_DIAG_MA2_NUP_BEN',...
%     'WQ_DIAG_MA2_SLG_BEN',...
%     'WQ_OGM_POC',...
%     'WQ_OGM_DOC',...
%     'WQ_DIAG_MAG_ULVA_FI',...
%     'WQ_DIAG_MAG_ULVA_FNIT',...
%     'WQ_DIAG_MAG_ULVA_FPHO',...
%     'WQ_DIAG_MAG_ULVA_FT',...
%     'WQ_DIAG_MAG_ULVA_FSAL',...
%     'WQ_DIAG_MAG_ULVA_FI_BEN',...
%     'WQ_DIAG_MAG_ULVA_FNIT_BEN',...
%     'WQ_DIAG_MAG_ULVA_FPHO_BEN',...
%     'WQ_DIAG_MAG_ULVA_FT_BEN',...
%     'WQ_DIAG_MAG_ULVA_FSAL_BEN',...
};

% def.cAxis(1).value = [0 200];   %'SAL',...
% def.cAxis(2).value = [5 35];  %'TEMP',...
% def.cAxis(3).value = [0 1];   %'RUPPIA_HSI',...
% def.cAxis(4).value = [0 10];   %'TN',...
% def.cAxis(5).value = [0 2];   %'TP',...
% def.cAxis(6).value = [0 50];   %'TCHLA',...
% def.cAxis(7).value = [0 0.2];         %'AMM',...
% def.cAxis(8).value = [0 2];         %'NIT',...
% def.cAxis(9).value = [0 0.4];         %'TP',...
% def.cAxis(10).value = [0 0.2];         %'FRP',...
% def.cAxis(11).value = [0 15];         %'OXY',...
% def.cAxis(12).value = [0 30];         %'TSS',...
% def.cAxis(13).value = [0 30];         %'TURB',...
% def.cAxis(14).value = [0 250];         %'WQ_PHY_GRN',...
% def.cAxis(15).value = [0 0.05];         % 'WQ_OGM_POP',...
% def.cAxis(16).value = [0 0.5];         %'WQ_OGM_DOP',...
% def.cAxis(17).value = [0 0.5];         %'WQ_OGM_PON',...
% def.cAxis(18).value = [0 5];         %'WQ_OGM_DON',...
for vvvv=1:65
def.cAxis(vvvv).value = [ ];
end
%def.cAxis(3).value = [0 150];
% ____________________________________________________________Configuration

start_plot_ID = 1;
%end_plot_ID = 15;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)
plotmodel = 1;

plotdepth = {'surface'};  % Cell-array with either one or both
depth_range = [0.2 100];
validation_minmax = 0;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 1;
isRange  = 0;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

isHTML = 1;

yr = 2017;
def.datearray = datenum(yr,7:6:55,1);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = '/Projects2/CDM/MER_Coorong_eWater_2021/plots/compare_Allscens_new/RAW/';
htmloutput = '/Projects2/CDM/MER_Coorong_eWater_2021/plots/compare_Allscens_new/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
 ncfile(1).name = '/Projects2/CDM/MER_Coorong_eWater_2021/output_basecase/eWater2021_basecase_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[166,86,40]./255,[166,86,40]./255};% Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'All water';
 ncfile(1).translate = 1;
% 
 ncfile(2).name = '/Projects2/CDM/MER_Coorong_eWater_2021/output_Scen3/eWater2021_Scen3_all.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[55,126,184]./255,[55,126,184]./255}; % Surface and Bottom
 ncfile(2).legend = 'No CEW 4yrs';
 ncfile(2).translate = 1;
% 
 ncfile(3).name = '/Projects2/CDM/MER_Coorong_eWater_2021/output_Scen4/eWater2021_Scen4_all.nc';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {[77,175,74]./255,[77,175,74]./255}; % Surface and Bottom
 ncfile(3).legend = 'No eWater 4yrs';
 ncfile(3).translate = 1;
 % 
 ncfile(4).name = '/Projects2/CDM/MER_Coorong_eWater_2021/output_Scen1/eWater2021_Scen1_all.nc';
 ncfile(4).symbol = {'-';'--'};
 ncfile(4).colour = {[152,78,163]./255,[152,78,163]./255}; % Surface and Bottom
 ncfile(4).legend = 'No CEW 1yr';
 ncfile(4).translate = 1;

 ncfile(5).name = '/Projects2/CDM/MER_Coorong_eWater_2021/output_Scen2/eWater2021_Scen2_all.nc';
 ncfile(5).symbol = {'-';'--'};
 ncfile(5).colour = {[255,127,0]./255,[255,127,0]./255}; % Surface and Bottom
 ncfile(5).legend = 'No eWater 1yr';
 ncfile(5).translate = 1;

% 
%  

% ___________________________________________________________________Models



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

% yr = 2012;
% def.datearray = datenum(yr,01:01:04,01);

def.dateformat = 'mm/yyyy';
% Must have same number as variable to plot & in same order

def.dimensions = [20 8]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 10;
def.legendsize = 6;
def.legendlocation = 'northeastoutside';

def.visible = 'off'; % on or off
