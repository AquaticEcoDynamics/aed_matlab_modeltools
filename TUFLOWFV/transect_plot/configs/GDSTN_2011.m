
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = 'F:\Cloudstor\Shared\AED_Gladstone\matlab\data\gladstone.mat';
fielddata = 'gladstone';

points_file = 'F:\Cloudstor\Shared\AED_Gladstone\matlab\gis\Transect_pnt.shp';

theyear = 2011;
int = 1;
for ii = 2:12
def.pdates(int).value = [datenum(theyear,ii,01) datenum(theyear,ii+1,01)];int = int + 1;
end




def.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.

def.binradius = 1.5;% in km;

%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.

def.linedist = 500;%  in m

isSpherical = 1;

def.xlim = [0 100];% xlim in KM
def.xticks = [0:10:100];
def.xlabel = 'Distance(km)';

def.export_shapefile = 1;

varname = {...
    'TSS',...
};
def.cAxis(1).value = [0 350];         %'TSS',...

export_shapefile = 1;


% start_plot_ID = 20;
% end_plot_ID = 22;

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


outputdirectory = 'F:\Cloudstor\Shared\AED_Gladstone\matlab\plotting/Transect/RAW/';
htmloutput = 'F:\Cloudstor\Shared\AED_Gladstone\matlab\plotting/Transect/HTML/';

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'F:\GLAD_EXT_SEDI_HIND_2D_000.nc';
 ncfile(1).legend = 'BMT Model';
%
%  ncfile(2).name = 'T:\HN_Cal_v5\output\HN_Cal_2017_2018_kpo4_WQ.nc';
%  ncfile(2).legend = 'kPO4 == 0';
%
 def.boxlegend = 'northwest';
def.rangelegend = 'northeast';


def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
