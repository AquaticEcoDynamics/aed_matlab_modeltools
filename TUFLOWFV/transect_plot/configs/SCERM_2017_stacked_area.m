%The is the configuration file for the transect plot stacked area function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../SCERM/matlab/modeltools/matfiles/swan.mat';
fielddata = 'swan';

points_file = '../../../SCERM/matlab/modeltools/gis/Swan_Transect_Pnt.shp';


def.pdates(1).value = [datenum(2017,04,01) datenum(2017,05,01)];
def.pdates(2).value = [datenum(2017,05,01) datenum(2017,06,01)];
def.pdates(3).value = [datenum(2017,06,01) datenum(2017,07,01)];
def.pdates(4).value = [datenum(2017,07,01) datenum(2017,08,01)];
def.pdates(5).value = [datenum(2017,09,01) datenum(2017,10,01)];
def.pdates(6).value = [datenum(2017,10,01) datenum(2017,11,01)];
def.pdates(2).value = [datenum(2017,11,01) datenum(2017,12,01)];
def.pdates(3).value = [datenum(2017,12,01) datenum(2018,01,01)];
def.pdates(4).value = [datenum(2018,01,01) datenum(2018,02,01)];
def.pdates(5).value = [datenum(2018,02,01) datenum(2018,03,01)];
def.pdates(6).value = [datenum(2018,03,01) datenum(2018,04,01)];




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


thevars = {...
    'WQ_NIT_NIT',...
    'WQ_NIT_AMM',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
};

%Field Var
varname = {'WQ_DIAG_TOT_TN'};


def.cAxis(1).value = [0 5];         %'SAL',...
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


outputdirectory = 'F:\Work Stuff/SCERM/Transect/RAW1/';
htmloutput = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Swan_BB/Stacked_Area/Transect_Test/HTML/';

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'Z:\SCERM\SCERM\Output\swan_2017_2018_ALL.nc';
 ncfile(1).legend = 'Test Sim';
%
%  ncfile(2).name = 'T:/HN_Cal_v5/output/HN_Cal_2017_2018_kpo4_WQ.nc';
%  ncfile(2).legend = 'kPO4 == 0';



def.boxlegend = 'northwest';
def.rangelegend = 'northeast';

def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'on'; % on or off
