
% Configuration____________________________________________________________
 


fielddata_matfile = '../../../Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

polygon_file = '../../../Hawkesbury/matlab/modeltools/gis/Cattai_Plotting_Zones_v2.shp';



varname = {...
    'REL_HUM',...
    'LW_RAD',...
    'W10_x',...
    'W10_y',...
    'SW_RAD',...
    'AIR_TEMP',...
	'PRECIP',...
};


%def.cAxis(1).value = [0 100];    		%'WQ_NCS_SS1',...
%def.cAxis(2).value = [0 12.5];            %'WQ_OXY_OXY',...
%def.cAxis(3).value = [0 55];            %'WQ_SIL_RSI',...
%def.cAxis(4).value = [0 0.5];	        %'WQ_NIT_AMM',...
%def.cAxis(5).value = [0 0.6];           %'WQ_NIT_NIT',...
%def.cAxis(6).value = [0 0.1];             %'WQ_PHS_FRP',...
%def.cAxis(7).value = [0 0.07];             %'WQ_PHS_FRP_ADS',...
%def.cAxis(8).value = [0 15];           %'WQ_OGM_DOC',...
%def.cAxis(9).value = [0 2];            %'WQ_OGM_POC',...
%def.cAxis(10).value = [0 0.65];            %'WQ_OGM_DON',...
%def.cAxis(11).value = [0 1.5];            %'WQ_OGM_PON',...
%def.cAxis(12).value = [0 0.05];          %'WQ_OGM_DOP',...
%def.cAxis(13).value = [0 0.15];          %'WQ_OGM_POP',...
%def.cAxis(14).value = [0 60];          %'WQ_PHY_GRN',...
%def.cAxis(15).value = [0 100];            %'WQ_PHY_BGA',...
%def.cAxis(16).value = [0 50];          %'WQ_PHY_FDIAT',...
%def.cAxis(17).value = [0 10];          %'WQ_PHY_MDIAT',...
%def.cAxis(18).value = [0 125];           %'WQ_TRC_AGE',...
%def.cAxis(19).value = [0 60];           %'WQ_DIAG_PHY_TCHLA',...
%def.cAxis(20).value = [0 3];           %'WQ_DIAG_TOT_TN',...
%def.cAxis(21).value = [0 0.3];           %'WQ_DIAG_TOT_TP',...
%def.cAxis(22).value = [0 15];           %'WQ_DIAG_TOT_TOC',...
%def.cAxis(23).value = [0 100];           %'WQ_DIAG_TOT_TSS',...
%def.cAxis(24).value = [0 300];         %'WQ_DIAG_TOT_TURBIDITY',...
%def.cAxis(25).value = [5 40];           %'Temp',...
%def.cAxis(26).value = [];         %'SAL',...

for i = 1:length(varname)
    def.cAxis(i).value = [];
end

%start_plot_ID = 19;

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';};%'bottom'};%;'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isRange = 1;
isRange_Bottom = 1;
Range_ALL = 1;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

depth_range = [0.5 100];

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects2/Cattai/cattai_tfv_aed_v2/Plots/Timeseries/CHX/RAW/';
htmloutput = ['/Projects2/Cattai/cattai_tfv_aed_v2/Plots/Timeseries/CHX/HTML/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

  ncfile(1).name = '/Projects2/Cattai/cattai_tfv_aed_v2/output/CC_Cal_2017_2018_2_chx.nc'; 
%  ncfile(1).tfv = 'I:/Hawkesbury/HN_Cal_v3_noIC/output/HN_Cal_2013_HYDRO.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom % Surface and Bottom
 ncfile(1).legend = '2017 v2';
 ncfile(1).translate = 1;
%  
 %ncfile(2).name = '/Projects2/Cattai/cattai_tfv_aed_v2/output/CC_Cal_2017_2018_2_2036.nc'; 
 %ncfile(2).symbol = {'-';'--'};
 %ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 %ncfile(2).legend = '2036 v2';
 %ncfile(2).translate = 1;
 



yr = 2017;
def.datearray = datenum(yr,12:01:14,01);
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

def.visible = 'on'; % on or off
