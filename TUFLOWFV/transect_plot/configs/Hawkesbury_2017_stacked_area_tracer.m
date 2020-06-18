%The is the configuration file for the transect plot stacked area function.


% Configuration____________________________________________________________



fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

points_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\Transectpnt_HN_100.shp';


t_yr = 2017;
int = 1;

def.pdates(int).value = [datenum(t_yr,05,01) datenum(t_yr,06,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,06,01) datenum(t_yr,07,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,08,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,08,01) datenum(t_yr,09,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,10,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,10,01) datenum(t_yr,11,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,11,01) datenum(t_yr,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,01,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,01,01) datenum(t_yr+1,02,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,02,01) datenum(t_yr+1,03,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,04,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,04,01) datenum(t_yr+1,05,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,05,01) datenum(t_yr+1,06,01)];int = int + 1;




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

def.xlim = [0 250];% xlim in KM
def.xticks = [0:20:250];
def.xlabel = 'Distance from Ocean (km)';


thevars = {...
    'WQ_PHY_GRN',...
    'WQ_PHY_BGA',...
    'WQ_PHY_FDIAT',...
    'WQ_PHY_MDIAT',...
};

thevars_conv = 12/50;

preproc = 0;
addmarker = 0;

%Field Var
varname = {'WQ_DIAG_PHY_TCHLA'};


def.cAxis(1).value = [0 60];         %'SAL',...
%def.cAxis(2).value = [5 25];         %'TEMP',...

% start_plot_ID = 1;
% end_plot_ID = 1;

%start_plot_ID = 25;


% Add field data to figure
plotvalidation = 1; % 1 or 0


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isHTML = 1;
isSurf = 1; %plot surface (1) or bottom (0)
% ____________________________________________________________Configuration

% Models___________________________________________________________________



outputdirectory = 'F:\Temp_Plots\Hawkesbury\HN_Cal_v5\plots_V5_A8_2017_1\';
htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v5_A8\2017_2018\Stacked-Area-Surface\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'N:\Hawkesbury\HN_Cal_v5_A8\output\HN_Cal_2017_2018_WQ.nc';
 ncfile(1).legend = 'V5_A8';
%
%  ncfile(2).name = 'T:/HN_Cal_v5/output/HN_Cal_2017_2018_kpo4_WQ.nc';
%  ncfile(2).legend = 'kPO4 == 0';



def.boxlegend = 'northwest';
def.rangelegend = 'northeast';

def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'on'; % on or off
