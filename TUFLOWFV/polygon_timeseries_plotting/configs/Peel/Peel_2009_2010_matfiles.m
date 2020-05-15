
% Configuration____________________________________________________________
 


fielddata = 'peel';




 varname = {...
 'TEMP',...
 'WQ_OXY_OXY',...
 'SAL',...
 'WQ_OGM_DOC',...
 'WQ_OGM_DON',...
 'WQ_DIAG_TOT_TN',...
 'WQ_DIAG_TOT_TP',...
 'WQ_DIAG_PHY_TCHLA',....
 'WQ_DIAG_TOT_TURBIDITY',...
 'WQ_DIAG_MAG_TMALG',...
  'WQ_NIT_AMM',...
 };
% 
def.cAxis(1).value = [5 35];    %'TEMP',...
def.cAxis(2).value = [0 20];    %'WQ_OXY_OXY',...
def.cAxis(3).value = [0 50];    %'SAL',...
def.cAxis(4).value = [0 100];   %'WQ_OGM_DOC',...
def.cAxis(5).value = [0 5];    %'WQ_OGM_DON',...
def.cAxis(6).value = [0 15]; 	%'WQ_DIAG_TOT_TN',...
def.cAxis(7).value = [0 5]; 	%'WQ_DIAG_TOT_TP',...
def.cAxis(8).value = [0 35]; 	%'WQ_DIAG_PHY_TCHLA',...
def.cAxis(9).value = [0 500]; 	%'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(10).value = [0 500]; 	%'WQ_DIAG_MALG_TMALG',...
def.cAxis(11).value = [0 1]; 	%'WQ_NIT_AMM',...



polygon_file = 'GIS/Peel/peel_polygons.shp';

plottype = 'timeseries'; %timeseries or 'profile'
%plottype = 'profile'; % or 'profile'

% Add field data to figure
plotvalidation = true; % true or false

plotdepth = {'surface';'bottom'};%'bottom'}; % Cell with either one or both
%plotdepth = {'surface'};%,'bottom'}; % Cell with either one or both

istitled = 1;
isylabel = 0;
islegend = 0;
isYlim = 1;
isRange = 1;
Range_ALL = 1;
filetype = 'eps';
def.expected = 1; % plot expected WL
isRange_Bottom =  1;


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = 'Y:\Peel Final Report\Timeseries\2009_2010/';
% ____________________________________________________________Configuration

% Models___________________________________________________________________


 ncfile(1).name = 'Y:\Peel Final Report\Processed_v12_joined\run_2009_2010\';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]};  % Surface and Bottom
 ncfile(1).legend = '3D';
 ncfile(1).translate = 1;
 
 %ncfile(2).name = 'Y:\Peel Final Report\Processed v11\run_1980_1981\';
 %ncfile(2).symbol = {'-';'--'};
 %ncfile(2).colour = {[0.749019607843137 0.227450980392157 0.0039215686274509],[0.0509803921568627         0.215686274509804         0.968627450980392]};  % Surface and Bottom
 %ncfile(2).legend = '3D';
 %ncfile(2).translate = 1;
 
 
%  
yr = 2009;
def.datearray = datenum(yr,04:03:17,01);


%def.datearray = datenum(yr,01:1:4,01);

def.dateformat = 'mm-yy';
% Must have same number as variable to plot & in same order

def.dimensions = [10 6]; % Width & Height in cm

def.dailyave = 1; % 1 for daily average, 0 for off. Daily average turns off smoothing.
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
