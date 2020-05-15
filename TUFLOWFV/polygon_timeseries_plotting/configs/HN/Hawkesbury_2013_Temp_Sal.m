
% Configuration____________________________________________________________
 


fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\HN_Calibration_v3.shp';



varname = {...
    'TEMP',...
    'SAL',...
};


def.cAxis(1).value = [5 40];    		%'TEMP',...
def.cAxis(2).value = [0 35];            %'SAL',...





plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

depth_range = [0.5 100];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'J:\Hawkesbury\HN_Cal_v4\Plots\TS\';
htmloutput = ['J:\Hawkesbury\HN_Cal_v4\Plots\HN_Cal_v4\2013_2014_1\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'J:\Hawkesbury\HN_Cal_v4\output\HN_Cal_2013_HYDRO.nc';
%  ncfile(1).tfv = 'I:\Hawkesbury\HN_Cal_v3_noIC\output\HN_Cal_2013_HYDRO.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = '2013';
 ncfile(1).translate = 1;
%  
 ncfile(2).name = 'J:\Hawkesbury\HN_Cal_v4\output\HN_Cal_2014_HYDRO.nc';
 %ncfile(2).tfv = 'I:\Hawkesbury\HN_Cal_v3_noIC\output\HN_Cal_2013_HYDRO.nc';

 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(2).legend = '2014';
 ncfile(2).translate = 1;
 










% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

%def.datearray = datenum(yr,07:03:19,01);
% yr = 2015;
% def.datearray = datenum(yr,11:05:41,01);

yr = 2013;
def.datearray = datenum(yr,05:04:25,01);
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
