%Configuration file for the tfv_export Routine.
%
% Three section need to be configured: Model, Variables and Locations
% Model Configuration sets up which model NETCDF is to be processed,
%   Output directory location, Start and End time for the Plots, and a
%   smoothing factor(running average)
%
% Variable configuration has three fields that must be completed for each
%   variable. Name, Units and CAxis. The field name (e.g. TEMP, SAL) must
%   match the variable name being exported.
%
% Location configuration consists of three fields, X, Y & full Name. The
%   field name is just an ID for directory creation. This must contain no
%   spaces or symbols.
%
%
% Written by Brendan Busch

%__________________________________________________________________________

%_________________________________________________________________________%
%                                                                         %
%   Model Configuration                                                   %
%_________________________________________________________________________%


% Location of the model netcdf file
Configuration.model = 'Y:\Erie\tfv_011_Scn00\Output\erie_00_TFV.nc';
% Output directory
Configuration.output_directory = 'tfv_011_Scn00\TFV\' ;
% Start time of Plot
Configuration.time_start = '07/05/2013' ;
% End time of Plot
Configuration.time_end = '30/09/2013';
% Running average (smooth) for figure
Configuration.smooth = 3 ;


%_________________________________________________________________________%
%                                                                         %
%   Variable Configuration                                                %
%_________________________________________________________________________%

% Each variable to be exported must be configured with name, units & caxis
% Base name must match the variable name coming out of TFV

Variables.TEMP.name = 'Temperature';
Variables.TEMP.units = 'C';
Variables.TEMP.caxis = [0 30];

% Variables.SAL.name = 'Salinity';
% Variables.SAL.units = 'psu';
% Variables.SAL.caxis = [0 40];
% 
% Variables.H.name = 'Height';
% Variables.H.units = 'm';
% Variables.H.caxis = [-1 2];

% Variables.WQ_OXY_OXY.name = 'Oxygen';
% Variables.WQ_OXY_OXY.units = 'mmol/m3';
% Variables.WQ_OXY_OXY.caxis = [0 200];
%




%_________________________________________________________________________%
%                                                                         %
%   Location Configuration                                                %
%_________________________________________________________________________%


% Each site needs an ID as it's base, X,Y and Full Name

Sites.STN_1274.X = 618152.7191;
Sites.STN_1274.Y = 4744122.784;
Sites.STN_1274.name = 'STN_1274';

Sites.STN_1341.X = 621178.9083;
Sites.STN_1341.Y = 4743774.254;
Sites.STN_1341.name = 'STN_1341';

Sites.STN_1345.X = 624105.745;
Sites.STN_1345.Y = 4743918.958;
Sites.STN_1345.name = 'STN_1345';

Sites.STN_1351.X = 638577.1539;
Sites.STN_1351.Y = 4748175.906;
Sites.STN_1351.name = 'STN_1351';

Sites.STN_1353.X = 608480.9856;
Sites.STN_1353.Y = 4744056.154;
Sites.STN_1353.name = 'STN_1353';
