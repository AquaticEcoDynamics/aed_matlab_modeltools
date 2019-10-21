% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'swan';




varname = {...
%     'WQ_OXY_OXY',...
%     'SAL',...
    'TEMP',...
    };

% def.cAxis(1).value = [0 20];
% def.cAxis(2).value = [0 55];
def.cAxis(1).value = [5 45];


%polygon_file = 'GIS/CEWH_Reporting.shp';
polygon_file = 'GIS/Swan/Swan_Sites.shp';
%changed the polygon file loc
plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotmodel = 1;

%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

plotvalidation = 1; % true or false

%----------- define plot options ------------%
plotdepth = {'surface';'bottom'};%{'surface','bottom'}; % Cell with either one or both
istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 0;
custom_datestamp = 0;

filetype = 'eps';
def.expected = 0; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'plotting_output\Swan2018Phytooff\Test3tfv_newShp';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

%nc file loc changed%
ncfile(1).name = 'Z:\Amina\Swan2018_Phyto_totals_off/Output/swan.nc';% change this to the nc file loc
ncfile(1).symbol = {'-';'-'};% top and bottom
ncfile(1).colour = {[255/255 61/255 9/255],'k'}; % Surface and Bottom
ncfile(1).legend = 'Model';
ncfile(1).translate = 1;
% 
% ncfile(2).name = 'G:\Swan\monthly_201502.nc';
% ncfile(2).symbol = {'-';'-'};
% ncfile(2).colour = {[255/255 61/255 9/255],'k'}; % Surface and Bottom
% ncfile(2).legend = 'Model';
% ncfile(2).translate = 1;
% 




% yr = 2015;
% def.datearray = datenum(yr,01:03:21,01);
yr = 2018;
def.datearray = datenum(yr,05:01:11,01);
def.dateformat = 'mmm-yy';
% Defaults_________________________________________________________________

% Makes start date, end date and datetick array

%def.datearray = datenum(yr,1:4:26,01);
%def.datearray = datenum(2011,06,07.2:0.05:7.45);

%def.datearray = datenum(yr-1,11:2:23,01);

% Must have same number as variable to plot & in same order

def.dimensions = [12 7]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 1; % Must be odd number (set to 3 if none)


def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'k','b'}; % Cell with same number of levels

def.font = 'Candara';

def.xlabelsize = 9;
def.ylabelsize = 9;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'northeast';

def.visible = 'on'; % on or off
