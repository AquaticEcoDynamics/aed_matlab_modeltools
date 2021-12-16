
% Configuration____________________________________________________________
 



fielddata_matfile = '..\..\..\Lake-Erie\matlab\modeltools\matfiles\erie.mat';
fielddata = 'erie';

polygon_file = '..\..\..\Lake-Erie\matlab\modeltools\gis\erie_validation_v4.shp';

sites = [33:1:37];

varname = {...
    'WQ_PHS_FRP',...
};

def.cAxis(1).value = [];   %'WQ_DIAG_TOT_TN',...






plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim = 1;
isRange = 0;
isRange_Bottom = 0;
Range_ALL = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];
% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'Y:\Erie\tfv_011_Scn00\Plots\VData_Test\Raw\';
htmloutput = 'Y:\Erie\tfv_011_Scn00\Plots\VData_Test\HTML\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'Y:\Erie\tfv_011_Scn00\Output\erie_00_AED.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = 'v11';
 ncfile(1).translate = 1;
%  
%  

% Add virtual datasets to the plots
add_vdata = 1;

vdata(1).matfile = 'vdata/1274_out.mat';
vdata(1).fieldname  = 'vdata';
vdata(1).polygon = 33;
vdata(1).legend = 'GLM: 1274';
vdata(1).plotcolor = 'r';

vdata(2).matfile = 'vdata/1341_out.mat';
vdata(2).fieldname  = 'vdata';
vdata(2).polygon = 34;
vdata(2).legend = 'GLM: 1341';
vdata(2).plotcolor = 'r';

vdata(3).matfile = 'vdata/1345_out.mat';
vdata(3).fieldname  = 'vdata';
vdata(3).polygon = 35;
vdata(3).legend = 'GLM: 1345';
vdata(3).plotcolor = 'r';

vdata(4).matfile = 'vdata/1351_out.mat';
vdata(4).fieldname  = 'vdata';
vdata(4).polygon = 37;
vdata(4).legend = 'GLM: 1351';
vdata(4).plotcolor = 'r';

vdata(5).matfile = 'vdata/1353_out.mat';
vdata(5).fieldname  = 'vdata';
vdata(5).polygon = 36;
vdata(5).legend = 'GLM: 1353';
vdata(5).plotcolor = 'r';



% Defaults_________________________________________________________________



yr = 2013;
def.datearray = datenum(yr,05:01:10,01);
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
