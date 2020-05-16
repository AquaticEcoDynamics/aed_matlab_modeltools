clear all; close all;
%TN ____________________________________________________________

% varname = {
% 'WQ_DIAG_PHY_GRN_NTOP',...
%     'WQ_DIAG_PHY_GRN_FI',...
%     'WQ_DIAG_PHY_GRN_FNIT',...
%     'WQ_DIAG_PHY_GRN_FPHO',...
%     'WQ_DIAG_PHY_GRN_FSIL',...
%     'WQ_DIAG_PHY_GRN_FT',...
%     'WQ_DIAG_PHY_GRN_FSAL',...
%     'WQ_DIAG_PHY_BGA_NTOP',...
%     'WQ_DIAG_PHY_BGA_FI',...
%     'WQ_DIAG_PHY_BGA_FNIT',...
%     'WQ_DIAG_PHY_BGA_FPHO',...
%     'WQ_DIAG_PHY_BGA_FSIL',...
%     'WQ_DIAG_PHY_BGA_FT',...
%     'WQ_DIAG_PHY_BGA_FSAL',...
%     'WQ_DIAG_PHY_FDIAT_NTOP',...
%     'WQ_DIAG_PHY_FDIAT_FI',...
%     'WQ_DIAG_PHY_FDIAT_FNIT',...
%     'WQ_DIAG_PHY_FDIAT_FPHO',...
%     'WQ_DIAG_PHY_FDIAT_FSIL',...
%     'WQ_DIAG_PHY_FDIAT_FT',...
%     'WQ_DIAG_PHY_FDIAT_FSAL',...
%     'WQ_DIAG_PHY_MDIAT_NTOP',...
%     'WQ_DIAG_PHY_MDIAT_FI',...
%     'WQ_DIAG_PHY_MDIAT_FNIT',...
%     'WQ_DIAG_PHY_MDIAT_FPHO',...
%     'WQ_DIAG_PHY_MDIAT_FSIL',...
%     'WQ_DIAG_PHY_MDIAT_FT',...
%     'WQ_DIAG_PHY_MDIAT_FSAL',...
% };
varname = {
'WQ_DIAG_OGM_DOP_MINER',...
'WQ_DIAG_OGM_POP_MINER',...
'WQ_DIAG_OGM_SED_DOP',...
'WQ_DIAG_OGM_SED_POP',...
'WQ_DIAG_OGM_PSED_POP',...
'WQ_DIAG_SDF_FSED_DOP',...
'WQ_DIAG_SDF_FSED_POP',...
'WQ_DIAG_SDF_FSED_FRP',...
'WQ_DIAG_PHS_SED_FRP',...
'WQ_DIAG_PHS_ATM_DIP_FLUX',...
'WQ_DIAG_PHY_PUP',...
};


theStruct.Depth = 'Bottom';

theStruct.ncfile = 'T:\HN_Cal_v5\output\HN_Cal_2017_2018_WQ.nc';

theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
theStruct.fielddata = 'hawkesbury_all';

theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';

theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';



theStruct.xl = [0 250];
theStruct.yl = [];
theStruct.offset = 0.1;

theStruct.Polyoffset = 5;

theStruct.outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v5_A5\Transect_2017\';

theStruct.daterange = datenum(2017,09:10,01);

for k = 1:length(varname)


theStruct.varname = varname{k};
theStruct.ylab = regexprep(varname{k},'_',' ');
theStruct.conv = 1;

for i =  7:01:16
    theStruct.daterange = datenum(2017,i:i+1,01);
    
    theStruct.outname = [varname{k},'_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end

end
%TP ____________________________________________________________

% theStruct.ncfile = 'T:\HN_Cal_v5_A2_3D\output\HN_Cal_2017_2018_WQ.nc';
% 
% theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
% theStruct.fielddata = 'hawkesbury_all';
% 
% theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';
% 
% theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';

% theStruct.varname = 'WQ_DIAG_TOT_TP';
% theStruct.ylab = 'TP (mg/L)';
% theStruct.conv = 31/1000;
% 
% theStruct.xl = [0 250];
% theStruct.yl = [0 0.2];
% theStruct.offset = 0.01;
% 
% theStruct.Polyoffset = 5;
% 
% 
% 
% for i = 7:01:16
%     
%     theStruct.daterange = datenum(2017,i:i+1,01);
%     
%     theStruct.outname = ['HN_V5_A2_Transect_TP_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
%     
%     transect_plot(theStruct);
% 
% end
% 
% %SAL ____________________________________________________________
% 
% % theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';
% % 
% % theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
% % theStruct.fielddata = 'hawkesbury_all';
% % 
% % theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';
% % 
% % theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';
% 
% theStruct.varname = 'SAL';
% theStruct.ylab = 'Salinity (psu)';
% theStruct.conv = 1;
% 
% theStruct.xl = [0 250];
% theStruct.yl = [0 35];
% theStruct.offset = 1;
% 
% theStruct.Polyoffset = 5;
% 
% % theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_V5_A2\Transect\';
% 
% 
% for i =  7:01:16
%     
%     theStruct.daterange = datenum(2017,i:i+1,01);
%     
%     theStruct.outname = ['HN_V5_A2_Transect_SAL_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
%     
%     transect_plot(theStruct);
% 
% end
% 
% %WQ_DIAG_PHY_TCHLA ____________________________________________________________
% 
% % theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';
% % 
% % theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
% % theStruct.fielddata = 'hawkesbury_all';
% % 
% % theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';
% % 
% % theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';
% 
% theStruct.varname = 'WQ_DIAG_PHY_TCHLA';
% theStruct.ylab = 'TCHLa (ug/L)';
% theStruct.conv = 1;
% 
% theStruct.xl = [0 250];
% theStruct.yl = [0 60];
% theStruct.offset = 2;
% 
% theStruct.Polyoffset = 5;
% 
% % theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_V5_A2\Transect\';
% 
% 
% for i = 7:01:16
%     
%     theStruct.daterange = datenum(2017,i:i+1,01);
%     
%     theStruct.outname = ['HN_V5_A2_Transect_TCHLA_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
%     
%     transect_plot(theStruct);
% 
% end
% 
% %WQ_DIAG_TOT_TURBIDITY ____________________________________________________________
% 
% % theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';
% % 
% % theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
% % theStruct.fielddata = 'hawkesbury_all';
% % 
% % theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';
% % 
% % theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';
% 
% theStruct.varname = 'WQ_DIAG_TOT_TURBIDITY';
% theStruct.ylab = 'Turbidity (NTU)';
% theStruct.conv = 1;
% 
% theStruct.xl = [0 250];
% theStruct.yl = [0 50];
% theStruct.offset = 1;
% 
% theStruct.Polyoffset = 5;
% 
% % theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_V5_A2\Transect\';
% 
% 
% for i =  7:01:16
%     
%     theStruct.daterange = datenum(2017,i:i+1,01);
%     
%     theStruct.outname = ['HN_V5_A2_Transect_Turbidity_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
%     
%     transect_plot(theStruct);
% 
% end
% 
% %WQ_OXY_OXY ____________________________________________________________
% 
% % theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';
% % 
% % theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
% % theStruct.fielddata = 'hawkesbury_all';
% % 
% % theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';
% % 
% % theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';
% 
% theStruct.varname = 'WQ_OXY_OXY';
% theStruct.ylab = 'Oxygen (mg/L)';
% theStruct.conv = 32/1000;
% 
% theStruct.xl = [0 250];
% theStruct.yl = [0 12];
% theStruct.offset = 0.25;
% 
% theStruct.Polyoffset = 5;
% 
% % theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_V5_A2\Transect\';
% 
% 
% for i =  7:01:16
%     
%     theStruct.daterange = datenum(2017,i:i+1,01);
%     
%     theStruct.outname = ['HN_V5_A2_Transect_Oxygen_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
%     
%     transect_plot(theStruct);
% 
% end




