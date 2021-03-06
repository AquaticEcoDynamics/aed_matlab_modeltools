
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________





%fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata_matfile = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';
%points_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\Transectpnt_HN_100.shp';
points_file = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/gis/Transectpnt_HN_100.shp';

t_yr = 2014;
int = 1;

% %Months
%  def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,08,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr,08,01) datenum(t_yr,09,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,10,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr,10,01) datenum(t_yr,11,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr,11,01) datenum(t_yr,12,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,01,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,01,01) datenum(t_yr+1,02,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,02,01) datenum(t_yr+1,03,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,04,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,04,01) datenum(t_yr+1,05,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,05,01) datenum(t_yr+1,06,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,06,01) datenum(t_yr+1,07,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,07,01) datenum(t_yr+1,08,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,08,01) datenum(t_yr+1,09,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,10,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,10,01) datenum(t_yr+1,11,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,11,01) datenum(t_yr+1,12,01)];int = int + 1;
%  def.pdates(int).value = [datenum(t_yr+1,12,01) datenum(t_yr+2,01,01)];int = int + 1;

%Seasons
def.pdates(int).value = [datenum(t_yr,07,01) datenum(t_yr,09,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,09,01) datenum(t_yr,12,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr,12,01) datenum(t_yr+1,03,01)];int = int + 1;
def.pdates(int).value = [datenum(t_yr+1,03,01) datenum(t_yr+1,06,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,06,01) datenum(t_yr+1,09,01)];int = int + 1;
%def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,12,01)];int = int + 1;



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
    'WQ_OGM_DOC',...
    'WQ_OGM_DON',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'TEMP',...
    'SAL',...
    'TN_TP',...
    'HSI_CYANO',...
};

def.cAxis(1).value = [0 13];            %'WQ_OXY_OXY',...
def.cAxis(2).value = [0 0.25];	        %'WQ_NIT_AMM',...
def.cAxis(3).value = [0 1.2];           %'WQ_NIT_NIT',...
def.cAxis(4).value = [0 0.1];           %'WQ_PHS_FRP',...
def.cAxis(5).value = [0 15];            %'WQ_OGM_DOC',...
def.cAxis(6).value = [0 0.65];         %'WQ_OGM_DON',...
def.cAxis(7).value = [0 60];           %'WQ_DIAG_PHY_TCHLA',...
def.cAxis(8).value = [0 3];            %'WQ_DIAG_TOT_TN',...
def.cAxis(9).value = [0 0.3];          %'WQ_DIAG_TOT_TP',...
def.cAxis(10).value = [0 100];          %'WQ_DIAG_TOT_TSS',...
def.cAxis(11).value = [0 150];          %'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(12).value = [5 40];           %'Temp',...
def.cAxis(13).value = [0 40];           %'SAL',...
def.cAxis(14).value = [5 40];           %'TN:TP',...
def.cAxis(15).value = [0 1.3];            %'HSI_CYANO


start_plot_ID = 15;
end_plot_ID = 16;

%start_plot_ID = 25;


% Add field data to figure
plotvalidation = 1; % 1 or 0


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isHTML = 0;
isSurf = 1; %plot surface (1) or bottom (0)
isRange = 1;
 
outputdirectory = '~/Dropbox/HawkesburyNepean/HN_Cal_v6/Plots_MH_wq_v/2014/transect/' ;
htmloutput = ['~/Dropbox/HawkesburyNepean/HN_Cal_v6/Plots_MH_wq_v/2014/html/'];
%outputdirectory = 'F:\Temp_Plots\Hawkesbury\HN_Cal_v5\plots_V5_A8_2013_1_S\';
%htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v5_A8\2013_2014\Transect-Surface-Seasons\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

 ncfile(1).name = '/Volumes/AED/Hawkesbury/HN_Cal_v5_A8/output/HN_Cal_2014_2015_WQ.nc';
%ncfile(1).name = 'N:\Hawkesbury\HN_Cal_v5_A8\output\HN_Cal_2013_2014_WQ.nc';
 ncfile(1).legend = 'V6';

 %ncfile(2).name = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2sc_2017/output/HN_Cal_2017_2018_3D_wq_WQ.nc';
 %ncfile(2).legend = 'V6_A2sc';

 %ncfile(3).name = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2017/output/HN_Cal_2017_2018_3D_wq_WQ.nc';
 %ncfile(3).legend = 'V6_scen';

 def.boxlegend   = 'northwest';
 def.rangelegend = 'northeast';


 def.dimensions = [14 8]; % Width & Height in cm

 def.visible = 'off'; % on or off
 
 def.font = 'Arial';

