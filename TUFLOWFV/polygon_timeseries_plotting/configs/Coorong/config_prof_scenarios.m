% Configuration____________________________________________________________

fielddata = 'coorong_mini';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% varname = {'H'};
% def.cAxis(1).value = [0 2];

% varname = {...
%     'WQ_DIAG_MAG_TMALG',...
% };
ne = 'R:\Coorong-Output\ORH_Base_20140101_20170101_rst.nc';

vv = tfv_infonetcdf(ne);

varname = vv([20 21 24:end]);

def.cAxis(1).value = [0 150];
def.cAxis(2).value = [-1 2];
def.cAxis(3).value = [0 100];
def.cAxis(4).value = [0 35];
def.cAxis(5).value = [0 500];
def.cAxis(6).value = [0 0.5];
def.cAxis(7).value = [0 100];
def.cAxis(8).value = [0 20];
def.cAxis(9).value = [0 1000];
def.cAxis(10).value = [0 200];
def.cAxis(11).value = [0 0.1];
def.cAxis(12).value = [0 1];

% def.cAxis(4).value = [0 155];
% def.cAxis(5).value = [0 15];
% def.cAxis(6).value = [10 250];
% def.cAxis(7).value = [10 250];
% def.cAxis(8).value = [0 10];
% def.cAxis(9).value = [0 5];
% def.cAxis(10).value = [0 125];
% def.cAxis(11).value = [0 100];
% def.cAxis(12).value = [0 15];
% def.cAxis(13).value = [0 50];
% def.cAxis(14).value = [0 25];
% def.cAxis(15).value = [0 25];
% def.cAxis(16).value = [0 100];
% def.cAxis(17).value = [0 100];
% def.cAxis(18).value = [0 75];
% def.cAxis(19).value = [0 3000];
% def.cAxis(20).value = [0 2500];
% def.cAxis(21).value = [0 2.5];
% def.cAxis(22).value = [0 45];
% def.cAxis(23).value = [10 45];
% def.cAxis(24).value = [0 100];
% def.cAxis(25).value = [0 750];
% def.cAxis(26).value = [0 40];
% def.cAxis(27).value = [0 4000];
% def.cAxis(28).value = [0 250];
% def.cAxis(29).value = [0 2];
% def.cAxis(30).value = [0 15];
% def.cAxis(31).value = [0 10];

convert_units = 1; %1 ro 0;

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface'};%;'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 1;

filetype = 'eps';
def.expected = 0; % plot expected WL

outputdirectory = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Lowerlakes\Coorong\Scenarios\Point RST\';
% ____________________________________________________________Configuration

% Models___________________________________________________________________

int = 1;
 ncfile(int).name = 'R:\Coorong-Output\ORH_Base_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]}; % Surface and Bottom
 ncfile(int).legend = 'base';
 ncfile(int).translate = 1;
  int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\ORH_Base_Dep_False_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'r','r'}; % Surface and Bottom
 ncfile(int).legend = 'Deposition';
 ncfile(int).translate = 1;
  int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\ORH_Base_FSED2_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'g','g'}; % Surface and Bottom
 ncfile(int).legend = 'FSED 2 (0 broken)';
 ncfile(int).translate = 1;
 int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\ORH_Base_FSED2_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'b','b'}; % Surface and Bottom
 ncfile(int).legend = 'FSED 2';
 ncfile(int).translate = 1;
int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\ORH_SLR_02_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'m','m'}; % Surface and Bottom
 ncfile(int).legend = 'SLR';
 ncfile(int).translate = 1;
 int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\SC40_Base_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'-';'--'};
 ncfile(int).colour = {'y','y'}; % Surface and Bottom
 ncfile(int).legend = 'SC 40';
 ncfile(int).translate = 1;
 int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\SC40_NUT_1.5_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'--';'--'};
 ncfile(int).colour = {'g','r'}; % Surface and Bottom
 ncfile(int).legend = 'SC 40 Nut 1.5';
 ncfile(int).translate = 1;
 int = int + 1;
 ncfile(int).name = 'R:\Coorong-Output\SC40_NUT_2.0_20140101_20170101_rst.nc';
 ncfile(int).symbol = {'--';'--'};
 ncfile(int).colour = {'m','r'}; % Surface and Bottom
 ncfile(int).legend = 'SC 40 Nut 2';
 ncfile(int).translate = 1;
 
% ncfile(2).name = 'R:\Coorong\010_Ruppia_2015_2016_9_SC40_2Nut\Output\coorong.nc';
% ncfile(2).symbol = {'-';'--'};
% ncfile(2).colour = {'r','r'}; % Surface and Bottom
% ncfile(2).legend = '010';
% ncfile(2).translate = 1;


yr = 2014;
def.datearray = datenum(yr,05:03:16,01);
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
