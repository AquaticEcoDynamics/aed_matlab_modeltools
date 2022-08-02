%The is the configuration file for the transect_plot.m function.


% Configuration____________________________________________________________

yr = 2017;
rgh = '2017';

%fielddata_matfile = 'W:/busch_github/CDM/data/store/archive/cllmm_noALS.mat';
fielddata_matfile = '/Projects2/busch_github/CDM/data/store/archive/cllmm_noALS.mat';
%fielddata = 'UA';
fielddata = 'cllmm';
points_file = '/Projects2/busch_github/CDM/gis/supplementary/Transect_Coorong.shp';

i=1;
for yy=2017:2020
    def.pdates(i).value = [datenum(yy,07,01) datenum(yy,10,01)];i=i+1;
    def.pdates(i).value = [datenum(yy,10,01) datenum(yy+1,1,01)];i=i+1;
    def.pdates(i).value = [datenum(yy+1,1,01) datenum(yy+1,4,01)];i=i+1;
    def.pdates(i).value = [datenum(yy+1,4,01) datenum(yy+1,7,01)];i=i+1;
end

def.binfielddata = 1;
% radius distance to include field data. Used to bin data where number of
% sites is higher, but the frequency of sampling is low. The specified
% value will also make where on the line each polygon will be created. So
% if radius == 5, then there will be a search polygon found at r*2, so 0km, 10km, 20km etc. In windy rivers these polygons may overlap.

def.binradius = 0.5;% in km;

%distance from model polyline to be consided.
%Field data further than specified distance won't be included.
%Even if found with search radius. This is to attempt to exclude data
%sampled outside of the domain.

def.linedist = 1500;%  in m

def.xlim = [0 110];% xlim in KM
def.xticks = [0:10:110];
def.xlabel = 'Distance from Mouth (km)';
%def.xlabel

varname = {...
'WQ_DIAG_MAG_TMALG',...
'SAL',...
'TEMP',...
'WQ_DIAG_TOT_TN',...
'WQ_DIAG_TOT_TP',...
'WQ_DIAG_PHY_TCHLA',...
'WQ_NIT_AMM',...
'WQ_NIT_NIT',...
'WQ_PHS_FRP',...
'WQ_OXY_OXY',...
'WQ_DIAG_TOT_TSS',...
'WQ_DIAG_TOT_TOC',...
'WQ_OGM_DOC',...
'WQ_DIAG_TOT_TURBIDITY',...
};

%for vvvv=1:23
%def.cAxis(vvvv).value = [ ];
%end
def.cAxis(1).value = [0 250];   %'WQ_DIAG_MAG_TMALG',..
def.cAxis(2).value = [0 200];   %'SAL',..
def.cAxis(3).value = [0 50];   %'TEMP',..
def.cAxis(4).value = [0 12.5];  %'TN',...
def.cAxis(5).value = [0 0.8];   %'TP',...
def.cAxis(6).value = [0 125];   %'TCHLA',...
def.cAxis(7).value = [0 0.25];         %'AMM',...
def.cAxis(8).value = [0 1.2];         %'NIT',...
def.cAxis(9).value = [0 0.1];         %'FRP',...
def.cAxis(10).value = [0 15];         %'OXY',...
def.cAxis(11).value = [0 150];         %'TSS',...
def.cAxis(12).value = [0 60];         %'TOC',...
def.cAxis(13).value = [0 50];         %'DOC',...
def.cAxis(14).value = [0 75];         %'TURB',...

 start_plot_ID = 1;
% end_plot_ID = 13;

%start_plot_ID = 25;


% Add field data to figure
plotvalidation = 1; % 1 or 0

isRange = 1;
istitled = 1;
isylabel = 1;
islegend = 0;
isYlim = 1;
isHTML = 1;
isSurf = 1; %plot surface (1) or bottom (0)
isSpherical = 0;
use_matfiles = 1;

% ____________________________________________________________Configuration

% Models___________________________________________________________________


outputdirectory = '/Projects2/CDM/Report_Images/GEN2_Transect/RAW/';
htmloutput = '/Projects2/CDM/Report_Images/GEN2_Transect/HTML/';

% ____________________________________________________________Configuration

% Models___________________________________________________________________
 ncfile(1).name =  '/Projects2/CDM/HCHB_scenario_assessment/MER_Coorong_eWater_2022_GEN2_0617_Fsed/output_basecase_hd_MIN35sedv4/hchb_Gen2_201707_202201_all.nc';
 ncfile(1).symbol = {'-';'--'};
 ncfile(1).colour = {[31,120,180]./255,[31,120,180]./255};% Surface and Bottom % Surface and Bottom
 ncfile(1).legend = 'GEN 2';
 ncfile(1).translate = 1;
% 
 %ncfile(2).name = 'W:/CDM/MER_Coorong_eWater_2021/output_Scen3/eWater2021_Scen3_all.nc';
 %ncfile(2).symbol = {'-';'--'};
 %ncfile(2).colour = {[55,126,184]./255,[55,126,184]./255}; % Surface and Bottom
 %ncfile(2).legend = 'No CEW 4yrs';
 %ncfile(2).translate = 1;
%% 
 %ncfile(3).name = 'W:/CDM/MER_Coorong_eWater_2021/output_Scen4/eWater2021_Scen4_all.nc';
 %ncfile(3).symbol = {'-';'--'};
 %ncfile(3).colour = {[77,175,74]./255,[77,175,74]./255}; % Surface and Bottom
 %ncfile(3).legend = 'No eWater 4yrs';
 %ncfile(3).translate = 1;
 %% 
 %ncfile(4).name = 'W:/CDM/MER_Coorong_eWater_2021/output_Scen1/eWater2021_Scen1_all.nc';
 %ncfile(4).symbol = {'-';'--'};
 %ncfile(4).colour = {[152,78,163]./255,[152,78,163]./255}; % Surface and Bottom
 %ncfile(4).legend = 'No CEW 1yr';
 %ncfile(4).translate = 1;
 %
 %ncfile(5).name = 'W:/CDM/MER_Coorong_eWater_2021/output_Scen2/eWater2021_Scen2_all.nc';
 %ncfile(5).symbol = {'-';'--'};
 %ncfile(5).colour = {[255,127,0]./255,[255,127,0]./255}; % Surface and Bottom
 %ncfile(5).legend = 'No eWater 1yr';
 %ncfile(5).translate = 1;


def.boxlegend = 'southwest';
def.rangelegend = 'northwest';

def.dimensions = [16 10]; % Width & Height in cm

def.visible = 'off'; % on or off
