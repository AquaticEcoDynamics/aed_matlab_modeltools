% Configuration____________________________________________________________
 


fielddata_matfile = '.\swan.mat';
fielddata = 'swan';

polygon_file = '.\gis\swan_erz_subbox.shp';
yr = 2015;
rgh = '2015_2016';

varname = {...
    'WQ_NCS_SS1',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
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
    'WQ_PHY_GRN',...
    'SAL',...
    'TEMP',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
     };
	varname_human = {...
    'Suspended Solid',...
    'Total Nitrogen',...
    'Total Phosphorus',...
    'Oxygen',...
    'Silica',...
    'Ammonium',...
    'Nitrat',...
    'Phosphate (PO_4)',...
    'Phosphorus (ADS)',...
    'Dissolved Organic Carbon',...
    'Particulate Organic Carbon',...
    'Dissolved Organic Nitrogen',...
    'Particulate Organic Nitrogen',...
    'Dissolved Organic Phosphorus',...
    'Particulate Organic Phosphorus',...
    'Green Algae',...
    'Salinity',...
    'Temperature',...
    'Total Chlorophyll a',...
    'Total Suspended Solid',...
    'Turbidity',...
     }; 
	 start_plot_ID = 1;
%      end_plot_ID = 18;


% def.cAxis(1).value = [0 20];
% def.cAxis(2).value = [0 55];
%def.cAxis(1).value = [5 45];


%polygon_file = 'GIS/CEWH_Reporting.shp';
%changed the polygon file loc
plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotmodel = 1;

%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

add_error = 1;

add_human = 1;












plotvalidation = 1; % true or false

%----------- define plot options ------------%
plotdepth = {'surface','bottom'};%{'surface','bottom'}; % Cell with either one or both
istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 0;
isRange = 1;
isRange_Bottom = 1;
custom_datestamp = 0;

filetype = 'eps';
def.expected = 0; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];
isMEF = 1;
isSaveErr = 1;
ErrFilename = 'swan_2018.mat';
% ____________________________________________________________Configuration

% Models___________________________________________________________________



outputdirectory = ['Z:\Swan\SCERM\SCERM\SWAN_plotting\SCERM44_2015_2016_newIC_v2\'];
% htmloutput = ['.\error_2018_box_MEF\html\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

%nc file loc changed%
ncfile(1).name = 'Z:\Swan\SCERM\SCERM_v6\Output_v3\Output\SCERM44_2015_2016_newIC_ALL.nc';% change this to the nc file loc
ncfile(1).symbol = {'-';'-'};% top and bottom
ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom
ncfile(1).legend = 'SCERM44';
ncfile(1).translate = 1;
% 
% ncfile(2).name = ['Z:\Swan\SCERM\SCERM\Output\ALL\swan_2017_2018_ALL.nc'];
% ncfile(2).symbol = {'-';'-'};
% ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
% ncfile(2).legend = 'SCERM8';
% ncfile(2).translate = 1;
% 




% yr = 2015;
% def.datearray = datenum(yr,01:03:21,01);
%yr = 2009;
def.datearray = datenum(yr,03:03:09,15);

%def.datearray = datenum(yr,04:03:16,01);
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
