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
Configuration.model = 'Z:\Amina\Swan_2019_2020_Res_KL_Resp\Output\SCERM8_2019_2020_R2.nc';
% Output directory
Configuration.output_directory = 'Example_Output\tfv_export_flood\' ;
% Start time of Plot
Configuration.time_start = '31/12/2019' ;
% End time of Plot
Configuration.time_end = '31/03/2020';
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

Variables.SAL.name = 'Salinity';
Variables.SAL.units = 'psu';
Variables.SAL.caxis = [0 40];

Variables.H.name = 'Height';
Variables.H.units = 'm';
Variables.H.caxis = [-1 2];

Variables.WQ_OXY_OXY.name = 'Oxygen';
Variables.WQ_OXY_OXY.units = 'mmol/m3';
Variables.WQ_OXY_OXY.caxis = [0 200];
%




%_________________________________________________________________________%
%                                                                         %
%   Location Configuration                                                %
%_________________________________________________________________________%


% Each site needs an ID as it's base, X,Y and Full Name

Sites.Site1.X = 391366.25;
Sites.Site1.Y = 6463072.05;
Sites.Site1.name = 'Narrows';

Sites.Site2.X = 401953.32;
Sites.Site2.Y = 6469699.15;
Sites.Site2.name = 'Helena';

Sites.Site3.X = 401603.56;
Sites.Site3.Y = 6470767.98;
Sites.Site3.name = 'Guildford';

Sites.Site4.X = 388706;
Sites.Site4.Y = 6460953;
Sites.Site4.name = 'Matilda';

Sites.Site4.X = 390711;
Sites.Site4.Y = 6459090;
Sites.Site4.name = 'Kwilena';
