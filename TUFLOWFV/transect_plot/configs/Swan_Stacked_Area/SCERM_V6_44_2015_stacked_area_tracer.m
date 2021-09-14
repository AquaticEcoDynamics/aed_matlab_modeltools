%The is the configuration file for the transect plot stacked area function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../SCERM/matlab/modeltools/matfiles/swan.mat';
fielddata = 'swan';

points_file = '../../../SCERM/matlab/modeltools/gis/Swan_Transect_Pnt.shp';


int = 1;
theyear = 2015;
%Initial Condition
%def.pdates(int).value = [datenum(theyear,03,15) datenum(theyear,03,25)];int = int + 1;
% 
% % Set up the time loops
% for ii = 04:15
% 
% def.pdates(int).value = [datenum(theyear,ii,01) datenum(theyear,ii+1,01)];int = int + 1;
% 
% end

def.pdates(int).value = [datenum(theyear,05,01) datenum(theyear,08,01)];int = int + 1;
def.pdates(int).value = [datenum(theyear,08,01) datenum(theyear,11,01)];int = int + 1;
def.pdates(int).value = [datenum(theyear,11,01) datenum(theyear,14,01)];int = int + 1;
def.pdates(int).value = [datenum(theyear,14,01) datenum(theyear,17,01)];int = int + 1;


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
    'Ocean',...
    'Local',...
    'Upstream',...
    'Downstream',...
    'Avon',...
    'Canning',...
};

%Field Var
varname = {'TN'};

theunits = 'mg/L';

addmarker = 1;

thevars_conv = 14/1000;

preproc = 1;
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

%datafile = '../../../SCERM/matlab/tracer_simulation/data1.mat';
datafile = 'data1.mat';

outputdirectory = ['C:\Users\00065525\AED Dropbox\AED_Swan_db\REG6.6\SCERM\plotting\StackedArea_SCERM44_TRACER_TN\RAW\'];
htmloutput = ['C:\Users\00065525\AED Dropbox\AED_Swan_db\REG6.6\SCERM\plotting\StackedArea_SCERM44_TRACER_TN\HTML\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

ncfile(1).name = ['C:\Users\00065525\Scratch\SCERM44_2015_2016_Tracer_ALL.nc'];% change this to the nc file loc
ncfile(1).legend = 'SCERM 8';
%
%  ncfile(2).name = 'T:/HN_Cal_v5/output/HN_Cal_2017_2018_kpo4_WQ.nc';
%  ncfile(2).legend = 'kPO4 == 0';



def.boxlegend = 'northeast';
def.rangelegend = 'northwest';

def.dimensions = [12 8]; % Width & Height in cm

def.visible = 'on'; % on or off
