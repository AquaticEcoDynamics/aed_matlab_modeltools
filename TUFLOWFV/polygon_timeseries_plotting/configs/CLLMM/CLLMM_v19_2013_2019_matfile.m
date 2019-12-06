
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'lowerlakes';




varname = {...
'SAL',...
'TEMP',...
'H',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_PHS_FRP',...
'WQ_SIL_RSI',...
'ON',...
'OP',...
'WQ_DIAG_PHY_TCHLA',...
'WQ_PHY_GRN',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_TOT_TURBIDITY',...
};


def.cAxis(1).value = [0 3];    %'SAL',...
def.cAxis(2).value = [5 40];    %'TEMP',...
def.cAxis(3).value = [0 2];	%'H',...
def.cAxis(4).value = [0 0.15];   %'WQ_NIT_AMM',...
def.cAxis(5).value = [0 0.5];     %'WQ_NIT_NIT',...
def.cAxis(6).value = [0 0.3];     %'WQ_PHS_FRP',...
def.cAxis(7).value = [0 60];   %'WQ_SIL_RSI',...
def.cAxis(8).value = [0 7.5];    %'ON',...
def.cAxis(9).value = [0 1];    %'OP',...
def.cAxis(10).value = [0 125];  %'WQ_DIAG_PHY_TCHLA',...
def.cAxis(11).value = [0 300];   %'WQ_PHY_GRN',...
def.cAxis(12).value = [0 7.5]; 	%'WQ_DIAG_TOT_TN',...
def.cAxis(13).value = [0 1]; 	%'WQ_DIAG_TOT_TP',...
def.cAxis(14).value = [0 150]; 	%'WQ_DIAG_TOT_TURBIDITY',...
polygon_file = 'GIS/CLLMM/CEWH_Reporting.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface'};%;'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 0;
isylabel = 0;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'H:\Lowerlakes-CEW-Results\Regions\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________


 ncfile(1).name = 'G:\Lowerlakes-CEW-Results\Processed_v2\lower_lakes';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {'b','b'}; % Surface and Bottom
 ncfile(1).legend = 'Obs';
 ncfile(1).translate = 1;
%  
 ncfile(2).name = 'G:\Lowerlakes-CEW-Results\Processed_v2\lower_lakes_noCEW';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {'r','r'}; % Surface and Bottom
 ncfile(2).legend = 'No CEW';
 ncfile(2).translate = 1;
 
 ncfile(3).name = 'G:\Lowerlakes-CEW-Results\Processed_v2\lower_lakes_noEWater';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {'g','g'}; % Surface and Bottom
 ncfile(3).legend = 'No EWater';
 ncfile(3).translate = 1;
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
def.datearray = datenum(yr:01:2019,07,01);
%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [10 6]; % Width & Height in cm

def.dailyave = 1; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 12;
def.legendsize = 5;
def.legendlocation = 'northeast';

def.visible = 'off'; % on or off
