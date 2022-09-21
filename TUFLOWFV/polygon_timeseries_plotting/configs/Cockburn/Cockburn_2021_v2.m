
% Configuration____________________________________________________________
 


fielddata_matfile = '/Projects2/Jayden/CS_BCs/WIR/swan.mat';
fielddata = 'swan';

polygon_file = '/Projects2/Jayden/plotting/Cockburn_Sites_2021.shp';



varname = {...
     'TEMP',...
     'SAL',...
	 'D',...
	 	 'WQ_DIAG_TOT_TN',...
	'WQ_DIAG_TOT_TP',...
	'WQ_DIAG_PHY_TCHLA',...
	'WQ_NIT_AMM',...
	'WQ_NIT_NIT',...
	'WQ_DIAG_TOT_TP',...
	'WQ_PHS_FRP',...
	'WQ_OXY_OXY',...
	'WQ_DIAG_TOT_TSS',...
	'WQ_DIAG_TOT_TOC',...
	'WQ_OGM_DOC',...
	'WQ_DIAG_TOT_TURBIDITY',...
 };
   	varname_human = {...
    'Temperature',...
    'Salinity',...
	'Depth',...
     }; 
 
for vvvv=1:length(varname)
def.cAxis(vvvv).value = [ ];
end

%start_plot_ID = 24; % Skip vars and start plotting at this var;


plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface'; 'bottom'};%'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

add_trigger_values = 0;

%trigger_file = 'TriggerValues_HN.xlsx';



istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

depth_range = [0.5 100];

use_matfiles = 0;
single_precision = 0;
add_error = 1;
% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects2/Jayden/Plots_SWAN/Polygon/RAW/';
htmloutput = ['/Projects2/Jayden/Plots_SWAN/Polygon/HTML/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Projects2/Jayden/Cockburn_2022_2/Output/Cockburn_2021_2022_gpu_ALL.nc';
%  ncfile(1).tfv = 'I:/Hawkesbury/HN_Cal_v3_noIC/output/HN_Cal_2013_HYDRO.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'V1';
 ncfile(1).translate = 1;
%  
  %ncfile(2).name = '/Projects2/Cattai/HN_CC_Cal_v1_A5_Scenarios/output/HN_Cal_2013_2016_3D_wq_Background_WQ.nc'; 
  %ncfile(2).symbol = {'-';'--'};
  %ncfile(2).colour = {[0 0 0],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
  %ncfile(2).legend = 'Background';
  %ncfile(2).translate = 1;
  %
  %ncfile(3).name = '/Projects2/Cattai/HN_CC_Cal_v1_A5_Scenarios/output/HN_Cal_2013_2016_3D_wq_Impact_WQ.nc'; 
  %ncfile(3).symbol = {'-';'--'};
  %ncfile(3).colour = {'g',[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
  %ncfile(3).legend = 'Impact';
  %ncfile(3).translate = 1;
 










% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

%def.datearray = datenum(yr,07:03:19,01);
% yr = 2015;
% def.datearray = datenum(yr,11:05:41,01);

yr = 2021;
def.datearray = datenum(yr,01:03:13,01);
%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [14 6]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'northeastoutside';

def.visible = 'off'; % on or off
