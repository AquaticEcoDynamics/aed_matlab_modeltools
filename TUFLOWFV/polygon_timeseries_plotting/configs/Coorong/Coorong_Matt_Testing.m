
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm.mat';
%fielddata = 'UA';
fielddata = 'cllmm';
polygon_file = '../../../CDM/gis/supplementary/Coorong/31_Zones_PHnumbering.shp';
%polygon_file = '../../../CDM/gis/supplementary/Coorong/Coorong_obs_sites.shp';
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
    'WQ_DIAG_SDG_OXY01'			,...
	'WQ_DIAG_SDG_AMM01'         ,...
	'WQ_DIAG_SDG_POML01'        ,...
	'WQ_DIAG_SDG_SWI_DEFF'      ,...
	'WQ_DIAG_SDG_OPD'           ,...
	'WQ_DIAG_SDG_ARPD'          ,...
	'WQ_DIAG_SDG_FOM'           ,...
	'WQ_DIAG_SDG_TOC'           ,...
	'WQ_DIAG_SDG_TFE'           ,...
	'WQ_DIAG_SDG_TN'            ,...
	'WQ_DIAG_SDG_TP'            ,...
	'WQ_DIAG_SDG_TS'            ,...
	'WQ_DIAG_SDG_CRS'           ,...
	'WQ_DIAG_SDG_MINERL'        ,...
	'WQ_DIAG_SDG_AEROBIC'       ,...
	'WQ_DIAG_SDG_ANAEROBIC'     ,...
	'WQ_DIAG_SDG_DENIT'         ,...
	'WQ_DIAG_SDG_MNRED'         ,...
	'WQ_DIAG_SDG_FERED'         ,...
	'WQ_DIAG_SDG_SO4RED'        ,...
	'WQ_DIAG_SDG_METHAN'        ,...
	'WQ_DIAG_SDG_BPP'           ,...
	'WQ_DIAG_SDG_BIODEPTH'      ,...
	'WQ_DIAG_SDG_POROSITY'      ,...
	'WQ_DIAG_SDG_STEADINESS'    ,...
	'WQ_DIAG_SDG_ERROR'         ,...
};
% de.cAxis(1).value = [0 200];   %'SAL',...
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
for vvvv=1:length(varname)
def.cAxis(vvvv).value = [ ];
end
%def.cAxis(3).value = [0 150];
% ____________________________________________________________Configuration

start_plot_ID = 1;
% end_plot_ID = 4;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

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

yr = 2019;
def.datearray = datenum(yr,7:6:42,1);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = '/AED/Development/matt/hchb_tfvaed_v2_calibration_z31_newSHP/Plots31/RAW/';
htmloutput = '/AED/Development/matt/hchb_tfvaed_v2_calibration_z31_newSHP/Plots31/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
%  ncfile(1).name = '/Projects2/CDM/hchb_tfvaed_v1_resuspension/output_sedIC5/output/hchb_wave_21901101_20210701_wq_v5_resuspension_sedIC_all.nc';
%  ncfile(1).symbol = {'-';'--'};
%  ncfile(1).colour = {[140,81,10]./255,[216,179,101]./255};% Surface and Bottom % Surface and Bottom
%  ncfile(1).legend = 'V1-5';
%  ncfile(1).translate = 1;
% 
 ncfile(1).name = '/AED/Development/matt/hchb_tfvaed_v2_calibration_z31_newSHP/output/hchb_wave_21901101_20210701_wq_v5_resuspension_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[230,245,152]./255,[1,102,94]./255}; % Surface and Bottom
 ncfile(1).legend = 'DEV';
 ncfile(1).translate = 1;
 
%  ncfile(2).name = '/Projects2/CDM/hchb_tfvaed_v2_resuspension_z31_newSHP/output/hchb_wave_21901101_20210701_wq_v5_resuspension_all.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {[252,141,89]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(2).legend = 'V31-0';
%  ncfile(2).translate = 1;


% % 
%  ncfile(4).name = 'Y:/CIIP/Scenarios/phase1/SC05/CoorongBGC_SC05_SEFA_dry_001_wq_all.nc';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {[230,245,152]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(4).legend = 'SC05';
%  ncfile(4).translate = 1;
% 
%  ncfile(5).name = 'Y:/CIIP/Scenarios/phase1/SC07/CoorongBGC_SC07_pump_in_out_reverse_500_ML_d_dry_001_wq_all.nc';
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
