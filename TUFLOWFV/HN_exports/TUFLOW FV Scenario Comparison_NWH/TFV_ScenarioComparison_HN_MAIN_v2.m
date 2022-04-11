%% TFV Scenario Comparison MAIN v2 %%

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

ScnUIindexFiles = {'Index_Scn05_Scn01_Scn00_DRY_HN.csv';...
    'Index_Scn05_Scn01_Scn00_WET_HN.csv';...
    'Index_Scn06_Scn02_Scn00_DRY_HN.csv';...
    'Index_Scn06_Scn02_Scn00_WET_HN.csv';...
    'Index_Scn07_Scn03_Scn00_DRY_HN.csv';...
    'Index_Scn07_Scn03_Scn00_WET_HN.csv';...
    'Index_Scn08_Scn04_Scn00_DRY_HN.csv';...
    'Index_Scn08_Scn04_Scn00_WET_HN.csv';...
    'Index_Scn13_Scn01_Scn00_DRY_HN.csv';...
    'Index_Scn13_Scn01_Scn00_WET_HN.csv';...
    'Index_Scn14_Scn02_Scn00_DRY_HN.csv';...
    'Index_Scn14_Scn02_Scn00_WET_HN.csv';...
    'Index_Scn15_Scn03_Scn00_DRY_HN.csv';...
    'Index_Scn15_Scn03_Scn00_WET_HN.csv';...
    'Index_Scn16_Scn04_Scn00_DRY_HN.csv';...
    'Index_Scn16_Scn04_Scn00_WET_HN.csv';...
    'Index_Scn17_Scn01_Scn00_DRY_HN.csv';...
    'Index_Scn17_Scn01_Scn00_WET_HN.csv'};

isZoomFlow = 1;
isZoomLong = 1;

for iScnIdx = 1:18
    sprintf('Running Scenario set %d of 18',iScnIdx)
    
    %% User Input %%
    UIindex = readtable(ScnUIindexFiles{iScnIdx,1},'delimiter',',');

    Res = struct;

    for i = 1:size(UIindex,1)

        Res(i).Name = UIindex.ScnName{i,1};
        Res(i).ScriptDir = UIindex.ScriptDir{i,1};
        Res(i).OutDir = UIindex.OutDir{i,1};

        Res(i).StartDate = UIindex.StartDate(i,1);
        Res(i).EndDate = UIindex.EndDate(i,1);
        Res(i).Date = [Res(i).StartDate:hours(1):Res(i).EndDate]';
        Res(i).Date.Format = 'dd/MM/yyyy HH:mm';
        Res(i).TR = timerange(Res(i).StartDate,Res(i).EndDate,'closed');

        Res(i).PointIdx = readtable(UIindex.PointIdxFile{i,1},'delimiter',',');

        Res(i).TriggerIdx = readtable(UIindex.TriggerIdxFile{i,1},'delimiter',',');

        Res(i).FlowIndexFile = UIindex.FlowIndexFile{i,1};
        QIndex = readtable(Res(i).FlowIndexFile,'delimiter',',');
        Res(i).QIndex = QIndex;
        Res(i).Flow = readtable(UIindex.FluxFile{i,1},'delimiter',',');

        Res(i).WQPath = UIindex.WQPath{i,1};
        Res(i).WQFile = UIindex.WQFile{i,1};
        
        Res(i).ZoomBaseflow = [ScriptDir,'ZoomInBaseflow.csv'];
        Res(i).IsZoomFlow = isZoomFlow;
        Res(i).ZoomLong = [ScriptDir,'ZoomInLongPlots.csv'];
        Res(i).IsZoomLong = isZoomLong;
    end

    Params = {'H';...        
        'SAL';...
        'TEMP';...
        'WQ_OXY_OXY';...
        'WQ_DIAG_OXY_SAT';...        
        'WQ_NIT_AMM';...
        'WQ_NIT_NIT';...
        'WQ_PHS_FRP';...        
        'WQ_DIAG_TOT_TSS';...
        'WQ_DIAG_TOT_TN';...
        'WQ_DIAG_TOT_TP';...
        'WQ_DIAG_PHY_TCHLA';...
        'WQ_TRC_TR1';...
        'WQ_TRC_TR2'};
%     Params = {'WQ_TRC_TR2'};
    
    % Line colours for 2nd scenario onwards
    Colours = {'blue','green','red','yellow'};

    % Scenario numbers to produce stats for as 1X2 array with numbering of the
    % scenario as per the order above. THIS IS VERY IMPORTANT TO GET THE RIGHT
    % STATS IN THE STATS BOX. THIS CHANGES WHEN YOU CHANGE NUMBER OF SCENARIOS.
    % THIS IS HARDCODED.
    StatsFor = [2 3];

    % Trigger values. Choose csv with trigger values. To add a trigger value to
    % a parameter, add the parameter as per its netcdf name and the trigger
    % value in the Limit columns. There are two sets for South Creek and only
    % one for HN.


    % Assign all the above information to Res structure to carry it to the
    % functions going forward.
    for i = 1:size(Res,2)
        Res(i).Colours = Colours;
        Res(i).Params = Params;   
        Res(i).StatsFor = StatsFor;   
    end

    % A waitbar graphic
    f = waitbar(0.05,'Starting the comparison now....');
    pause(0.5)

    %% Flow Data
    % Function to extract and plot flow results
%     FlowData = FlowComparison_HN(Res);

    waitbar(0.33,f,'Flows have been plotted...');
    pause(1)

    cd(Res(1).ScriptDir);

    %% WQ Longitudinal Data
    % Function to extract and plot Longitudinal median results

    WQLongData = WQ_LongitudinalComparison_HN(Res);

    waitbar(0.66,f,'Longitudinal Profiles have been plotted...');
    pause(1)

    cd(Res(1).ScriptDir);

    %% WQ Timeseries Data
    % Function to extract and plot timeseries results for WQ datasets

%     WQTSData = WQ_TimeseriesComparison_HN(Res);

    waitbar(0.9,f,'Timeseries plots have been plotted...');
    pause(1)

    cd(Res(1).ScriptDir);

    waitbar(1,f,'Scenario Comparison finished successfully');
    pause(1)

    close(f)

    sprintf('Scenario Comparison finished successfully')

end