
 

% SITE Configuration_______________________________________________________
%fielddata_matfile = '..\..\..\Lake-Erie-2019\matlab\modeltools\matfiles\erie.mat';
fielddata_matfile = '../../../Lake-Erie/matlab/modeltools/matfiles/erie.mat';
fielddata = 'erie';

%polygon_file = '..\..\..\Lake-Erie-2019\matlab\modeltools\gis\erie_validation_v4.shp';
polygon_file = '../../../Lake-Erie/matlab/modeltools/gis/erie_validation_v4.shp';

sites = [1,2,3,17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration



% VAR Configuration________________________________________________________
varname = {...
    'WQ_DIAG_BIV_EXCR_N',...
    'WQ_DIAG_BIV_EXCR_P',...
    'WQ_DIAG_BIV_EGST_N',...
    'WQ_DIAG_BIV_EGST_P',...
    'WQ_DIAG_BIV_GRZ_N',...
    'WQ_DIAG_BIV_GRZ_P',...
    'WQ_DIAG_BIV_NUM',...
    'WQ_DIAG_BIV_X_C',...
    'WQ_DIAG_BIV_TBIV',...
    'WQ_DIAG_BIV_NMP',...
    'WQ_DIAG_BIV_RESP',... 
    'WQ_DIAG_BIV_NET_C',...
    'WQ_DIAG_BIV_NET_N',...
    'WQ_DIAG_BIV_NET_P',...
    'WQ_DIAG_BIV_GRZ',...
    'WQ_DIAG_BIV_MORT',...
    'WQ_DIAG_BIV_EXCR',...
    'WQ_DIAG_BIV_EGST',...
    'WQ_DIAG_BIV_FT',...
    'WQ_DIAG_BIV_FD',...
    'WQ_DIAG_BIV_FG',...
    'WQ_DIAG_BIV_FR',...
    'WQ_DIAG_BIV_PF',...
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

isHTML = 1;
%htmloutput = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Erie\Model_Results/v9_A3/';
htmloutput = '/Volumes/Spinny/cloudstor/Shared/Aquatic Ecodynamics (AED)/AED_Erie/Model_Results/Older Results/tfv_009_met_fielddata_MAG/';

outputdirectory = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Plotting/Model_009_T/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________

 ncfile(1).name = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Output/erie_AED_diag.nc';  %ncfile(1).name = 'T:\tfv_009_AED_BIV_Met_A3\Output/erie_AED_diag.nc';
 ncfile(1).symbol = {'-';'-'};
 ncfile(1).colour = {[0  96 100]./255,[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(1).legend = 'v09q';
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
def.datearray = datenum(yr,05:01:08,05);

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
def.titlesize = 10;
def.legendsize = 6;
def.legendlocation = 'northeastoutside';

def.visible = 'off'; % on or off

alph = 0.5; % transparency

