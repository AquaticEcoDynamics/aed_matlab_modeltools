
% Configuration____________________________________________________________
 


fielddata_matfile = '..\..\..\Lake-Erie\matlab\modeltools\matfiles\erie.mat';
fielddata = 'erie';

polygon_file = '..\..\..\Lake-Erie\matlab\modeltools\gis\erie_validation_v4.shp';



varname = {...
    'TEMP',...
    'WQ_CAR_DIC',...
    'WQ_CAR_PH',...
    'WQ_DIAG_CAR_TALK',...
    'WQ_DIAG_MAG_MAG_IP',...
    'WQ_DIAG_MAG_TMALG',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_PHY_TCHLA_PH',...
    'WQ_DIAG_SIL_TSI',...
    'WQ_DIAG_TOT_PAR',...
    'WQ_DIAG_TOT_SECCHI',...
    'WQ_DIAG_TOT_TDN',...
    'WQ_DIAG_TOT_TDP',...
    'WQ_DIAG_TOT_TKN',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'WQ_GEO_ACIDITY',...
    'WQ_GEO_CA',...
    'WQ_GEO_CL',...
    'WQ_GEO_K',...
    'WQ_GEO_MG',...
    'WQ_GEO_NA',...
    'WQ_GEO_SO4',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_NIT_NITRITE',...
    'WQ_OGM_DIC',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_PON',...
    'WQ_OGM_POP',...
    'WQ_OXY_OXY',...
    'WQ_PHS_FRP',...
    'WQ_SIL_RSI',...
    'WQ_SIL_RSI_TOT',...
};


def.cAxis(1).value = [0 30];    %'WQ_NCS_SS1',...
def.cAxis(2).value = [0 150];    %'WQ_TRC_AGE',...
def.cAxis(3).value = [0 20];    %'WQ_OXY_OXY',...
def.cAxis(4).value = [0 10];	%'WQ_SIL_RSI',...
def.cAxis(5).value = [0 0.5];   %'WQ_NIT_AMM',...
def.cAxis(6).value = [0 150];     %'WQ_NIT_NIT',...
def.cAxis(7).value = [0 0.2];     %'WQ_PHS_FRP',...
def.cAxis(8).value = [0 10];   %'WQ_OGM_DOC',...
def.cAxis(9).value = [0 5];    %'WQ_OGM_POC',...
def.cAxis(10).value = [0 0.75];    %'WQ_OGM_DON',...
def.cAxis(11).value = [0 0.75];    %'WQ_OGM_PON',...
def.cAxis(12).value = [0 0.1];  %'WQ_OGM_DOP',...
def.cAxis(13).value = [0 0.2];  %'WQ_OGM_POP',...
def.cAxis(14).value = [0 10];  %'WQ_PHY_CYANO',...
def.cAxis(15).value = [0 20];    %'WQ_PHY_CHLOR',...
def.cAxis(16).value = [0 125];  %'WQ_PHY_CRYPT',...
def.cAxis(17).value = [0 2];  %'WQ_PHY_EDIAT',...
def.cAxis(18).value = [0 15];   %'WQ_PHY_LDIAT',...
def.cAxis(19).value = [0 150];   %'WQ_MAG_CGM',...
def.cAxis(20).value = [0 1];   %'WQ_BIV_FILTFRAC',...


plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;
isYlim = 0;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 1;
plotmodel = 0;
filetype = 'eps';
def.expected = 1; % plot expected WL


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'F:\Erie_plotting\Plots\Base\';
htmloutput = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Erie\Model_Results\Field_Data_2010_2018_v2\';% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'I:\tfv_008_AED_BIV\Output\erie_AED.nc';
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

yr = 2010;
def.datearray = datenum(yr:01:2018,01,01);
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
