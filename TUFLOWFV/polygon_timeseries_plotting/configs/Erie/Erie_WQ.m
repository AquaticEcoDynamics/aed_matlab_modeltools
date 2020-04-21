
addpath(genpath('tuflowfv'));

% SITE Configuration_______________________________________________________
fielddata_matfile = '..\..\..\Lake-Erie-2019\matlab\modeltools\matfiles\erie.mat';
fielddata = 'erie';

polygon_file = '..\..\..\Lake-Erie-2019\matlab\modeltools\gis\erie_validation_v4.shp';

%sites = [17,18,20];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration



% VAR Configuration________________________________________________________
varname = {...
 'WQ_NCS_SS1',...
 'WQ_TRC_AGE',...
 'WQ_OXY_OXY',...
 'WQ_SIL_RSI',...
 'WQ_NIT_AMM',...
 'WQ_NIT_NIT',...
 'WQ_PHS_FRP',...
 'WQ_PHS_FRP_ADS',...
 'WQ_OGM_DOC',...
 'WQ_OGM_POC',...
 'WQ_OGM_DON',...
 'WQ_OGM_PON',...
 'WQ_OGM_DOP',...
 'WQ_OGM_POP',...
 'WQ_PHY_CYANO',...
 'WQ_PHY_CYANO_RHO',...
 'WQ_PHY_CYANO_IN',...
 'WQ_PHY_CYANO_IP',...
 'WQ_PHY_CHLOR',...
 'WQ_PHY_CHLOR_IN',...
 'WQ_PHY_CHLOR_IP',...
 'WQ_PHY_CRYPT',...
 'WQ_PHY_CRYPT_IN',...
 'WQ_PHY_CRYPT_IP',...
 'WQ_PHY_EDIAT',...
 'WQ_PHY_EDIAT_IN',...
 'WQ_PHY_EDIAT_IP',...
 'WQ_PHY_LDIAT',...
 'WQ_PHY_LDIAT_IN',...
 'WQ_PHY_LDIAT_IP',...
 'WQ_BIV_FILTFRAC',...
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
outputdirectory = 'F:\Temp_Plots/Erie/tfv_009_AED_BIV_Met_cgm1_1/';

htmloutput = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Erie\Model_Results/v9_A3/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________

 ncfile(1).name = 'T:\tfv_009_AED_BIV_Met_A3\Output/erie_AED.nc';
 ncfile(1).symbol = {'-';'-'};
 ncfile(1).colour = {[0  96 100]./255,[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(1).legend = 'v09I';
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
def.datearray = datenum(yr,05:01:13,01);

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
