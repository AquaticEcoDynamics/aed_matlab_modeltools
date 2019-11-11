
% Configuration____________________________________________________________
addpath(genpath('tuflowfv'));


fielddata = 'peel';




varname = {...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TN',...
% 'WQ_TRC_SS1',...
% 'WQ_TRC_AGE',...
% 'WQ_OXY_OXY',...
% 'WQ_SIL_RSI',...
% 'WQ_NIT_AMM',...
% 'WQ_NIT_NIT',...
% 'WQ_PHS_FRP',...
% 'WQ_PHS_FRP_ADS',...
% 'WQ_OGM_DOC',...
% 'WQ_OGM_POC',...
% 'WQ_OGM_DON',...
% 'WQ_OGM_PON',...
% 'WQ_OGM_DOP',...
% 'WQ_OGM_POP',...
% 'WQ_PHY_DINOF',...
% 'WQ_PHY_CYANO',...
% 'WQ_PHY_NODUL',...
% 'WQ_PHY_CHLOR',...
% 'WQ_PHY_CRYPT',...
};


% def.cAxis(1).value = [5 35];    %'TEMP',...
% def.cAxis(2).value = [0 20];    %'WQ_OXY_OXY',...
%def.cAxis(1).value = [0 50];    %'SAL',...
% def.cAxis(4).value = [-1 2];	%'H',...
% 
% def.cAxis(5).value = [0 0.6];     %'WQ_NIT_AMM',...
% def.cAxis(6).value = [0 1];     %'WQ_NIT_NIT',...
% def.cAxis(7).value = [0 1];     %'WQ_PHS_FRP',...
% def.cAxis(8).value = [0 100];   %'WQ_OGM_DOC',...
% def.cAxis(9).value = [0 10];    %'WQ_OGM_POC',...
% def.cAxis(10).value = [0 5];    %'WQ_OGM_DON',...
% def.cAxis(11).value = [0 3];    %'WQ_OGM_PON',...
% def.cAxis(12).value = [0 0.3];  %'WQ_OGM_DOP',...
% def.cAxis(13).value = [0 0.2];  %'WQ_OGM_POP',...
% def.cAxis(14).value = [0 100];  %'WQ_OGM_DOCR',...
% def.cAxis(15).value = [0 3];    %'WQ_OGM_DONR',...
% def.cAxis(16).value = [0 0.1];  %'WQ_OGM_DOPR',...
% def.cAxis(17).value = [0 100];  %'WQ_OGM_CPOM',...
% def.cAxis(18).value = [0 15];   %'WQ_PHY_GRN',...
% def.cAxis(19).value = [0 50];   %'WQ_PHY_CRYPT',...
% def.cAxis(20).value = [0 25];   %'WQ_PHY_DIATOM',...
% def.cAxis(21).value = [0 50];   %'WQ_PHY_DINO',...
% def.cAxis(22).value = [0 10];   %'WQ_PHY_DINO_IN',...
% def.cAxis(23).value = [0 10];   %'WQ_PHY_BGA',...
% def.cAxis(24).value = [0 1100]; %'WQ_PHY_BGA_RHO',...
% def.cAxis(25).value = [0 3];    %'WQ_MAG_CHAETOMORPHA',...
% def.cAxis(26).value = [0 0.05]; %'WQ_MAG_CHAETOMORPHA_IN',...
% def.cAxis(27).value = [0 0.01]; %'WQ_MAG_CHAETOMORPHA_IP',...
% def.cAxis(28).value = [0 1];    %'WQ_BIV_FILTFRAC',...
% def.cAxis(29).value = [0 50]; 	%'WQ_NCS_SS1',...
% def.cAxis(30).value = [0 50]; 	%'WQ_NCS_SS1',...
% def.cAxis(31).value = [0 12000];    %'WQ_DIAG_MAC_MAC_AG',...
% def.cAxis(32).value = [0 500]; 	%'WQ_DIAG_MALG_TMALG',...
% def.cAxis(33).value = [0 35]; 	%'WQ_DIAG_PHY_TCHLA',...
% def.cAxis(34).value = [0 8]; 	%'WQ_DIAG_TOT_TN',...
% def.cAxis(35).value = [0 1.5]; 	%'WQ_DIAG_TOT_TP',...


polygon_file = 'GIS/Erie/erie_sites.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 0;
isYlim = 0;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'H:\tfv_004_2013_MET_aed2_2018_BIV\Plots\Regions\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'H:\tfv_004_2013_MET_aed2_2018_BIV\Output\erie_AED_DIAG.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(1).legend = 'v11';
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
def.datearray = datenum(yr,05:03:17,01);
%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [10 6]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 7;
def.ylabelsize = 7;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'northeast';

def.visible = 'off'; % on or off
