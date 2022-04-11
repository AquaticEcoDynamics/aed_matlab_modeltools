%% TFV Scenario Comparison MAIN %%

% Main script to compare TUFLOW FV scenarios. Requires
% FlowComparison.m,Flow_ScenarioComparison_Index.csv,WQ_LongitudinalComparison.m,
% WQ_TimeseriesComparison.m,SouthCreek_TSPoints.shp,SouthCreek_LongPoints.shp

% Kaushal Kumandur
% R2018a

clear
close all
clc
%% All User Input

% Directory where this script is
ScriptDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\30_1_Modelling\Script\TUFLOW\TUFLOW FV Scenario Comparison\';
cd(ScriptDir);
addpath(genpath(ScriptDir));

% Parent Directory where all necessary TUFLOW MATLAB scripts are, such as
% netcdf_get_var
SupportingScriptsDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\30_1_Modelling\Script\';
addpath(genpath(SupportingScriptsDir));

% Directory where shapefiles required for this code are
ShapefileDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\30_1_Modelling\Script\TUFLOW\TUFLOW FV Shapefiles for Scripts';


%% User Input %%

% Enter scenario comparison Start and End date as dd/mm/yyyy. This clips
% the raw data to the required period. Use this to omit any warmup period
% within the result file
StartDate = inputdlg('Enter scenario comparison start date as dd/mm/yyyy','Scenario start date');
StartDate = StartDate{1,1};
StartDate = datetime(StartDate,'InputFormat','dd/MM/yyyy');

EndDate = inputdlg('Enter scenario comparison end date as dd/mm/yyyy','Scenario end date');
EndDate = EndDate{1,1};
EndDate = datetime(EndDate,'InputFormat','dd/MM/yyyy');

Date = [StartDate:hours(1):EndDate]';
TR = timerange(StartDate,EndDate,'closed');

% Choose Flow Index file. This index file contains the Nodestring number
% matching the site that you want flows plotted.
FlowIndexFile = uigetfile('*.csv','Choose Flow Index File');

% Enter parameters.This is a block of code that allows the user to choose
% parameters using checkbox
ParamSelection = BuildCheckBox();

AllParams = {...
    'H';...
    'D';...
    'SAL';...
    'TEMP';...
    'WQ_OXY_OXY';...
    'WQ_DIAG_OXY_SAT';...
    'WQ_SIL_RSI';...
    'WQ_NIT_AMM';...
    'WQ_NIT_NIT';...
    'WQ_PHS_FRP';...
    'WQ_OGM_DOC';...
    'WQ_OGM_POC';...
    'WQ_OGM_DON';...
    'WQ_OGM_PON';...
    'WQ_OGM_DOP';...
    'WQ_OGM_POP';...
    'WQ_PHY_GRN';...
    'WQ_PHY_BGA';...
    'WQ_PHY_FDIAT';...
    'WQ_PHY_MDIAT';...
    'WQ_DIAG_TOT_TSS';...
    'WQ_DIAG_TOT_TN';...
    'WQ_DIAG_TOT_TP';...
    'WQ_DIAG_PHY_TCHLA';...
    'WQ_TRC_TR2';...
    'WQ_TRC_TR4'};

ChosenParams = find(ParamSelection.Data==1);

Params = AllParams(ChosenParams,1);

% Number of scenarios. Enter the number of scenarios you want to compare.
iSc = inputdlg('Enter the number of scenarios','Number of Scenarios');
iSc = str2double(iSc{1,1});

Res = struct;

for i = 1:iSc
    Res(i).Name = inputdlg('Enter Scenario Names','Scenario Names');
    Res(i).Name = Res(i).Name{1,1};
    Res(i).ScriptDir = ScriptDir;
end

% Baseline time of TUFLOW FV netcdf results
BaseTime = datetime(1990,1,1,0,0,0);

% Line colours for 2nd scenario onwards
Colours = {'blue','green','red','yellow'};

% Scenario numbers to produce stats for as 1X2 array with numbering of the
% scenario as per the order above. THIS IS VERY IMPORTANT TO GET THE RIGHT
% STATS IN THE STATS BOX. THIS CHANGES WHEN YOU CHANGE NUMBER OF SCENARIOS.
% THIS IS HARDCODED.
StatsFor = [1 2];

% Trigger values. Choose csv with trigger values. To add a trigger value to
% a parameter, add the parameter as per its netcdf name and the trigger
% value in the Limit columns. There are two sets for South Creek and only
% one for HN.
TriggerIdx = uigetfile('TriggerValues_*.csv','Choose Trigger Value Index file');
TriggerIdx = readtable(TriggerIdx,'delimiter',',');

cd(ShapefileDir);
% Read shapefile of longitudinal points
LongPoints = uigetfile('*.shp','Choose shapefile for longitudinal plots');
LongPoints = shaperead(LongPoints);
% Read shapefile of timeseries points
TSPoints = uigetfile('*.shp','Choose shapefile for timeseries plots');
TSPoints = shaperead(TSPoints);

cd(ScriptDir);
% Assign all the above information to Res structure to carry it to the
% functions going forward.
for i = 1:iSc
    Res(i).BaseTime = BaseTime;    
    Res(i).Colours = Colours;
    Res(i).Params = Params;
    Res(i).LongPoints = LongPoints;
    Res(i).TSPoints = TSPoints;
    Res(i).StatsFor = StatsFor;
    Res(i).TriggerIdx = TriggerIdx;
    Res(i).Date = Date;
    Res(i).TR = TR;
end

% Assign Flow results to Res struct. This allows you to choose the FLUX
% files for each scenario as per the order of the scenarios you mentioned
% above. I have removed the option of merging multiple flux files for one
% scenario. This accepts ONLY ONE FLUX file per scenarios, which should be
% continuous, and not have duplicate times, and should cover the time
% period you mentioned above.
for i = 1:iSc    
    QIndex = readtable(FlowIndexFile,'delimiter',',');
    FV_FluxTable = table;
    cd('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Models\FV');           
    [Res(i).FlowFile,Res(i).FlowPath] = uigetfile('*_FLUX.csv',['Choose flux file for ',Res(i).Name]);
    Tbl = readtable(strcat(Res(i).FlowPath,Res(i).FlowFile));
    FV_FluxTable = Tbl;   
    Res(i).Flow = FV_FluxTable;
    Res(i).QIndex = QIndex;
end

% Assign WQ results to struct. This allows you to choose the netcdf files
% for scenarios. Same conditions apply as for FLUX files. See above.
cd('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Models\FV\');

for i = 1:iSc 
    % Number of result files per scenario    
    [Res(i).WQFile,Res(i).WQPath] = uigetfile('*.nc',['Choose WQ netcdf for ',Res(i).Name]);    
end

% Choose output directory for tables and plots
cd('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Models\FV\');
OutDir = uigetdir('','Choose Output Directory');

% Assign Output directory to Res struct
for i = 1:iSc
    Res(i).OutDir = OutDir;
end

% A waitbar graphic
f = waitbar(0.05,'Starting the comparison now....');
pause(0.5)

%% Flow Data
% Function to extract and plot flow results
FlowData = FlowComparison_SC(Res);

waitbar(0.33,f,'Flows have been plotted...');
pause(1)

cd(Res(1).ScriptDir);

%% WQ Longitudinal Data
% Function to extract and plot Longitudinal median results
WQLongData = WQ_LongitudinalComparison_SC(Res);

waitbar(0.66,f,'Longitudinal Profiles have been plotted...');
pause(1)

cd(Res(1).ScriptDir);

%% WQ Timeseries Data
% Function to extract and plot timeseries results for WQ datasets
WQTSData = WQ_TimeseriesComparison_SC(Res);

waitbar(0.9,f,'Timeseries plots have been plotted...');
pause(1)

cd(Res(1).ScriptDir);

waitbar(1,f,'Scenario Comparison finished successfully');
pause(1)

close(f)

sprintf('Scenario Comparison finished successfully')

%% Function to get user input for variables to compare %%
function ParamSelection = BuildCheckBox()
    ParamCbox = figure('Name','Parameter Selection','Position',[350 300 1020 600]);
    
    ParamSelection = struct;
    
    Cb(1) = uicontrol(ParamCbox,'Style','checkbox','String','Water Level','Value',1,...
        'Position',[40 550 370 20]);
    Cb(2) = uicontrol(ParamCbox,'Style','checkbox','String','Water Depth','Value',0,...
        'Position',[40 500 370 20]);
    Cb(3) = uicontrol(ParamCbox,'Style','checkbox','String','Salinity','Value',1,...
        'Position',[40 450 370 20]);
    Cb(4) = uicontrol(ParamCbox,'Style','checkbox','String','Temperature','Value',0,...
        'Position',[40 400 370 20]);    
    Cb(5) = uicontrol(ParamCbox,'Style','checkbox','String','Dissolved Oxygen','Value',1,...
        'Position',[40 350 370 20]);
    Cb(6) = uicontrol(ParamCbox,'Style','checkbox','String','Dissolved Oxygen Saturation %','Value',1,...
        'Position',[40 300 370 20]);
    Cb(7) = uicontrol(ParamCbox,'Style','checkbox','String','Silicates','Value',0,...
        'Position',[40 250 370 20]);
    Cb(8) = uicontrol(ParamCbox,'Style','checkbox','String','Ammonia','Value',1,...
        'Position',[40 200 370 20]);
    Cb(9) = uicontrol(ParamCbox,'Style','checkbox','String','NOx','Value',1,...
        'Position',[40 150 370 20]);
    Cb(10) = uicontrol(ParamCbox,'Style','checkbox','String','Filterable Reactive Phosphorus','Value',1,...
        'Position',[40 100 370 20]);
    Cb(11) = uicontrol(ParamCbox,'Style','checkbox','String','Dissolved Organic Carbon','Value',0,...
        'Position',[410 550 370 20]);
    Cb(12) = uicontrol(ParamCbox,'Style','checkbox','String','Particulate Organic Carbon','Value',0,...
        'Position',[410 500 370 20]);
    Cb(13) = uicontrol(ParamCbox,'Style','checkbox','String','Dissolved Organic Nitrogen','Value',0,...
        'Position',[410 450 370 20]);
    Cb(14) = uicontrol(ParamCbox,'Style','checkbox','String','Particulate Organic Nitrogen','Value',0,...
        'Position',[410 400 370 20]);
    Cb(15) = uicontrol(ParamCbox,'Style','checkbox','String','Dissolved Organic Phosphorus','Value',0,...
        'Position',[410 350 370 20]);
    Cb(16) = uicontrol(ParamCbox,'Style','checkbox','String','Particulate Organic Phosphorus','Value',0,...
        'Position',[410 300 370 20]);
    Cb(17) = uicontrol(ParamCbox,'Style','checkbox','String','Green Phytoplankton','Value',0,...
        'Position',[410 250 370 20]);
    Cb(18) = uicontrol(ParamCbox,'Style','checkbox','String','Blue-green Phytoplankton','Value',0,...
        'Position',[410 200 370 20]);
    Cb(19) = uicontrol(ParamCbox,'Style','checkbox','String','Freshwater Diatoms','Value',0,...
        'Position',[410 150 370 20]);
    Cb(20) = uicontrol(ParamCbox,'Style','checkbox','String','Marine Diatoms','Value',0,...
        'Position',[410 100 370 20]);
    Cb(21) = uicontrol(ParamCbox,'Style','checkbox','String','Total Suspended Solids','Value',1,...
        'Position',[780 550 370 20]);
    Cb(22) = uicontrol(ParamCbox,'Style','checkbox','String','Total Nitrogen','Value',1,...
        'Position',[780 500 370 20]);
    Cb(23) = uicontrol(ParamCbox,'Style','checkbox','String','Total Phosphorus','Value',1,...
        'Position',[780 450 370 20]);
    Cb(24) = uicontrol(ParamCbox,'Style','checkbox','String','Total Chlorophyll-a','Value',1,...
        'Position',[780 400 370 20]);
    Cb(25) = uicontrol(ParamCbox,'Style','checkbox','String','Ecoli','Value',0,...
        'Position',[780 350 370 20]);
    Cb(26) = uicontrol(ParamCbox,'Style','checkbox','String','Enterococci','Value',0,...
        'Position',[780 300 370 20]);
    
    Value = [];
    
    DoneButton = uicontrol(ParamCbox,'Style','pushbutton','String','Done',...
        'Position',[500 20 80 20],'Callback',@ParamSelectionDone);
    
    function ParamSelectionDone(hObject,eventdata)
        for i = 1:size(Cb,2)
            Value(i,1) = get(Cb(i),'Value');
        end
        ParamSelection(1).Data = Value;
        uiresume(ParamCbox)
        close(ParamCbox);
    end
    
    uiwait(ParamCbox)

    ParamSelection;
end

