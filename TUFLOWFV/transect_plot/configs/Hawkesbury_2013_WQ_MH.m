
%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________





%fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
fielddata_matfile = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/matfiles/hawkesbury_all.mat';
fielddata = 'hawkesbury_all';
%points_file = '..\..\..\Hawkesbury\matlab\modeltools\gis\Transectpnt_HN_100.shp';
points_file = '/Users/00042030/Sims/Hawkesbury/matlab/modeltools/gis/Transectpnt_HN_100.shp';

t_yr = 2013;
int = 1;

%Months
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
 def.pdates(int).value = [datenum(t_yr+1,06,01) datenum(t_yr+1,07,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,07,01) datenum(t_yr+1,08,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,08,01) datenum(t_yr+1,09,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,09,01) datenum(t_yr+1,10,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,10,01) datenum(t_yr+1,11,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,11,01) datenum(t_yr+1,12,01)];int = int + 1;
 %def.pdates(int).value = [datenum(t_yr+1,12,01) datenum(t_yr+2,01,01)];int = int + 1;

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
    'HSI_CYANO',...
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
    'WQ_PHY_BGA',...
    'WQ_PHY_FDIAT',...
    'WQ_PHY_MDIAT',...
    'WQ_TRC_AGE',...
    'WQ_DIAG_PHY_TCHLA',...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_TOT_TOC',...
    'WQ_DIAG_TOT_TSS',...
    'WQ_DIAG_TOT_TURBIDITY',...
    'TEMP',...
    'SAL',...
};

def.cAxis(1).value = [0 1];    		%'WQ_NCS_SS1',...
def.cAxis(2).value = [0 100];    		%'WQ_NCS_SS1',...
def.cAxis(2).value = [0 12.5];          %'WQ_OXY_OXY',...
def.cAxis(3).value = [0 10];            %'WQ_SIL_RSI',...
def.cAxis(4).value = [0 0.25];	        %'WQ_NIT_AMM',...
def.cAxis(5).value = [0 1];             %'WQ_NIT_NIT',...
def.cAxis(6).value = [0 0.1];           %'WQ_PHS_FRP',...
def.cAxis(7).value = [0 0.07];          %'WQ_PHS_FRP_ADS',...
def.cAxis(8).value = [0 15];            %'WQ_OGM_DOC',...
def.cAxis(9).value = [0 2];             %'WQ_OGM_POC',...
def.cAxis(10).value = [0 0.65];         %'WQ_OGM_DON',...
def.cAxis(11).value = [0 1.5];          %'WQ_OGM_PON',...
def.cAxis(12).value = [0 0.05];         %'WQ_OGM_DOP',...
def.cAxis(13).value = [0 0.15];         %'WQ_OGM_POP',...
def.cAxis(14).value = [0 75];           %'WQ_PHY_GRN',...
def.cAxis(15).value = [0 50];           %'WQ_PHY_BGA',...
def.cAxis(16).value = [0 75];           %'WQ_PHY_FDIAT',...
def.cAxis(17).value = [0 20];           %'WQ_PHY_MDIAT',...
def.cAxis(18).value = [0 135];          %'WQ_TRC_AGE',...
def.cAxis(19).value = [0 60];           %'WQ_DIAG_PHY_TCHLA',...
def.cAxis(20).value = [0 3];            %'WQ_DIAG_TOT_TN',...
def.cAxis(21).value = [0 0.3];          %'WQ_DIAG_TOT_TP',...
def.cAxis(22).value = [0 15];           %'WQ_DIAG_TOT_TOC',...
def.cAxis(23).value = [0 100];          %'WQ_DIAG_TOT_TSS',...
def.cAxis(24).value = [0 150];          %'WQ_DIAG_TOT_TURBIDITY',...
def.cAxis(25).value = [5 40];           %'Temp',...
def.cAxis(26).value = [0 400];          %'SAL',...


start_plot_ID = 1;
% end_plot_ID = 26;

%start_plot_ID = 25;


% Add field data to figure
plotvalidation = 1; % 1 or 0


istitled = 1;
isylabel = 1;
islegend = 1;
isYlim = 1;
isHTML = 1;
isSurf = 1; %plot surface (1) or bottom (0)
 
outputdirectory = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2013/plotting/transect/';
htmloutput = ['/Users/00042030/Dropbox/HN FV AED2_SWC_incoming/V6/Plots_MH_scen/transect/2013/html/'];
%outputdirectory = 'F:\Temp_Plots\Hawkesbury\HN_Cal_v5\plots_V5_A8_2013_1_S\';
%htmloutput = ['F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v5_A8\2013_2014\Transect-Surface-Seasons\'];

% ____________________________________________________________Configuration

% Models___________________________________________________________________

% ncfile(1).name = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A1b_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc';
%ncfile(1).name = 'N:\Hawkesbury\HN_Cal_v5_A8\output\HN_Cal_2013_2014_WQ.nc';
% ncfile(1).legend = 'V6_A1b';

 ncfile(1).name = '/Volumes/AED/Hawkesbury/HN_Cal_v6_A2_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc';
 ncfile(1).legend = 'V6_A2';

 ncfile(2).name = '/Volumes/AED/Hawkesbury/HN_ScenTest_v6_A2sc_2013/output/HN_Cal_2013_2014_3D_wq_WQ.nc';
 ncfile(2).legend = 'V6_scen';

 def.boxlegend   = 'northwest';
 def.rangelegend = 'northeast';


 def.dimensions = [16 8]; % Width & Height in cm

 def.visible = 'off'; % on or off
