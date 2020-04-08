clear all; close all;

theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';

theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
theStruct.fielddata = 'hawkesbury_all';

theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';

theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';

theStruct.varname = 'WQ_DIAG_TOT_TN';
theStruct.ylab = 'TN (mg/L)';
theStruct.conv = 14/1000;

theStruct.xl = [0 250];
theStruct.yl = [0 3];
theStruct.offset = 0.1;

theStruct.Polyoffset = 5;

theStruct.outname = 'HN_V4_A5_Transect_TN.png';
theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v4_A5\Transect\';

theStruct.daterange = datenum(2017,09:10,01);




for i = 9:01:14
    theStruct.daterange = datenum(2017,i:i+1,01);
    
    theStruct.outname = ['HN_V4_A5_Transect_TN_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end


%____________________________________________________________

theStruct.ncfile = 'G:\Work Stuff\HN_Cal_2017_2018_2D_WQ.nc';

theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
theStruct.fielddata = 'hawkesbury_all';

theStruct.polygon_file = '..\..\..\Hawkesbury\gis\TransectPolygon_HN.shp';

theStruct.polygon_line = '..\..\..\Hawkesbury\gis\Transectpnt_HN_100.shp';

theStruct.varname = 'WQ_DIAG_TOT_TP';
theStruct.ylab = 'TP (mg/L)';
theStruct.conv = 31/1000;

theStruct.xl = [0 250];
theStruct.yl = [0 0.2];
theStruct.offset = 0.01;

theStruct.Polyoffset = 5;

theStruct.outdir = 'D:\Cloud\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v4_A5\Transect\';


for i = 9:01:14
    
    theStruct.daterange = datenum(2017,i:i+1,01);
    
    theStruct.outname = ['HN_V4_A5_Transect_TP_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end




