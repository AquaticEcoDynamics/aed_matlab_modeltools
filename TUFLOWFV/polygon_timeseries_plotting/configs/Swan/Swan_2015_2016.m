% Configuration____________________________________________________________
 


fielddata_matfile = '..\..\..\SCERM\matlab\modeltools\matfiles\swan.mat';
fielddata = 'swan';

polygon_file = '..\..\..\SCERM\matlab\modeltools\gis\swan_erz_subbox.shp';
yr = 2015;
rgh = '2015_2016';


 varname = {...
        'WQ_NCS_SS1',...
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
     };
 

% varname = {...
%     'SAL',...
%     'TEMP',...
%     };

% def.cAxis(1).value = [0 20];
% def.cAxis(2).value = [0 55];
for vvvv=1:length(varname)
def.cAxis(vvvv).value = [ ];
end

%changed the polygon file loc
plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotmodel = 1;

%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

plotvalidation = 1; % true or false

%----------- define plot options ------------%
plotdepth = {'surface';'bottom'};%{'surface','bottom'}; % Cell with either one or both
istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 0;
isRange = 1;
isRange_Bottom = 1;
custom_datestamp = 0;

filetype = 'eps';
def.expected = 0; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];

% ____________________________________________________________Configuration

% Models___________________________________________________________________



outputdirectory = ['Y:\Swan\SCERM_v7\Output\',rgh,'\RAW\'];
htmloutput = ['Y:\Swan\SCERM_v7\Output\',rgh,'\HTML\'];
%_______________________________________________________Configuration

% Models___________________________________________________________________

%nc file loc changed%
ncfile(1).name = ['Y:\Swan\SCERM_v7\Output/SCERM44_2015_2016_basecase_test_ALL.nc'];% change this to the nc file loc
ncfile(1).symbol = {'-';'-'};% top and bottom
ncfile(1).colour = {[0 96 100]./255,[62 39 35]./255}; % Surface and Bottom
ncfile(1).legend = 'Model';
ncfile(1).translate = 1;
% 
% ncfile(2).name = ['R:\SCERM/swan_',rgh,'_rst_ALL.nc'];
% ncfile(2).symbol = {'-';'-'};
% ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
% ncfile(2).legend = 'Model';
% ncfile(2).translate = 1;
% 




% yr = 2015;
% def.datearray = datenum(yr,01:03:21,01);
%yr = 2009;

def.datearray = datenum(yr,02:03:16,01);

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
