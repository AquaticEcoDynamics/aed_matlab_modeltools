
 

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
 'WQ_NCS_SS1',...
  'WQ_DIAG_TOT_TURBIDITY',...
%  'WQ_DIAG_NCS_SS1_VVEL',...
% 'WQ_DIAG_NCS_SS_SED',...
% 'WQ_DIAG_NCS_TAU_0',...
% 'WQ_DIAG_NCS_EPSILON',...
% 'WQ_DIAG_NCS_FS1',...
% 'WQ_DIAG_NCS_SWI_DZ',...
% 'WQ_DIAG_NCS_RESUS',...
% 'WQ_DIAG_NCS_D_TAUB',...
};
for i = 1:length(varname)
def.cAxis(i).value = [];   %'SAL',...
end
% ____________________________________________________________Configuration

start_plot_ID = 1;
%end_plot_ID = 2;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'bottom'};%;'bottom'};  % Cell-array with either one or both
depth_range = [0 100];
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

isFieldRange = 1;
fieldprctile = [10 90];

isHTML = 1;

yr = 2017;
def.datearray = datenum(yr,6,1:10:90);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = 'C:\Users\00065525\Scratch\CDM\wave_test_3\RAW\';
htmloutput = 'C:\Users\00065525\Scratch\CDM\wave_test_3\HTML\';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
 ncfile(1).name = 'Y:\CDM\Wave\coorong-bgc-master-20210414\coorong-bgc-master\02_modelling\output\CoorongBGC_006_validation_201707_201903_wq_wave_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[140,81,10]./255,[216,179,101]./255};% Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'WAVE';
 ncfile(1).translate = 1;
% 
 ncfile(2).name = 'W:\CIIP\Scenarios\Calibration\2017_2019\CoorongBGC_006_validation_201707_201903_wq_all.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[140,81,10]./255,[216,179,101]./255};% Surface and Bottom % Surface and Bottom
 ncfile(2).legend = '2017 - 2019';
 ncfile(2).translate = 1;%  ncfile(3).name = 'Y:\CIIP\Scenarios\phase1\SC04\CoorongBGC_SC04_LAC_dry_001_wq_all.nc';
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

def.dateformat = 'dd/mm';
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
