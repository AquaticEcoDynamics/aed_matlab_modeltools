
addpath(genpath('tuflowfv'));

% SITE Configuration_______________________________________________________
polygon_file = 'GIS/Erie/erie_validation_v4.shp';
fielddata = 'erie';

sites = [17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration


% VAR Configuration________________________________________________________
varname = {...
    'WQ_MAG_CGM',...
    'WQ_MAG_CGM_IP',...
    'WQ_DIAG_MAG_MAG_BEN',...
    'WQ_DIAG_MAG_MAG_BEN',...
    'WQ_DIAG_MAG_IP',...
    'WQ_DIAG_MAG_IN',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_MAG_NMP',...
    'WQ_DIAG_MAG_NUP',...
    'WQ_DIAG_MAG_PUP',...
    'WQ_DIAG_MAG_CGM_LAVG',...
    'WQ_DIAG_MAG_CGM_SAVG',...
    'WQ_DIAG_MAG_CGM_SLTG',...
    'WQ_DIAG_MAG_CGM_TAVG',...
    'WQ_DIAG_MAG_GPP_BEN',...
    'WQ_DIAG_MAG_GPP',...
    'WQ_DIAG_MAG_IN_BEN',...
    'WQ_DIAG_MAG_IP_BEN',...
    'WQ_DIAG_MAG_NMP_BEN',...
    'WQ_DIAG_MAG_RSP_BEN',...
    'WQ_DIAG_MAG_TMALG',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_LIGHT',...
    'WQ_DIAG_TOT_PAR',...
    'WQ_DIAG_TOT_UV',...
    'WQ_DIAG_TOT_EXTC',...
};

def.cAxis(1).value = [0 0.001];   %'WQ_DIAG_TOT_TN',...
def.cAxis(2).value = [0 0.25];  %'WQ_DIAG_TOT_TP',...
def.cAxis(3).value = [0 15];   %'WQ_DIAG_TOT_TOC',...
def.cAxis(4).value = [0 600];	%'WQ_DIAG_TOT_TSS',...
def.cAxis(5).value = [0 750];  %'WQ_DIAG_TOT_LIGHT',...
def.cAxis(6).value = [0 400];  %'WQ_DIAG_TOT_PAR',...
def.cAxis(7).value = [0 50];  %'WQ_DIAG_TOT_UV',...
def.cAxis(8).value = [0 2];   %'WQ_DIAG_TOT_EXTC',...
def.cAxis(9).value = [0 50];   %'WQ_DIAG_PHY_TCHLA',...
% ____________________________________________________________Configuration



% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'surface';'bottom'};  % Cell-array with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim   = 0;
isRange  = 1;
isRange_Bottom = 1;
Range_ALL = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

isHTML = 0;
htmloutput = '/Volumes/Spinny/cloudstor/Shared/Aquatic Ecodynamics (AED)/AED_Erie/Model_Results/Older Results/tfv_009_met_fielddata_MAG/';

outputdirectory = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Plotting/Model_009_magC/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________

 ncfile(1).name = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Output/erie_AED_diag.nc';
 ncfile(1).symbol = {'-';'-'};
 ncfile(1).colour = {[0  96 100]./255,[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(1).legend = 'v09mag';
 ncfile(1).translate = 1;
%  
%  ncfile(2).name = 'J:\Historical\run_2016_BASE.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
%  ncfile(2).legend = 'Restart';
%  ncfile(2).translate = 1;
 
% ___________________________________________________________________Models



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

yr = 2013;
def.datearray = datenum(yr,05:01:06,01);

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