
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata_matfile = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
%fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/gis/HN_Calibration_v3.shp';

fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\HN_Calibration_v3.shp';


varname = {...
    'ECOLI_PASSIVE',...
    'ENTEROCOCCI_PASSIVE',...
    'ECOLI',...
    'ENTEROCOCCI',...
    'ECOLI_TOTAL',...
    'ENTEROCOCCI_TOTAL',...
    'ECOLI_SIMPLE',...
    'ENTEROCOCCI_SIMPLE',...
    'WQ_PAT_SS1',...
};


def.cAxis(1).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(2).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(3).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(4).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(4).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(6).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(7).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(8).value = [0 500];    		%'WQ_NCS_SS1',...
def.cAxis(9).value = [0 100];            %'WQ_OXY_OXY',...


%start_plot_ID = 19;

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';};%'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

isHTML = 0;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 0;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

depth_range = [0.5 100];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


%outputdirectory = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A1b_2017/plotting/Plots_V6/';
%htmloutput = ['/Volumes/AED/Hawkesbury/HN_Cal_v6_A1b_2017/plotting/Plots_V6/HTML/'];
outputdirectory = 'F:\Dropbox\HN FV AED2_SWC_incoming\V6\Plots_MH_path\2012t3\';
htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v6_Path\2012_2013\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

% ncfile(1).name = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A1b_2017/output/HN_Cal_2017_2018_3D_pt_WQ.nc';
 ncfile(1).name = 'N:\Hawkesbury\HN_Cal_v6_A1b_2012\output\HN_Cal_2012_2013_3D_pt_WQ_A1b.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'V6 A1b';
 ncfile(1).translate = 1;
  
 ncfile(2).name = 'N:\Hawkesbury\HN_Cal_v6_A1b_2012\output\HN_Cal_2012_2013_3D_pt_WQ.nc.part';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(2).legend = 'V6 A1b2';
 ncfile(2).translate = 1;

 ncfile(3).name = 'N:\Hawkesbury\HN_Cal_v6_A2_2012\output\HN_Cal_2012_2013_3D_wq_WQ.nc.part';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(3).legend = 'V6 A2';
 ncfile(3).translate = 1;
 
yr = 2012;
def.datearray = datenum(yr,04:04:25,01);
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
