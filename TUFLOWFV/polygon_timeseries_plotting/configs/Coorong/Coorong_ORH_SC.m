
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'coorong';




varname = {...
%'SAL',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_TOT_TURBIDITY',...
};


def.cAxis(1).value = [0 100];     %'SAL',...
def.cAxis(2).value = [0 5]; 	%'WQ_DIAG_TOT_TN',...
def.cAxis(3).value = [0 1.5]; 	%'WQ_DIAG_TOT_TP',...
def.cAxis(4).value = [0 150]; 	%'WQ_DIAG_TOT_TURBIDITY',...


polygon_file = 'GIS/Coorong/Ruppia_Zones.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = false; % true or false

plotdepth = {'surface'};%;'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim = 0;
isRange = 0;
isRange_Bottom = 0;
Range_ALL = 0;

add_coorong = 1;

depth_range = [0.5 20];

filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Lowerlakes\Coorong\Timeseries_Final\ORH_SC\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________


 ncfile(1).name = 'Y:\Coorong Report\Process_Final\ORH_Base_20140101_20170101\';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = 'ORH';
 ncfile(1).translate = 1;
%  
 ncfile(2).name = 'Y:\Coorong Report\Process_Final\SC40_Base_20140101_20170101\';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {'r','r'}; % Surface and Bottom
 ncfile(2).legend = 'SC40';
 ncfile(2).translate = 1;
 
 ncfile(3).name = 'Y:\Coorong Report\Process_Final\SC40_NUT_1_5_20140101_20170101\';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {'b','b'}; % Surface and Bottom
 ncfile(3).legend = 'SC40 NUTx1.5';
 ncfile(3).translate = 1;
 
%  ncfile(4).name = 'Y:\Coorong Report\Process_Final\Netcdf\SC40_NUT_2.0_20140101_20170101\';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {'g','g'}; % Surface and Bottom
%  ncfile(4).legend = 'SC40 NUTx2.0';
%  ncfile(4).translate = 1; 
%  
%  









% Defaults_________________________________________________________________



yr = 2014;
def.datearray = datenum(yr,04:04:17,01);
%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [10 6]; % Width & Height in cm

def.dailyave = 1; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'northeast';

def.visible = 'off'; % on or off
