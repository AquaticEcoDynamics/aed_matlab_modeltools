
 

% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm.mat';

fielddata = 'cllmm';
polygon_file = '/Projects2/busch_github/CDM/gis/supplementary/HCHB_Report_Sites.shp';




% VAR Configuration________________________________________________________
varname = {...
'WQ_DIAG_MA2_TMALG',...
'SAL',...
'TEMP',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_PHY_TCHLA',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_DIAG_TOT_TP',...
'WQ_PHS_FRP',...
'WQ_OXY_OXY',...
'WQ_DIAG_TOT_TSS',...
'WQ_DIAG_TOT_TOC',...
'WQ_OGM_DOC',...
'WQ_DIAG_TOT_TURBIDITY',...
};

% def.cAxis(1).value = [0 100];
% def.cAxis(2).value = [0 100];

for vvvv=1:length(varname)
def.cAxis(vvvv).value = [ ];
end
%def.cAxis(3).value = [0 150];
% ____________________________________________________________Configuration

start_plot_ID = 1;
% end_plot_ID = 4;
% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'surface'};  % Cell-array with either one or both
depth_range = [0.5 100];
validation_minmax = 0;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 1;
isRange  = 1;
isRange_Bottom = 0;
Range_ALL = 1;
add_error = 1;

mean_style = 2;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

isHTML = 1;

yr = 2017;
def.datearray = datenum(yr,13:6:61,1);

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = '/Projects2/CDM/Report_Images/GEN15_ALS/RAW/';
htmloutput = '/Projects2/CDM/Report_Images/GEN15_ALS/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________
 ncfile(1).name =  '/Projects2/CDM/HCHB_scenario_assessment/MER_Coorong_eWater_2022_GEN15_newBC_testing/output_basecase_waves/eWater2021_basecase_t3_wave_all.nc';
 %'/Projects2/CDM/HCHB_scenario_assessment/output_basecase_mag5a/eWater2021_basecase_t3_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[31,120,180]./255,[31,120,180]./255}; % Surface and Bottom
 ncfile(1).legend = 'GEN 1.5';
 ncfile(1).translate = 1;
% % 

% 
%  

% ___________________________________________________________________Models



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array


def.dateformat = 'mm/yyyy';
% Must have same number as variable to plot & in same order

def.dimensions = [20 8]; % Width & Height in cm

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
