
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm.mat';
%fielddata = 'UA';
fielddata = 'cllmm';
%polygon_file = '../../../CDM/gis/supplementary/Coorong/Coorong_obs_sites.shp';
polygon_file = '/Projects2/CDM/hchb_tfvaed_v3_2022_4PFTs/model/gis/shp/31_material_zones_names.shp';


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
varname = {'SAL',...
'TEMP',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_PHY_TCHLA',...
'WQ_OGM_DOC',...
'WQ_OGM_POC',...
'WQ_OGM_DON',...
'WQ_OGM_PON',...
'WQ_OGM_DOP',...
'WQ_OGM_POP',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_PHS_FRP',...
'WQ_DIAG_TOT_TOC',...
'WQ_DIAG_TOT_TSS',...
'WQ_DIAG_TOT_TURBIDITY',...
'WQ_OXY_OXY',...
'WQ_SIL_RSI',...
};

% def.cAxis(1).value = [0 100];
% def.cAxis(2).value = [0 100];

for vvvv=1:length(varname)
def.cAxis(vvvv).value = [ ];
end
%def.cAxis(3).value = [0 150];
% ____________________________________________________________Configuration

start_plot_ID = 1;
% end_plot_ID = 4;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = 0; %false; % Add field data to figure (true or false)

plotdepth = {'surface'};  % Cell-array with either one or both
depth_range = [0.5 100];
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
def.datearray = datenum(yr,7:6:61,1);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/plots/compare_allScens/RAW/';
htmloutput = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/plots/compare_allScens/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________

 ncfile(1).name = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/output_basecase_hd_v2/hchb_Gen2_201707_202201_all.nc';
  ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[31,120,180]./255,[31,120,180]./255}; % Surface and Bottom
 ncfile(1).legend = 'base case';
 ncfile(1).translate = 1;

 ncfile(2).name = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/output_noeWater_v2/hchb_Gen2_201707_202201_noeWater_all.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[255,127,0]./255,[255,127,0]./255}; % Surface and Bottom
 ncfile(2).legend = 'no eWater';
 ncfile(2).translate = 1;
 
 ncfile(3).name = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/output_noSE_v2/hchb_Gen2_201707_202201_noSE_all.nc';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {[106,61,154]./255,[106,61,154]./255}; % Surface and Bottom
 ncfile(3).legend = 'no SE';
 ncfile(3).translate = 1;

ncfile(4).name = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/output_scen3a_v2/hchb_Gen2_201707_202201_scen3a_all.nc';
ncfile(4).symbol = {'-';'--'};
ncfile(4).colour = {[230,245,152]./255,[1,102,94]./255}; % Surface and Bottom
ncfile(4).legend = 'designed';
ncfile(4).translate = 1;

 ncfile(5).name = '/Projects2/CDM/HCHB_scenario_assessment/HCHB_GEN2_4yrs_20220620/output_scen3b_v2/hchb_Gen2_201707_202201_scen3b_all.nc';
 ncfile(5).symbol = {'-';'--'};
 ncfile(5).colour = {[153,213,148]./255,[1,102,94]./255}; % Surface and Bottom
 ncfile(5).legend = 'no barrages';
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
