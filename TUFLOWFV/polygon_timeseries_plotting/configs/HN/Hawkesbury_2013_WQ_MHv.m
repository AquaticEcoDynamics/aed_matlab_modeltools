
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


%fielddata_matfile = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata_matfile = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

%polygon_file = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/gis/HN_Calibration_v3.shp';
polygon_file = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/gis/HN_Calibration_v3.shp';



varname = {...
    'WQ_OXY_OXY',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_OGM_DOC',...
    'WQ_OGM_DON',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'TEMP',...
    'SAL',...
    'ECOLI_SIMPLE',...
    'ENTEROCOCCI_SIMPLE',...    
    'HSI_CYANO',...
};


def.cAxis(1).value = [0 13];            %'WQ_OXY_OXY',...
def.cAxis(2).value = [0 0.5];	        %'WQ_NIT_AMM',...
def.cAxis(3).value = [0 0.8];           %'WQ_NIT_NIT',...
def.cAxis(4).value = [0 0.1];             %'WQ_PHS_FRP',...
def.cAxis(5).value = [0 15];           %'WQ_OGM_DOC',...
def.cAxis(6).value = [0 0.65];            %'WQ_OGM_DON',...
def.cAxis(7).value = [0 60];           %'WQ_DIAG_PHY_TCHLA',...
def.cAxis(8).value = [0 3];           %'WQ_DIAG_TOT_TN',...
def.cAxis(9).value = [0 0.3];           %'WQ_DIAG_TOT_TP',...
def.cAxis(10).value = [0 15];           %'WQ_DIAG_TOT_TOC',...
def.cAxis(11).value = [0 100];           %'WQ_DIAG_TOT_TSS',...
def.cAxis(12).value = [0 200];         %'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(13).value = [5 40];           %'Temp',...
def.cAxis(14).value = [0 40];         %'SAL',...
def.cAxis(15).value = [0 500];           %'Temp',...
def.cAxis(16).value = [0 500];           %'Temp',...
def.cAxis(17).value = [0 1.3];           %'Temp',...

start_plot_ID = 15;
sites = [8:1:22];

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';};%'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

isHTML = 1;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

depth_range = [0.5 100];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


%outputdirectory = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A1a_2017/plotting/Plots_V6/';
%htmloutput = ['/Volumes/AED/Hawkesbury/HN_Cal_v6_A1a_2017/plotting/Plots_V6/'];
outputdirectory = '~/Dropbox/HawkesburyNepean/HN_Cal_v6/Plots_MH_wq_v/2013/';
htmloutput = ['~/Dropbox/HawkesburyNepean/HN_Cal_v6/Plots_MH_wq_v/2013/html/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'V6';
 ncfile(1).translate = 1;
  
% ncfile(2).name = 'N:\Hawkesbury\HN_Cal_v5_A8\output\HN_Cal_2017_2018_WQ.nc';
% ncfile(2).symbol = {'-';'--'};
% ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
% ncfile(2).legend = 'V5 A8';
% ncfile(2).translate = 1;

 
yr = 2013;
def.datearray = datenum(yr,07:02:19,01);
%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [14 6]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 9;
def.ylabelsize = 9;
def.titlesize = 12;
def.legendsize = 7;
def.legendlocation = 'northeastoutside';

def.visible = 'off'; % on or off
