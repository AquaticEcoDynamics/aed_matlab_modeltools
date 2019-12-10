% Configuration____________________________________________________________

fielddata = 'coorong_mini';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% varname = {'H'};
% def.cAxis(1).value = [0 2];

% varname = {...
%     'WQ_DIAG_MAG_TMALG',...
% };
varname = {...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_NIT_NIT',...
'WQ_PHS_FRP',...
};

def.cAxis(1).value = [0 100];
def.cAxis(2).value = [0 5]; 	%'WQ_DIAG_TOT_TN',...
def.cAxis(3).value = [0 1.5]; 	%'WQ_DIAG_TOT_TP',...
def.cAxis(4).value = [0 150]; 	%'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(4).value = [0 1]; 	%'WQ_DIAG_TOT_TURBIDITY',...



convert_units = 1; %1 ro 0;

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = false; % true or false

plotdepth = {'surface'};%;'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;

filetype = 'eps';
def.expected = 0; % plot expected WL

outputdirectory = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Lowerlakes\Coorong\Timeseries_Final\ORH_DEP\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

int = 1;
 ncfile(int).name = 'R:\Coorong-Local\Netcdf\ORH_Base_20140101_20170101.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(int).legend = 'ORH';
 ncfile(int).translate = 1;
  int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output-16\ORH_Base_Dep_False_20140101_20170101.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'b','b'}; % Surface and Bottom
 ncfile(int).legend = 'Dep. False';
 ncfile(int).translate = 1;
  int = int + 1;
%  ncfile(int).name = 'R:\Coorong-Output-16\SC40_NUT_1.5_20140101_20170101.nc';
%  ncfile(int).symbol = {'-';'--'};
%  ncfile(int).colour = {'g','g'}; % Surface and Bottom
%  ncfile(int).legend = 'SC40 NUTx1.5';
%  ncfile(int).translate = 1;
%  int = int + 1;
%  ncfile(int).name = 'R:\Coorong-Local\Netcdf\SC40_NUT_2.0_20140101_20170101.nc';
%  ncfile(int).symbol = {'-';'--'};
%  ncfile(int).colour = {'b','b'}; % Surface and Bottom
%  ncfile(int).legend = 'SC40 NUTx2.0';
%  ncfile(int).translate = 1;
% int = int + 1;

 
% ncfile(2).name = 'R:\Coorong\010_Ruppia_2015_2016_9_SC40_2Nut\Output\coorong.nc';
% ncfile(2).symbol = {'-';'--'};
% ncfile(2).colour = {'r','r'}; % Surface and Bottom
% ncfile(2).legend = '010';
% ncfile(2).translate = 1;


yr = 2014;
def.datearray = datenum(yr,04:04:17,01);
%def.datearray = datenum(yr,01,01:04:21);


%def.datearray = datenum(2011,06,07.2:0.05:7.45);

%def.datearray = datenum(yr-1,11:2:23,01);
def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [12 7]; % Width & Height in cm

def.dailyave = 0; % 1 for daily average, 0 for off. Daily average turns off smoothing.
def.smoothfactor = 3; % Must be odd number (set to 3 if none)


def.fieldsymbol = {'.','.'}; % Cell with same number of levels
def.fieldcolour = {'k','b'}; % Cell with same number of levels

def.font = 'Candara';

def.xlabelsize = 9;
def.ylabelsize = 9;
def.titlesize = 12;
def.legendsize = 6;
def.legendlocation = 'NE';

def.visible = 'on'; % on or off
