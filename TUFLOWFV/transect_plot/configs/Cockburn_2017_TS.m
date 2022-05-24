
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../SCERM/matlab/modeltools/matfiles/swan.mat';
fielddata = 'swan';

points_file = '/Projects2/Jayden/Cockburn_v1_2018/Matlab/gis/Cockburn_transect_pnt.shp';


t_yr = 2017;
int = 1;



%Seasons
def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,09,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,03,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,06,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,12,01) datenum(t_yr+2,03,01)];int = int + 1;
def.pdates(int).value = [datenum(2017,03,01) datenum(2018,03,01)];int = int + 1;
def.pdates(int).value = [datenum(2018,03,01) datenum(2019,03,01)];int = int + 1;



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

def.xlim = [0 60];% xlim in KM
def.xticks = [0:5:60];
def.xlabel = 'Distance from Ocean (km)';


%varname = {...
%    'TN_TP',...
%    };
%
%def.cAxis(1).value = [0 150];    		%'TN_TP',...
 varname = {...
     'TEMP',...
     'SAL',...

 };
  	varname_human = {...
    'Temperature',...
    'Salinity',...
     };
 

 def.cAxis(1).value = [5 40];           %'Temp',...
 def.cAxis(2).value = [0 40];         %'SAL',...

 

%start_plot_ID = 12;
% end_plot_ID = 13;
%plot_array = [12 13];

%plot_array = [3 6 12 13];

%start_plot_ID = 25;
use_matfiles = 0;
add_human = 1;

% Add field data to figure
plotvalidation = 0; % 1 or 0


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isHTML = 1;
isSurf = 0; %plot surface (1) or bottom (0)
clip_depth = 0.1;% in m
add_shapefile_label = 0;

add_trigger_values = 0;

%trigger_file = 'TriggerValues_HN.xlsx';

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects2/Jayden/Cockburn_v1_2018/Plots/Transect2/RAW/';
htmloutput = ['/Projects2/Jayden/Cockburn_v1_2018/Plots/Transect2/HTML/'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Projects2/Jayden/Cockburn_v1_2018/Output/Cockburn_2017_2018_bak.nc';
 ncfile(1).legend = 'v1';
%  
% ncfile(2).name = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/HN_Cal_2013_2016_3D_wq_Background_WQ.nc'; 
%ncfile(2).legend = 'Background';
%
% ncfile(3).name = '/Projects2/Cattai/HN_CC_Cal_v1_A7_Scenarios/output/HN_Cal_2013_2016_3D_wq_Impact_WQ.nc'; 
% ncfile(3).legend = 'Impact';
%
 def.boxlegend = 'northwest';
def.rangelegend = 'northeast';


def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
