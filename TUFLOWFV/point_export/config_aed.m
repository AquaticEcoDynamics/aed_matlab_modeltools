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
Configuration.model = 'Y:\Erie\tfv_011_Scn00\Output\erie_00_AED.nc';
% Output directory
Configuration.output_directory = 'tfv_011_Scn00\AED\' ;
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

% Variables.WQ_DIAG_TOT_EXTC.name = 'Ext. Coef';
% Variables.WQ_DIAG_TOT_EXTC.units = '-';
% Variables.WQ_DIAG_TOT_EXTC.caxis = [0 100];

Variables.WQ_PHS_FRP.name = 'FRP';
Variables.WQ_PHS_FRP.units = 'mmol/m3';
Variables.WQ_PHS_FRP.caxis = [0 1];

% Variables.WQ_DIAG_MAG_TMALG.name = 'Biomass';
% Variables.WQ_DIAG_MAG_TMALG.units = 'gDW.m/2';
% Variables.WQ_DIAG_MAG_TMALG.caxis = [0 100];
% 
% Variables.WQ_DIAG_MAG_GPP_BEN.name = 'Gross Primary Production';
% Variables.WQ_DIAG_MAG_GPP_BEN.units = '-';
% Variables.WQ_DIAG_MAG_GPP_BEN.caxis = [0 100];
% 
% Variables.WQ_DIAG_MAG_RSP_BEN.name = 'Respiring';
% Variables.WQ_DIAG_MAG_RSP_BEN.units = '-';
% Variables.WQ_DIAG_MAG_RSP_BEN.caxis = [0 100];
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
