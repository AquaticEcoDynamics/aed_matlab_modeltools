clear all; close all;
%TN ____________________________________________________________

theStruct.ncfile = 'T:\HN_Cal_v5_A2_3D\output\HN_Cal_2013_2014_WQ.nc';

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

theStruct.outname = 'HN_V5_A2_Transect_TN.png';
theStruct.outdir = 'F:\Cloudstor\Shared\Aquatic Ecodynamics (AED)\AED_Hawkesbury\Model_Results\HN_Cal_v5_A2_Matlab_Test\Transect\';





for i =  7:01:16
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_TN_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end


%TP ____________________________________________________________



theStruct.varname = 'WQ_DIAG_TOT_TP';
theStruct.ylab = 'TP (mg/L)';
theStruct.conv = 31/1000;

theStruct.xl = [0 250];
theStruct.yl = [0 0.2];
theStruct.offset = 0.01;

theStruct.Polyoffset = 5;



for i = 7:01:16
    
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_TP_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end

%SAL ____________________________________________________________



theStruct.varname = 'SAL';
theStruct.ylab = 'Salinity (psu)';
theStruct.conv = 1;

theStruct.xl = [0 250];
theStruct.yl = [0 35];
theStruct.offset = 1;

theStruct.Polyoffset = 5;



for i =  7:01:16
    
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_SAL_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end

%WQ_DIAG_PHY_TCHLA ____________________________________________________________



theStruct.varname = 'WQ_DIAG_PHY_TCHLA';
theStruct.ylab = 'TCHLa (ug/L)';
theStruct.conv = 1;

theStruct.xl = [0 250];
theStruct.yl = [0 60];
theStruct.offset = 2;

theStruct.Polyoffset = 5;



for i = 7:01:16
    
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_TCHLA_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end

%WQ_DIAG_TOT_TURBIDITY ____________________________________________________________



theStruct.varname = 'WQ_DIAG_TOT_TURBIDITY';
theStruct.ylab = 'Turbidity (NTU)';
theStruct.conv = 1;

theStruct.xl = [0 250];
theStruct.yl = [0 50];
theStruct.offset = 1;

theStruct.Polyoffset = 5;



for i =  7:01:16
    
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_Turbidity_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end

%WQ_OXY_OXY ____________________________________________________________



theStruct.varname = 'WQ_OXY_OXY';
theStruct.ylab = 'Oxygen (mg/L)';
theStruct.conv = 32/1000;

theStruct.xl = [0 250];
theStruct.yl = [0 12];
theStruct.offset = 0.25;

theStruct.Polyoffset = 5;



for i =  7:01:16
    
    theStruct.daterange = datenum(2013,i:i+1,01);
    
    theStruct.outname = ['HN_V5_A2_Transect_Oxygen_',datestr(theStruct.daterange(1),'yyyymmdd'),'_',datestr(theStruct.daterange(end),'yyyymmdd'),'.png'];
    
    transect_plot(theStruct);

end




