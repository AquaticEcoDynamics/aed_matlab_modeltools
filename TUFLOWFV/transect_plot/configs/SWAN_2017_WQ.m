%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = '../../../SCERM/matlab/modeltools/matfiles/swan.mat';
fielddata = 'swan';

points_file = '../../../SCERM/matlab/modeltools/gis/Swan_Transect_Pnt.shp';


def.pdates(1).value = [datenum(2017,04,01) datenum(2017,05,01)];
def.pdates(2).value = [datenum(2017,05,01) datenum(2017,06,01)];
def.pdates(3).value = [datenum(2017,06,01) datenum(2017,07,01)];
def.pdates(4).value = [datenum(2017,07,01) datenum(2017,08,01)];
def.pdates(5).value = [datenum(2017,03,01) datenum(2017,04,01)];
% def.pdates(6).value = [datenum(2017,09,01) datenum(2017,10,01)];
% def.pdates(7).value = [datenum(2017,10,01) datenum(2017,11,01)];
% def.pdates(8).value = [datenum(2017,11,01) datenum(2017,12,01)];
% def.pdates(9).value = [datenum(2017,12,01) datenum(2018,01,01)];
% def.pdates(10).value = [datenum(2018,01,01) datenum(2018,02,01)];
% def.pdates(11).value = [datenum(2018,02,01) datenum(2018,3,01)];
% def.pdates(12).value = [datenum(2018,03,01) datenum(2018,4,01)];




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
     'WQ_NCS_SS1',...
    'WQ_OXY_OXY',...
    'WQ_SIL_RSI',...
    'WQ_NIT_AMM',...
    'WQ_NIT_NIT',...
    'WQ_PHS_FRP',...
    'WQ_PHS_FRP_ADS',...
    'WQ_OGM_DOC',...
    'WQ_OGM_POC',...
    'WQ_OGM_DON',...
    'WQ_OGM_PON',...
    'WQ_OGM_DOP',...
    'WQ_OGM_POP',...
    'WQ_PHY_GRN',...
    'SAL',...
    'TEMP',...
     };
% 
% 
def.cAxis(1).value = [0 5];         
def.cAxis(2).value = [0 0.5];
def.cAxis(3).value = [0 50];         
def.cAxis(4).value = [0 75];
def.cAxis(5).value = [0 25];         
def.cAxis(6).value = [0 20];
def.cAxis(7).value = [0 10];         
def.cAxis(8).value = [0 0.5];
def.cAxis(9).value = [0 0.5];         
def.cAxis(10).value = [0 0.3];
def.cAxis(11).value = [0 0.1];         
def.cAxis(12).value = [0 35];
def.cAxis(13).value = [0 10];         
def.cAxis(14).value = [0 3];
def.cAxis(15).value = [0 3];         
def.cAxis(16).value = [0 0.1];
def.cAxis(17).value = [0 0.1];         
def.cAxis(18).value = [0 15];
def.cAxis(19).value = [0 40];         
def.cAxis(20).value = [0 35];       

start_plot_ID = 1;
end_plot_ID = 20;

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


outputdirectory = 'F:\Work Stuff/SCERM/Transect/RAW/SCERM44_2017_2018_Bottom/';
htmloutput = 'F:\Cloudstor/Shared/Aquatic Ecodynamics (AED)/AED_Swan_BB/SCERM44_v5_A1_Transect/2017_2018/';

% ____________________________________________________________Configuration

% Models___________________________________________________________________

ncfile(1).name = ['W:\Busch_Temp\SCERM\Output/swan_2017_2018_catchment_ALL.nc'];% change this to the nc file loc
 ncfile(1).legend = 'SCERM44';
%
 ncfile(2).name = 'Z:\SCERM\SCERM\Output/swan_2017_2018_ALL.nc';
 ncfile(2).legend = 'SCERM8';



def.boxlegend = 'southwest';
def.rangelegend = 'northeast';

def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
