
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'erie';




varname = {...
    'WQ_DIAG_MAG_MAG_BEN',...
    'WQ_DIAG_MAG_IP',...
    'WQ_DIAG_MAG_IN',...
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
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_LIGHT',...
    'WQ_DIAG_TOT_PAR',...
    'WQ_DIAG_TOT_UV',...
    'WQ_DIAG_TOT_EXTC',...
    'WQ_DIAG_PHY_TCHLA',...
    
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



polygon_file = 'GIS/Erie/erie_validation_v4.shp';

plottype = 'timeseries'; %timeseries or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim   = 0;
isRange  = 0;
isRange_Bottom = 1;
Range_ALL = 1;
isHTML = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

sites = [17,18,20];
% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Plotting/Model_009_magA/';
%htmloutput = '/Volumes/Spinny/cloudstor/Shared/Aquatic Ecodynamics (AED)/AED_Erie/Model_Results/Older Results/tfv_009_met_fielddata_MAG/';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Volumes/Spinny/Sims/Lake-Erie/tfv_009_AED_BIV_Met/Output/erie_AED_diag.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = 'v09mag';
 ncfile(1).translate = 1;
%  
%  ncfile(2).name = 'J:\Historical\run_2016_BASE.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
%  ncfile(2).legend = 'Restart';
%  ncfile(2).translate = 1;
 
%  ncfile(2).name = 'K:\Peel_Scenarios\run_2016_2017.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {'r','k'}; % Surface and Bottom
%  ncfile(2).legend = 'v11';
%  ncfile(2).translate = 1;
%  
%  ncfile(3).name = 'K:\Peel_Scenarios\run_scenario_0a.nc';
%  ncfile(3).symbol = {'-';'--'};
%  ncfile(3).colour = {'b','k'}; % Surface and Bottom
%  ncfile(3).legend = '0a';
%  ncfile(3).translate = 1; 
%  
%  ncfile(4).name = 'K:\Peel_Scenarios\run_scenario_0b.nc';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {'g','k'}; % Surface and Bottom
%  ncfile(4).legend = '0a';
%  ncfile(4).translate = 1; 
%  ncfile(1).name = 'K:\Peel_Scenarios\run_scenario_0a.nc';
%  ncfile(1).symbol = {'-';'--'};
%  ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
%  ncfile(1).legend = '07';
%  ncfile(1).translate = 1;
 
 
% %  
%  ncfile(3).name = 'J:\Reruns\NCfiles\Base3\run_2017.nc';
%  ncfile(3).symbol = {'-';'--'};
%  ncfile(3).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
%  ncfile(3).legend = '07';
%  ncfile(3).translate = 1;
% 
%   ncfile(4).name = 'J:\Reruns\2018\run_2018.nc';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
%  ncfile(4).legend = '07';
%  ncfile(4).translate = 1;

%  ncfile(1).name = 'D:\Studysites\Lowerlakes\034_obs_AED2_LCFlow_IC2_NIT\Output\lower_lakes.nc';
%  ncfile(1).symbol = {'-';'--'};
%  ncfile(1).colour = {'b','b'}; % Surface and Bottom
%  ncfile(1).legend = 'v34';
%  ncfile(1).translate = 1;
%  
%  ncfile(2).name = 'D:\Studysites\Lowerlakes\035_obs_LL_Only_TFV_AED2_Inf\Output\lower_lakes.nc';
%  ncfile(2).symbol = {'-';'--'};
%  ncfile(2).colour = {'r','r'}; % Surface and Bottom
%  ncfile(2).legend = 'v35 LL';
%  ncfile(2).translate = 1;









% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

%def.datearray = datenum(yr,07:03:19,01);
% yr = 2015;
% def.datearray = datenum(yr,11:05:41,01);

yr = 2013;
def.datearray = datenum(yr,03:04:07,01);
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
