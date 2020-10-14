
% Configuration____________________________________________________________
 


fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\SC_Zones.shp';


%sites = [4:01:16];

%start_plot_ID = 1;

%end_plot_ID = 1;

varname = {...
    'WQ_DIAG_TOT_TN',...
};



def.cAxis(1).value = [0 8];   %'WQ_DIAG_TOT_TN',... 



plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface','bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 1;
plotmodel = 0;
filetype = 'eps';
def.expected = 1; % plot expected WL
isFieldRange = 1;
fieldprctile = [10 90];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'F:\Work Stuff\Hawkesbury\Plots\SC_2\';
htmloutput = '..\..\..\Hawkesbury\data\field_data_plots\SC Field Data 2013\';

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'I:\Hawkesbury\HN_Cal_v3_noIC\output\HN_Cal_2013_WQ.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = 'v11';
 ncfile(1).translate = 1;
%  
%  









% Defaults_________________________________________________________________



% yr = 2010;
% def.datearray = datenum(yr:02:2020,01,01);
yr = 2013;
def.datearray = datenum(yr,06:03:19,01);


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
