%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../SCERM/matlab/modeltools/matfiles/swan.mat';
fielddata = 'swan';

points_file = '../../../SCERM/matlab/modeltools/gis/Swan_Transect_Pnt.shp';


int = 1;
theyear = 2015;
%Initial Condition
def.pdates(int).value = [datenum(theyear,03,15) datenum(theyear,03,25)];int = int + 1;

% Set up the time loops
for ii = 04:14

def.pdates(int).value = [datenum(theyear,ii,01) datenum(theyear,ii+1,01)];int = int + 1;

end




def.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.

def.binradius = 1;% in km;

%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.

def.linedist = 500;%  in m

def.xlim = [0 60];% xlim in KM
def.xticks = [0:10:60];
def.xlabel = 'Distance from Fremantle (km)';


varname = {...
     'WQ_DIAG_TOT_TN',...
     'WQ_DIAG_TOT_TP',...
     'WQ_DIAG_TOT_TSS',...
     'WQ_DIAG_TOT_TURBIDITY',...
    'WQ_OXY_OXY',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
    'WQ_OGM_DOP',...
    'WQ_OGM_POP',...
    'WQ_DIAG_PHY_TCHLA',...
    'SAL',...
    'TEMP',...
     };
% 
% 
int = 1;
def.cAxis(int).value=[0 5];		int = int + 1;% 'WQ_DIAG_TOT_TN',...
def.cAxis(int).value=[0 0.5];   int = int + 1;%  'WQ_DIAG_TOT_TP',...
def.cAxis(int).value=[0 50];    int = int + 1;%  'WQ_DIAG_TOT_TSS',...
def.cAxis(int).value=[0 75];    int = int + 1;%  'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(int).value=[0 20];    int = int + 1;%  'WQ_OXY_OXY',...
def.cAxis(int).value=[0 0.5];   int = int + 1;%  'WQ_NIT_AMM',...
def.cAxis(int).value=[0 0.5];   int = int + 1;%  'WQ_NIT_NIT',...
def.cAxis(int).value=[0 0.3];   int = int + 1;  %'WQ_PHS_FRP',...
def.cAxis(int).value=[0 35];    int = int + 1;  %'WQ_OGM_DOC',...
def.cAxis(int).value=[0 10];    int = int + 1;  %'WQ_OGM_POC',...
def.cAxis(int).value=[0 3];     int = int + 1;  %'WQ_OGM_DON',...
def.cAxis(int).value=[0 3];     int = int + 1;  %'WQ_OGM_PON',...
def.cAxis(int).value=[0 0.1];   int = int + 1;  %'WQ_OGM_DOP',...
def.cAxis(int).value=[0 0.1];   int = int + 1;  %'WQ_OGM_POP',...
def.cAxis(int).value=[0 50];    int = int + 1;  %'WQ_DIAG_PHY_TCHLA',...
def.cAxis(int).value=[0 40];    int = int + 1;  %'SAL',...
def.cAxis(int).value=[0 35];     int = int + 1;%  'TEMP',..     

start_plot_ID = 1;
%end_plot_ID = 20;

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


outputdirectory = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB\SCERM_v6\V6_A3\2015_2016_report\Transect_Surface\RAW\'];
htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB\SCERM_v6\V6_A3\2015_2016_report\Transect_Surface\HTML\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

ncfile(1).name = ['N:\SCERM\SCERM_v6_A3\Output_plt/SCERM8_2015_2016_ALL.nc'];% change this to the nc file loc
ncfile(1).legend = 'SCERM 8';
%
ncfile(2).name = ['N:\SCERM\SCERM_v6_A3\Output_plt/SCERM44_2015_2016_ALL.nc'];% change this to the nc file loc
ncfile(2).legend = 'SCERM 44';



def.boxlegend = 'southwest';
def.rangelegend = 'northeast';

def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
