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

ScnUIindexFiles = {'Index_Scn05_Scn02_Scn00_DRY.csv'};
%     'Index_Scn06_Scn04_Scn00_DRY.csv';...
%     'Index_Scn07_Scn01_Scn00_DRY.csv';...
%     'Index_Scn08_Scn03_Scn00_DRY.csv'};    

for iScnIdx = 1:4
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
    end

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


    % Assign all the above information to Res structure to carry it to the
    % functions going forward.
    for i = 1:size(Res,1)
        Res(i).Colours = Colours;
        Res(i).Params = Params;   
        Res(i).StatsFor = StatsFor;   
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

end

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

