
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

points_file = '../../../Hawkesbury/matlab/modeltools/gis/Cattai_Full_Transect.shp';


t_yr = 2013;
int = 1;


% def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,08,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr,08,01) datenum(t_yr,09,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,10,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr,10,01) datenum(t_yr,11,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr,11,01) datenum(t_yr,12,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,01,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr+1,01,01) datenum(t_yr+1,02,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr+1,02,01) datenum(t_yr+1,03,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,04,01)];int = int + 1;
% def.pdates(int).value = [datenum(t_yr+1,04,01) datenum(t_yr+1,05,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,05,01) datenum(t_yr+1,06,01)];int = int + 1;

%Seasons
%def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,09,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,12,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,03,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,06,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,12,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,12,01) datenum(t_yr+2,03,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+2,03,01) datenum(t_yr+2,06,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,09,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,03,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,06,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,12,01) datenum(t_yr+2,03,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+2,03,01) datenum(t_yr+2,06,01)];int = int + 1;
def.pdates(int).value = [datenum(2013,07,01) datenum(2014,07,01)];int = int + 1;
def.pdates(int).value = [datenum(2014,07,01) datenum(2015,07,01)];int = int + 1;
def.pdates(int).value = [datenum(2013,07,01) datenum(2013,08,01)];int = int + 1;


def.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.

def.binradius = 5;% in km;

%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.

def.linedist = 500;%  in m

def.xlim = [0 27];% xlim in KM
def.xticks = [0:5:27];
def.xlabel = 'Distance from HN (km)';


%varname = {...
%    'TN_TP',...
%    };
%
%def.cAxis(1).value = [0 150];    		%'TN_TP',...




 varname = {...
     'WQ_OXY_OXY',...
     'WQ_NIT_AMM',...
     'WQ_NIT_NIT',...
     'WQ_PHS_FRP',...
     'WQ_DIAG_PHY_TCHLA',...
     'WQ_DIAG_TOT_TN',...
     'WQ_DIAG_TOT_TP',...
     'WQ_DIAG_TOT_TSS',...
     'WQ_DIAG_TOT_TURBIDITY',...
     'TEMP',...
     'SAL',...
	 'ENTEROCOCCI_PASSIVE',...
	 'ECOLI_PASSIVE',...
 };
  	varname_human = {...
    'Dissolved Oxygen',...
    'Ammonia',...
    'NOx',...
    'FRP',...
    'Total Chlorophyll-A',...
    'Total Nitrogen',...
    'Total Phosphorus',...
    'TSS',...
	'Turbidity',...
    'Temperature',...
    'Salinity',...
    'ENTEROCOCCI',...
    'ECOLI',...
     }; 
 
 def.cAxis(1).value = [0 12.5];            %'WQ_OXY_OXY',...
 def.cAxis(2).value = [0 0.25];	        %'WQ_NIT_AMM',...
 def.cAxis(3).value = [0 25];           %'WQ_NIT_NIT',...
 def.cAxis(4).value = [0 0.1];             %'WQ_PHS_FRP',...
 def.cAxis(5).value = [0 20];           %'WQ_DIAG_PHY_TCHLA',...
 def.cAxis(6).value = [0 25];           %'WQ_DIAG_TOT_TN',...
 def.cAxis(7).value = [0 0.3];           %'WQ_DIAG_TOT_TP',...
 def.cAxis(8).value = [0 100];           %'WQ_DIAG_TOT_TSS',...
 def.cAxis(9).value = [0 150];         %'WQ_DIAG_TOT_TURBIDITY',...
 def.cAxis(10).value = [5 40];           %'Temp',...
 def.cAxis(11).value = [0 1];         %'SAL',...
 def.cAxis(12).value = [0 500];		%'ENTEROCOCCI'
 def.cAxis(13).value = [0 250];		%'ECOLI_SIMPLE'


%start_plot_ID = 1;
% end_plot_ID = 26;

%plot_array = [12 13];

add_human = 1;
use_matfiles = 1;

%start_plot_ID = 25;
%use_matfiles = 1;


% Add field data to figure
plotvalidation = 1; % 1 or 0

add_shapefile_label = 1;


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isHTML = 1;
isSurf = 1; %plot surface (1) or bottom (0)
clip_depth = 0.1;% in m

add_trigger_values = 1;

trigger_file = 'TriggerValues_HN.xlsx';


% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects/Cattai/Report_v3/Transect/CC_Full_2013-2015/RAW/';
htmloutput = ['/Projects/Cattai/Report_v3/Transect/CC_Full_2013-2015/HTML/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/HN_Cal_2013_2016_3D_wq_Baseline_WQ.nc';
 ncfile(1).legend = 'Baseline';
%  
 ncfile(2).name = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/HN_Cal_2013_2016_3D_wq_Background_WQ.nc'; 
ncfile(2).legend = 'Background';

 ncfile(3).name = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/HN_Cal_2013_2016_3D_wq_Impact_WQ.nc'; 
 ncfile(3).legend = 'Impact';
%
 def.boxlegend = 'northwest';
def.rangelegend = 'northeast';


def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
