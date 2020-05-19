
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________



fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata = 'hawkesbury_all';

points_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\South_Creek_Transect_1.shp';


def.pdates(1).value = [datenum(2017,06,01) datenum(2017,07,01)];
% def.pdates(2).value = [datenum(2017,06,01) datenum(2017,07,01)];
% def.pdates(3).value = [datenum(2017,07,01) datenum(2017,08,01)];
% def.pdates(4).value = [datenum(2017,08,01) datenum(2017,09,01)];
% def.pdates(5).value = [datenum(2017,09,01) datenum(2017,10,01)];
% def.pdates(6).value = [datenum(2017,10,01) datenum(2017,11,01)];
% def.pdates(7).value = [datenum(2017,11,01) datenum(2017,12,01)];
% def.pdates(8).value = [datenum(2017,12,01) datenum(2018,01,01)];



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

def.xlim = [0 65];% xlim in KM
def.xticks = [0:10:65];
def.xlabel = 'Distance from HN (km)';


varname = {...
    'TEMP',...
};



def.cAxis(1).value = [0 25];         %'SAL',...

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


outputdirectory = 'F:\Work Stuff\Hawkesbury/Testing/RAW/';
htmloutput = 'F:\Work Stuff\Hawkesbury/Testing/HTML/';

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = 'D:\Cloud\Dropbox\HN FV AED2_SWC_outgoing\SC\output\SC_Cal_v12a\SC_Cal_2017.nc';
 ncfile(1).legend = 'kPO4 & RDOM';
%
%  ncfile(2).name = 'T:\HN_Cal_v5\output\HN_Cal_2017_2018_kpo4_WQ.nc';
%  ncfile(2).legend = 'kPO4 == 0';
%
 def.boxlegend = 'northwest';
def.rangelegend = 'northeast';


def.dimensions = [16 8]; % Width & Height in cm

def.visible = 'off'; % on or off
