
% SITE Configuration_______________________________________________________
fielddata_matfile = '../../../Lake-Erie/matlab/modeltools/matfiles/erie.mat';
fielddata = 'erie';

polygon_file = '../../../Lake-Erie/matlab/modeltools/gis/erie_validation_v4.shp';

sites = [33,1,2,3,4,5,6,7,8,9,10,15,16,29,34,35,36,37];  % Sites in shapefile (polygon IDs) to plot
% ____________________________________________________________Configuration





% VAR Configuration________________________________________________________
varname = {...
	'WQ_DIAG_MAG_NMP_BEN',...
	'WQ_DIAG_MAG_CGM_FPHO_BEN',...
	'WQ_DIAG_MAG_IP_BEN',...
	'WQ_DIAG_MAG_PUP_BEN',...
	'WQ_DIAG_MAG_TMALG',...
'WQ_DIAG_MAG_CGM_FI_BEN',...
'WQ_DIAG_MAG_CGM_FT_BEN',...
'WQ_DIAG_MAG_CGM_FNIT_BEN',...
'WQ_DIAG_MAG_CGM_FSAL_BEN',...
'WQ_DIAG_MAG_CGM_C2P_BEN',...
'WQ_DIAG_MAG_CGM_C2N_BEN',...
'WQ_DIAG_MAG_CGM_N2P_BEN',...
'WQ_DIAG_MAG_MAG_BEN',...
'WQ_DIAG_MAG_CGM_SLTG',...
'WQ_DIAG_MAG_CGM_TAVG',...
'WQ_DIAG_MAG_CGM_LAVG',...
'WQ_DIAG_MAG_CGM_SAVG',...
'WQ_DIAG_MAG_HGTC',...
'WQ_DIAG_MAG_IN_BEN',...
'WQ_DIAG_MAG_GPP_BEN',...
'WQ_DIAG_MAG_RSP_BEN',...
'WQ_DIAG_MAG_NUP_BEN',...
'WQ_DIAG_MAG_SLG_BEN',...
'WQ_DIAG_MAG_CGM_DW_BEN',...
'WQ_DIAG_MAG_MAG_SWI_C',...
'WQ_DIAG_MAG_MAG_SWI_N',...
'WQ_DIAG_MAG_MAG_SWI_P',...
'WQ_DIAG_MAG_EXTC',...
'WQ_DIAG_MAG_PARC',...
'WQ_DIAG_MAG_CGM_FI',...
'WQ_DIAG_MAG_CGM_FNIT',...
'WQ_DIAG_MAG_CGM_FPHO',...
'WQ_DIAG_MAG_CGM_FT',...
'WQ_DIAG_MAG_CGM_FSAL',...
'WQ_DIAG_MAG_CGM_C2P',...
'WQ_DIAG_MAG_CGM_C2N',...
'WQ_DIAG_MAG_CGM_N2P',...
'WQ_DIAG_MAG_IN',...
'WQ_DIAG_MAG_IP',...
'WQ_DIAG_MAG_GPP',...
'WQ_DIAG_MAG_PUP',...
'WQ_DIAG_MAG_NUP',...
'WQ_DIAG_MAG_NMP',...
'WQ_DIAG_TOT_PAR',...
'WQ_DIAG_TOT_EXTC',...
};

for i = 1:length(varname)
	def.cAxis(i).value = [];
end
%def.cAxis(1).value = [0 0.001];   %'WQ_DIAG_TOT_TN',...
%def.cAxis(2).value = [0 0.25];  %'WQ_DIAG_TOT_TP',...
%def.cAxis(3).value = [0 15];   %'WQ_DIAG_TOT_TOC',...
%def.cAxis(4).value = [0 600];	%'WQ_DIAG_TOT_TSS',...
%def.cAxis(5).value = [0 750];  %'WQ_DIAG_TOT_LIGHT',...
%def.cAxis(6).value = [0 400];  %'WQ_DIAG_TOT_PAR',...
%def.cAxis(7).value = [0 50];  %'WQ_DIAG_TOT_UV',...
%def.cAxis(8).value = [0 2];   %'WQ_DIAG_TOT_EXTC',...
%def.cAxis(9).value = [0 50];   %'WQ_DIAG_PHY_TCHLA',...
% ____________________________________________________________Configuration

mean_style = 1;

% PLOT Configuration_______________________________________________________
plottype = 'timeseries'; %timeseries or 'profile'

plotvalidation = true; % Add field data to figure (true or false)

plotdepth = {'bottom'};  % Cell-array with either one or both
%plotdepth = {'bottom'};  % Cell-array with either one or both

istitled = 1;
isylabel = 1;
islegend = 1;
isYlim   = 0;
isRange  = 0;
isRange_Bottom = 0;
Range_ALL = 0;

filetype = 'eps';
def.expected = 1; % plot expected WL

isFieldRange = 1;
fieldprctile = [10 90];


%depth_range = [0.05 200];



isHTML = 0;
htmloutput = '/AED/Development/matt/Erie/Lake-Erie/models/erie_tfv_aed_2013_ver012_rev0/Plots_0c4/bottom/_html/'; % '/Projects2/Erie/Plots/Erie_TFVAED_v11e/bottom/_html/';
outputdirectory = '/AED/Development/matt/Erie/Lake-Erie/models/erie_tfv_aed_2013_ver012_rev0/Plots_0c4/bottom/';
% ____________________________________________________________Configuration




% Models___________________________________________________________________


 ncfile(1).name = '/Projects2/Erie/v11/Output.b/erie_11_b_AED_diag.nc';
 ncfile(1).symbol = {'-';'-'};
 ncfile(1).colour = { '#3498db',[162  139  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(1).legend = 'v11b';
 ncfile(1).translate = 1;

 ncfile(2).name = '/AED/Development/matt/Erie/Lake-Erie/models/erie_tfv_aed_2013_ver012_rev0/Output/erie_12_c_AED_diag.nc';
 ncfile(2).symbol = {'-';'-'};
 ncfile(2).colour = {[0  0  0],[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(2).legend = 'ver012 c';
 ncfile(2).translate = 1;

 ncfile(3).name = '/AED/Development/matt/Erie/Lake-Erie/models/erie_tfv_aed_2013_ver012_rev0/Output/erie_12_b_AED_diag.nc';
 ncfile(3).symbol = {'-';'-'};
 ncfile(3).colour = { '#cb4335',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
 ncfile(3).legend = 'ver012 b';
 ncfile(3).translate = 1;

% ncfile(2).name = '/Projects2/Erie/v11/Output.a/erie_00_AED.nc';
% ncfile(2).symbol = {'-';'-'};
% ncfile(2).colour = { '#3498db',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
% ncfile(2).legend = 'v11a: new-mesh';
% ncfile(2).translate = 1;

% ncfile(2).name = '/Projects2/Erie/v11/Output.b/erie_11_b_AED.nc';
% ncfile(2).symbol = {'-';'-'};
% ncfile(2).colour = {'#1e8449',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
% ncfile(2).legend = 'v11b: slough';
% ncfile(2).translate = 1;

%ncfile(2).name = '/Projects2/Erie/v11/Output.c/erie_11_c_AED.nc';
%ncfile(2).symbol = {'-';'-'};
%ncfile(2).colour = {'#d1c4e9',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%ncfile(2).legend = 'v11c: DOP';
%ncfile(2).translate = 1;

%  ncfile(6).name = '/Volumes/T7/Erie/Output.04/erie_04_AED.nc';
%  ncfile(6).symbol = {'-';'-'};
%  ncfile(6).colour = {'#d1c4e9',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(6).legend = '04 50%mus';
%  ncfile(6).translate = 1;



%  ncfile(5).name = '/Volumes/T7/Erie/Output.07/erie_07_AED.nc';
%  ncfile(5).symbol = {'-';'-'};
%  ncfile(5).colour = {'#f7dc6f',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(5).legend = '07 -musfb';
%  ncfile(5).translate = 1;

%  ncfile(9).name = '/Volumes/T7/Erie/Output.09/erie_09_AED.nc';
%  ncfile(9).symbol = {'-';'-'};
%  ncfile(9).colour = {'#d68910',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(9).legend = '09 +MUS';
%  ncfile(9).translate = 1;
%
%  ncfile(10).name = '/Volumes/T7/Erie/Output.08/erie_08_AED.nc';
%  ncfile(10).symbol = {'-';'-'};
%  ncfile(10).colour = {'#ff8a65',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(10).legend = '08 +MUS,60%riv';
%  ncfile(10).translate = 1;
%
%   ncfile(11).name = '/Volumes/T7/Erie/Output.10/erie_10_AED.nc';
%   ncfile(11).symbol = {'-';'-'};
%   ncfile(11).colour = { '#cb4335',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%   ncfile(11).legend = '10 +MUS,60%riv,IC';
%   ncfile(11).translate = 1;

 % ___________________________________________________________________Models


 % ___________________________________________________________________Models


%
%
% % Models___________________________________________________________________
%
%  ncfile(1).name = '/Volumes/T7/Erie/Output.00/erie_00_AED.nc';
%  ncfile(1).symbol = {'-';'-'};
%  ncfile(1).colour = {[0  0  0],[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(1).legend = 'v10n';
%  ncfile(1).translate = 1;
%
%  ncfile(2).name = '/Volumes/T7/Erie/Output.01/erie_01_AED.nc';
%  ncfile(2).symbol = {'-';'-'};
%  ncfile(2).colour = { '#3498db',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(2).legend = '01 60%riv';
%  ncfile(2).translate = 1;
%
%  ncfile(3).name = '/Volumes/T7/Erie/Output.03/erie_03_AED.nc';
%  ncfile(3).symbol = {'-';'-'};
%  ncfile(3).colour = {'#21618c',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(3).legend = '03 60%w&c';
%  ncfile(3).translate = 1;
%
%  ncfile(4).name = '/Volumes/T7/Erie/Output.05/erie_05_AED.nc';
%  ncfile(4).symbol = {'-';'-'};
%  ncfile(4).colour = {'#aed581',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(4).legend = '05 40%gr';
%  ncfile(4).translate = 1;
%
%  ncfile(5).name = '/Volumes/T7/Erie/Output.06/erie_06_AED.nc';
%  ncfile(5).symbol = {'-';'-'};
%  ncfile(5).colour = {'#1e8449',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(5).legend = '06 60%riv,IC';
%  ncfile(5).translate = 1;
%
%  ncfile(6).name = '/Volumes/T7/Erie/Output.04/erie_04_AED.nc';
%  ncfile(6).symbol = {'-';'-'};
%  ncfile(6).colour = {'#d1c4e9',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(6).legend = '04 50%mus';
%  ncfile(6).translate = 1;
%
%  ncfile(7).name = '/Volumes/T7/Erie/Output.02/erie_02_AED.nc';
%  ncfile(7).symbol = {'-';'-'};
%  ncfile(7).colour = { '#a569bd',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(7).legend = '02 50%mus,60%riv';
%  ncfile(7).translate = 1;
%
%  ncfile(8).name = '/Volumes/T7/Erie/Output.07/erie_07_AED.nc';
%  ncfile(8).symbol = {'-';'-'};
%  ncfile(8).colour = {'#f7dc6f',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(8).legend = '07 -musfb';
%  ncfile(8).translate = 1;
%
%  ncfile(9).name = '/Volumes/T7/Erie/Output.09/erie_09_AED.nc';
%  ncfile(9).symbol = {'-';'-'};
%  ncfile(9).colour = {'#d68910',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(9).legend = '09 +MUS';
%  ncfile(9).translate = 1;
%
%  ncfile(10).name = '/Volumes/T7/Erie/Output.08/erie_08_AED.nc';
%  ncfile(10).symbol = {'-';'-'};
%  ncfile(10).colour = {'#ff8a65',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%  ncfile(10).legend = '08 +MUS,60%riv';
%  ncfile(10).translate = 1;
%
%   ncfile(11).name = '/Volumes/T7/Erie/Output.10/erie_10_AED.nc';
%   ncfile(11).symbol = {'-';'-'};
%   ncfile(11).colour = { '#cb4335',[62  39  35]./255};  % Surface and Bottom : RGB to match DEFAULT colour palette
%   ncfile(11).legend = '10 +MUS,60%riv,IC';
%   ncfile(11).translate = 1;
%
%  % ___________________________________________________________________Models


% Add virtual datasets to the plots
add_vdata = 1;

vdata(1).matfile = 'vdata/1274_out.mat';
vdata(1).fieldname  = 'vdata';
vdata(1).polygon = 33;
vdata(1).legend = 'CGM: 1274';
vdata(1).plotcolor = 'r';

vdata(2).matfile = 'vdata/1341_out.mat';
vdata(2).fieldname  = 'vdata';
vdata(2).polygon = 34;
vdata(2).legend = 'CGM: 1341';
vdata(2).plotcolor = 'r';

vdata(3).matfile = 'vdata/1345_out.mat';
vdata(3).fieldname  = 'vdata';
vdata(3).polygon = 35;
vdata(3).legend = 'CGM: 1345';
vdata(3).plotcolor = 'r';

vdata(4).matfile = 'vdata/1351_out.mat';
vdata(4).fieldname  = 'vdata';
vdata(4).polygon = 37;
vdata(4).legend = 'CGM: 1351';
vdata(4).plotcolor = 'r';

vdata(5).matfile = 'vdata/1353_out.mat';
vdata(5).fieldname  = 'vdata';
vdata(5).polygon = 36;
vdata(5).legend = 'CGM: 1353';
vdata(5).plotcolor = 'r';



% Defaults_________________________________________________________________

% Makes start date, end date and datetick array
%def.datearray = datenum(yr,0def.datearray = datenum(yr,01:4:36,01);
%def.datearray = datenum(yr,1:12:96,01);

yr = 2013;
def.datearray = datenum(yr,05:01:10,4);

def.dateformat = 'dd-mmm';
% Must have same number as variable to plot & in same order

def.dimensions = [14 6]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)

def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'m',[0.6 0.6 0.6]}; % Cell with same number of levels

def.font = 'Arial';

def.xlabelsize = 6;
def.ylabelsize = 6;
def.titlesize = 10;
def.legendsize = 5;
def.legendlocation = 'northeastoutside';

def.visible = 'off'; % on or off

alph = 0.5; % transparency
