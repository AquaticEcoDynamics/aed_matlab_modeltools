
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '..\..\..\CDM\scripts\matlab\modeltools\matfiles\lowerlakes.mat';
fielddata = 'lowerlakes';
%fielddata_matfile = 'lowerlakes.mat';
%fielddata = 'lowerlakes';
polygon_file = '..\..\..\CDM\scripts\matlab\modeltools\gis\Coorong\Ruppia_Zones.shp';

%polygon_file = '.\GDSTN_Polygons_200m_v2_C3.shp';

%sites = [17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration



% VAR Configuration________________________________________________________
varname = {...
 'Acidity_CACO3',...
'Algae_Cells',...
'Alkalinity',...
'Azinphos_methyl',...
'Bicarbonate',...
'Blue_Green_Algae_Total_cells',...
'Calcium_Hardness',...
'Carbon_Dioxide',...
'Carbonate',...
'Carbonate_hardness',...
'Chlordane_a',...
'Chlordane_g',...
'Chloride',...
'Chlorides_Total',...
'Chlorophyll_b',...
'Chlorothalonil',...
'Chlorpyrifos',...
'Chlorthal_Dimethyl',...
'Conductivity',...
'DDD',...
'DDE',...
'DDT',...
'Diazinon',...
'Dieldrin',...
'Dissolved_solids',...
'FLOW',...
'Fixed_solids',...
'Flow_m3',...
'Flow_m3_Calc',...
'Fluoride',...
'H',...
'Iron_Total',...
'Level',...
'Mercury_Total',...
'Methoxychlor',...
'ON',...
'OP',...
'SAL',...
'Sulphate',...
'TEMP',...
'Tide',...
'Total_Hardness',...
'WQ_CAR_DIC',...
'WQ_CAR_PH',...
'WQ_DIAG_PHY_TCHLA',...
'WQ_DIAG_TOT_TAL',...
'WQ_DIAG_TOT_TDS',...
'WQ_DIAG_TOT_TFE',...
'WQ_DIAG_TOT_TKN',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TOC',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_TOT_TSS',...
'WQ_DIAG_TOT_TURBIDITY',...
'WQ_GEO_AL',...
'WQ_GEO_CA',...
'WQ_GEO_CALCITE',...
'WQ_GEO_CL',...
'WQ_GEO_FEII',...
'WQ_GEO_K',...
'WQ_GEO_MG',...
'WQ_GEO_MN',...
'WQ_GEO_NA',...
'WQ_GEO_SO4',...
'WQ_NCS_SS1',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_OGM_DOC',...
'WQ_OGM_DON',...
'WQ_OGM_DOP',...
'WQ_OGM_POC',...
'WQ_OGM_PON',...
'WQ_OGM_POP',...
'WQ_OXY_OXY',...
'WQ_PHS_FRP',...
'WQ_PHS_FRP_ADS',...
'WQ_PHY_GRN',...
'WQ_SIL_RSI',...
'WQ_TRC_SS1',...
'Wind',...
'Wind_Dir',...
'pH',...
};


for vvvv=1:82
def.cAxis(vvvv).value = [ ];
end
% ____________________________________________________________Configuration

start_plot_ID = 1;
end_plot_ID = 82;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'surface'};%;'bottom'};  % Cell-array with either one or both
depth_range = [0 100];
validation_minmax = 0;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 1;
isRange  = 0;
isRange_Bottom = 0;
Range_ALL = 0;
validation_raw = 1;
plotmodel = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

isHTML = 1;

yr = 2000;
%def.datearray = datenum(yr,7:4:36,1);
def.datearray = datenum(yr:03:2024,01,01);
%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = 'F:/CIIP/Field_Data/RAW/';
htmloutput = 'F:/CIIP/Field_Data/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
 ncfile(1).name = 'N:\CIIP\Scenarios\Calibration\2017_2019\CoorongBGC_006_validation_201707_201903_wq_wq.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[140,81,10]./255,[216,179,101]./255};% Surface and Bottom % Surface and Bottom
 ncfile(1).legend = '2017 - 2019';
 ncfile(1).translate = 1;
% 
 ncfile(2).name = 'J:\CDM\Wave\coorong-bgc-master-20210414\coorong-bgc-master\02_modelling\output\CoorongBGC_006_validation_201707_201903_wq_wave_wq.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[252,141,89]./255,[1,102,94]./255}; % Surface and Bottom
 ncfile(2).legend = 'WAVE';
 ncfile(2).translate = 1;
% 
%  ncfile(3).name = 'Y:\CIIP\Scenarios\phase1\SC04\CoorongBGC_SC04_LAC_dry_001_wq_all.nc';
%  ncfile(3).symbol = {'-';'--'};
%  ncfile(3).colour = {[254,224,139]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(3).legend = 'SC04';
%  ncfile(3).translate = 1;
% 
%  ncfile(4).name = 'Y:\CIIP\Scenarios\phase1\SC05\CoorongBGC_SC05_SEFA_dry_001_wq_all.nc';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {[230,245,152]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(4).legend = 'SC05';
%  ncfile(4).translate = 1;
% 
%  ncfile(5).name = 'Y:\CIIP\Scenarios\phase1\SC07\CoorongBGC_SC07_pump_in_out_reverse_500_ML_d_dry_001_wq_all.nc';
%  ncfile(5).symbol = {'-';'--'};
%  ncfile(5).colour = {[153,213,148]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(5).legend = 'SC07';
%  ncfile(5).translate = 1;
% 
%  

% ___________________________________________________________________Models



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

% yr = 2012;
% def.datearray = datenum(yr,01:01:04,01);

def.dateformat = 'dd/mm/yyyy';
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
