
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '../../../CDM/data/store/archive/cllmm.mat';
fielddata = 'cllmm';
%fielddata_matfile = 'lowerlakes.mat';
%fielddata = 'lowerlakes';
polygon_file = '../../../CDM/gis/supplementary/Coorong\Coorong_obs_sites.shp';
%polygon_file = '../../../CDM/gis/supplementary/Coorong\Final_Ruppia_Area.shp';

%polygon_file = '.\GDSTN_Polygons_200m_v2_C3.shp';

%sites = [17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration



% VAR Configuration________________________________________________________
% varname = {...
%  'SAL',...
%  'TEMP',...
%  'H',...
%  'WQ_DIAG_HAB_RUPPIA_HSI',...
%  'WQ_DIAG_TOT_TN',...
%  'WQ_DIAG_TOT_TP',...
%  'WQ_DIAG_PHY_TCHLA',...
%      'WQ_NIT_AMM',...
%     'WQ_NIT_NIT',...
%     'WQ_DIAG_TOT_TP',...
%     'WQ_PHS_FRP',...
%     'WQ_OXY_OXY',...
%     'WQ_DIAG_TOT_TSS',...
%     'WQ_DIAG_TOT_TURBIDITY',...
%     'WQ_PHY_GRN',...
%     'WQ_OGM_POP',...
%     'WQ_OGM_DOP',...
%     'WQ_OGM_PON',...
%     'WQ_OGM_DON',...
% };
varname = {...
 'WQ_DIAG_TOT_TURBIDITY',...
 'WQ_DIAG_TOT_TN',...
 'WQ_DIAG_TOT_TP',...
 'WQ_DIAG_PHY_TCHLA',...
     'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_DIAG_TOT_TP',...
    'WQ_PHS_FRP',...
    'WQ_OXY_OXY',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_PHY_GRN',...
    'WQ_OGM_POP',...
    'WQ_OGM_DOP',...
    'WQ_OGM_PON',...
    'WQ_OGM_DON',...
 
 
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
% for vvvv=1:2
% def.cAxis(vvvv).value = [ ];
% end

for vvvv=1:65
def.cAxis(vvvv).value = [ ];
end% ____________________________________________________________Configuration

start_plot_ID = 1;
%end_plot_ID = 65;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'surface'};%;'bottom'};  % Cell-array with either one or both
depth_range = [0.2 100];
validation_minmax = 0;
isFieldRange = 1;
istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 1;
isRange  = 1;

isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

isHTML = 1;


yr = 2020;
def.datearray = datenum(yr,11:1:14,14);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = 'C:\Users\00065525\AED Dropbox\AED_Coorong_db\7_hchb\Model Output\hchb_tfvaed_20201101_20210401_v1_RESUS\Images/RAW/';
htmloutput = 'C:\Users\00065525\AED Dropbox\AED_Coorong_db\7_hchb\Model Output\hchb_tfvaed_20201101_20210401_v1_RESUS\Images/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
 ncfile(1).name = 'C:\Users\00065525\Scratch\CDM\hchb_wave_20201101_20210401_wq_phy_all.nc';

 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[140,81,10]./255,[216,179,101]./255};% Surface and Bottom % Surface and Bottom
 ncfile(1).legend = '2020 - 2021';
 ncfile(1).translate = 1;
% 
%  ncfile(2).name = 'C:\Users\00065525\Scratch\CDM\CoorongBGC_006_validation_201707_201903_wq_all.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {[252,141,89]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(2).legend = 'CIIP 2017 - 2019';
%  ncfile(2).translate = 1;

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
