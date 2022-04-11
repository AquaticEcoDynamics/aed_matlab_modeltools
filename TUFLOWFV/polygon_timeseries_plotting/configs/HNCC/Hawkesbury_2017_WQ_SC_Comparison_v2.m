
% Configuration____________________________________________________________
 



fielddata_matfile = '../../../Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '../../../Hawkesbury/matlab/modeltools/gis/HN_Calibration_v3.shp';



varname = {...
     'WQ_OXY_OXY',...
     'WQ_NIT_AMM',...
     'WQ_NIT_NIT',...
     'WQ_PHS_FRP',...
     'WQ_DIAG_PHY_TCHLA',...
     'WQ_DIAG_TOT_TN',...
     'WQ_DIAG_TOT_TP',...
     'WQ_DIAG_TOT_TSS',...
     'WQ_DIAG_TOT_TURBIDITY',...
     'TEMP',...
     'SAL',...
	 'ENTEROCOCCI_PASSIVE',...
	 'ECOLI_PASSIVE',...
	 'H',...
 };
   	varname_human = {...
    'Dissolved Oxygen',...
    'Ammonia',...
    'NOx',...
    'FRP',...
    'Total Chlorophyll-A',...
    'Total Nitrogen',...
    'Total Phosphorus',...
    'TSS',...
	'Turbidity',...
    'Temperature',...
    'Salinity',...
    'ENTEROCOCCI',...
    'ECOLI',...
	'Height',...
     }; 
 
 def.cAxis(1).value = [0 12.5];            %'WQ_OXY_OXY',...
 def.cAxis(2).value = [0 0.25];	        %'WQ_NIT_AMM',...
 def.cAxis(3).value = [0 25];           %'WQ_NIT_NIT',...
 def.cAxis(4).value = [0 0.1];             %'WQ_PHS_FRP',...
 def.cAxis(5).value = [0 100];           %'WQ_DIAG_PHY_TCHLA',...
 def.cAxis(6).value = [0 25];           %'WQ_DIAG_TOT_TN',...
 def.cAxis(7).value = [0 0.3];           %'WQ_DIAG_TOT_TP',...
 def.cAxis(8).value = [0 100];           %'WQ_DIAG_TOT_TSS',...
 def.cAxis(9).value = [0 150];         %'WQ_DIAG_TOT_TURBIDITY',...
 def.cAxis(10).value = [5 40];           %'Temp',...
 def.cAxis(11).value = [0 40];         %'SAL',...
 def.cAxis(12).value = [0 1000];		%'ENTEROCOCCI'
 def.cAxis(13).value = [0 250];		%'ECOLI_SIMPLE'
 def.cAxis(14).value = [];		%'H'


start_plot_ID = 1; % Skip vars and start plotting at this var;


plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = false; % true or false

plotdepth = {'surface'};%'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both
add_human = 1;

add_trigger_values = 1;

trigger_file = 'TriggerValues_HN.xlsx';


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 0;
isRange = 0;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

depth_range = [0.5 100];

use_matfiles = 0;
single_precision = 0;
add_error = 1;
% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects/Cattai/Report_V2/Polygon/HN_Comparison_2017_v2_1/RAW/';
htmloutput = ['/Projects/Cattai/Report_V2/Polygon/HN_Comparison_2017_v2_1/HTML/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Projects2/Cattai/HN_CC_Cal_v1_A4_2017_2D_TESTRUN/output_plt/HN_Cal_2017_2018_2D_wq_DOC_DEM_3D_WQ.nc';
%  ncfile(1).tfv = 'I:/Hawkesbury/HN_Cal_v3_noIC/output/HN_Cal_2013_HYDRO.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'Baseline';
 ncfile(1).translate = 1;
%  
  ncfile(2).name = '/AED/Hawkesbury/HN_Cal_v7_A3_2017/output/HN_Cal_2017_2018_3D_wq_WQ.nc'; 
  ncfile(2).symbol = {'-';'--'};
  ncfile(2).colour = {[0 0 0],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
  ncfile(2).legend = 'Baselne 2021';
  ncfile(2).translate = 1;
  %
  ncfile(3).name = '/Projects2/Cattai/HN_Cal_v7_A3_2017_TESTRUN_MET/output_plt/HN_Cal_2017_2018_3D_wq_WQ.nc'; 
  ncfile(3).symbol = {'-';'--'};
  ncfile(3).colour = {'g',[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
  ncfile(3).legend = 'Baselne 2021 AED MET';
  ncfile(3).translate = 1;
 










% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

%def.datearray = datenum(yr,07:03:19,01);
% yr = 2015;
% def.datearray = datenum(yr,11:05:41,01);

yr = 2017;
def.datearray = datenum(yr,03:03:19,01);
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
