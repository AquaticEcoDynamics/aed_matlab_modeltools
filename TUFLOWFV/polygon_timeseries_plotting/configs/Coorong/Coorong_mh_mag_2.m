


% SITE Configuration_______________________________________________________
% fielddata_matfile = 'lowerlakes.mat';
% fielddata = 'lowerlakes';

fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm.mat';
%fielddata = 'UA';
fielddata = 'cllmm';
%polygon_file = '../../../CDM/gis/supplementary/Coorong/Coorong_obs_sites.shp';
%polygon_file = '../../../CDM/gis/supplementary/Coorong_IC_regions.shp';
polygon_file = '/Projects2/CDM/hchb_tfvaed_v3_2022_4PFTs/model/gis/shp/31_material_zones_names.shp';

%sites = [5:23];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration



varname = {
'WQ_DIAG_PHY_MPB_RES',...
'WQ_DIAG_PHY_IN',...
'WQ_DIAG_MAG_TMALG',...
'WQ_DIAG_TOT_TOC',...
'WQ_OGM_DOC',...
'WQ_OGM_POC',...
'WQ_DIAG_TOT_TSS',...
'WQ_DIAG_TOT_TURBIDITY',...
'WQ_MAG_ULVA_C',...
  'WQ_DIAG_TOT_EXTC',...
};

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
depth_range = [0.2 100];
validation_minmax = 0;

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 1;
isRange  = 1;
isRange_Bottom = 0;
Range_ALL = 1;
add_error = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 0;
fieldprctile = [10 90];

isHTML = 1;

yr = 2017;
def.datearray = datenum(yr,7:6:65,1); %55

%outputdirectory = './Timeseries_Basecase_June/RAW/';
%htmloutput = './Timeseries_Basecase_June/HTML/';
outputdirectory = '/AED/Development/matt/hchb_tfvaed_v3_2022_4PFTs_SedZone_sdg/plots31_MAG_eWater_13June_a/RAW/';
htmloutput = '/AED/Development/matt/hchb_tfvaed_v3_2022_4PFTs_SedZone_sdg/plots31_MAG_eWater_13June_a/HTML/';
% ____________________________________________________________Configuration





% Models___________________________________________________________________

 ncfile(1).name = '/Scratch/MER_Coorong_eWater_2022_GEN15_newBC_testing/output_basecase_mag5a/eWater2021_basecase_t3_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[106,61,154]./255,[106,61,154]./255}; % Surface and Bottom
 ncfile(1).legend = 'mag5a';
 ncfile(1).translate = 1;

 ncfile(3).name = '/Scratch/MER_Coorong_eWater_2022_GEN15_newBC_testing/output_basecase_hd/eWater2021_basecase_t3_all.nc';
 ncfile(3).symbol = {'-';'--'};
 ncfile(3).colour = {[153,213,148]./255,[1,102,94]./255}; % Surface and Bottom
 ncfile(3).legend = 'mag12';
 ncfile(3).translate = 1;

 ncfile(2).name = '/Scratch/MER_Coorong_eWater_2022_GEN15_newBC_testing/output_basecase_mag11/eWater2021_basecase_t3_all.nc';
%ncfile(2).name = '/Projects2/CDM/output_basecase_hd/eWater2021_basecase_t3_all.nc';
 ncfile(2).symbol = {'-';'--'};
 ncfile(2).colour = {[230,245,152]./255,[1,102,94]./255};% Surface and Bottom
 ncfile(2).legend = 'mag11';
 ncfile(2).translate = 1;


% % %
%  ncfile(4).name = '/Projects2/CDM/hchb_tfvaed_v3_2022_4PFTs/output_matt_SDG3/hchb_wave_21901101_20210701_wq_v5_resuspension_all.nc';
%  ncfile(4).symbol = {'-';'--'};
%  ncfile(4).colour = {[230,245,152]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(4).legend = 'SDG3';
%  ncfile(4).translate = 1;
%
%  ncfile(5).name = 'Y:/CIIP/Scenarios/phase1/SC07/CoorongBGC_SC07_pump_in_out_reverse_500_ML_d_dry_001_wq_all.nc';
%  ncfile(5).symbol = {'-';'--'};
%  ncfile(5).colour = {[153,213,148]./255,[1,102,94]./255}; % Surface and Bottom
%  ncfile(5).legend = 'SC07';
%  ncfile(5).translate = 1;
%
%

% ___________________________________________________________________Models



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

% yr = 2012;
% def.datearray = datenum(yr,01:01:04,01);

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
