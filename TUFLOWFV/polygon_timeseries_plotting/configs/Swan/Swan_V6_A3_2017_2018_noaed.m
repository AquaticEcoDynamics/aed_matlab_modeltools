% Configuration____________________________________________________________
 


fielddata_matfile = '..\..\..\SCERM\matlab\modeltools\matfiles\swan.mat';
fielddata = 'swan';

polygon_file = '..\..\..\SCERM\matlab\modeltools\gis\swan_erz_subbox_v2.shp';

yr = 2017;
rgh = '2017_2018';


varname = {...
%      'WQ_DIAG_TOT_TN',...
%      'WQ_DIAG_TOT_TP',...
%      'WQ_DIAG_TOT_TSS',...
%      'WQ_DIAG_TOT_TURBIDITY',...
%      'WQ_NCS_SS1',...
%     'WQ_OXY_OXY',...
%     'WQ_SIL_RSI',...
%     'WQ_NIT_AMM',...
%     'WQ_NIT_NIT',...
%     'WQ_PHS_FRP',...
%     'WQ_PHS_FRP_ADS',...
%     'WQ_OGM_DOC',...
%     'WQ_OGM_POC',...
%     'WQ_OGM_DON',...
%     'WQ_OGM_PON',...
%     'WQ_OGM_DOP',...
%     'WQ_OGM_POP',...
%     'WQ_PHY_GRN',...
   'SAL',...
    'TEMP',...
     };
int = 1;

def.cAxis(int).value = [0 40 ];int = int + 1; %    'SAL',...
def.cAxis(int).value = [0 30 ];int = int + 1; %    'TEMP',...


%changed the polygon file loc
plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotmodel = 1;

%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

plotvalidation = 1; % true or false

%----------- define plot options ------------%
plotdepth = {'surface';'bottom'};%;'bottom'};%{'surface','bottom'}; % Cell with either one or both
istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 1;
custom_datestamp = 0;

filetype = 'eps';
def.expected = 0; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = ['F:\Junk\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB\SCERM_v6\V6_A3\',rgh,'_noAED\RAW\'];
htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB\SCERM_v6\V6_A3\',rgh,'_noAED\HTML\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

%nc file loc changed%
ncfile(1).name = ['N:\SCERM\SCERM_v6_A3\Output_plt/SCERM8_2017_2018_noAED_ALL.nc'];% change this to the nc file loc
ncfile(1).symbol = {'-';'-'};% top and bottom
ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
ncfile(1).legend = 'SCERM 8';
ncfile(1).translate = 1;
% 
ncfile(2).name = ['N:\SCERM\SCERM_v6_A3\Output_plt/SCERM44_2017_2018_noAED_ALL.nc'];% change this to the nc file loc
ncfile(2).symbol = {'-';'-'};
ncfile(2).colour = {'r','g'};%{[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
ncfile(2).legend = 'SCERM 44';
ncfile(2).translate = 1;
% 

% ncfile(3).name = ['N:\SCERM\SCERM_v6\Output/SCERM44_noAED_2017_2018_ALL.nc'];% change this to the nc file loc
% ncfile(3).symbol = {'-';'-'};
% ncfile(3).colour = {'g','g'};%{[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
% ncfile(3).legend = 'scerm44 new bin';
% ncfile(3).translate = 1;


% yr = 2015;
% def.datearray = datenum(yr,01:03:21,01);
%yr = 2009;
%def.datearray = datenum(yr,02:01:05,01);
def.datearray = datenum(yr,04:03:17,01);%def.datearray = datenum(yr,03:01:08,01);
def.dateformat = 'mmm-yy';
% Defaults_________________________________________________________________

% Makes start date, end date and datetick array

%def.datearray = datenum(yr,1:4:26,01);
%def.datearray = datenum(2011,06,07.2:0.05:7.45);

%def.datearray = datenum(yr-1,11:2:23,01);

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

def.visible = 'on'; % on or off
