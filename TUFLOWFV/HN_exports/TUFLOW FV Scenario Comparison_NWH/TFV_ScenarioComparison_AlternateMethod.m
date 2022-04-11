%% TFV Scenario comparison - Alternate Method

% Kaushal Kumandur R2018a
ScriptDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\30_1_Modelling\Script\TUFLOW\TUFLOW FV Scenario Comparison';
addpath(genpath(ScriptDir));

[PointsFile,PointsPath] = uigetfile('*.csv','Select Profile Points File');
cd(PointsPath);
PointsFile = readtable(PointsFile);


ModDir = uigetdir('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\','ModDir?');
ModDir2 = uigetdir('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\','ModDir2?');
ModDir3 = uigetdir('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\','ModDir3?');

cd(ScriptDir);
TR = timerange('1-Jul-2013 00:00','28-Jun-2014 23:00','closed');

WQData = struct('Name',[],'Param',[],'Mod',[],'Mod2',[],'Mod3',[]);

ModVars = {'SAL','TEMP','TOT_TN','TOT_TP',...
    'PHY_TCHLA','TOT_TSS'};

Units = {'g per L','deg C','mg per L','mg per L','micro g per L','mg per L'};

Multipliers = [1,1,0.014,0.031,1,1];

YLimits = [2,50,10,2,200,150];

warning('off')
counter = 1;

for i = 1:size(PointsFile,1)    
    
    for j = 1:size(ModVars,2)
        WQData(counter).Name = PointsFile.Name{i,1};
        WQData(counter).Param = ModVars{1,j};
        WQData(counter).YLim = YLimits(1,j);
        WQData(counter).Unit = Units{1,j};

        cd(ModDir);
        ModFiles = dir(['*',ModVars{1,j},'*',WQData(counter).Name,'*.csv']);
        ModTable = table;
        for k = 1:size(ModFiles,1)
            Tbl = readtable(ModFiles(k).name,'delimiter',',');
            ModTable = [ModTable;Tbl];
        end        
        ModTable = table2timetable(ModTable);
        ModTable = ModTable(TR,:);
        ModTable.(1) = ModTable.(1)*Multipliers(1,j);
        WQData(counter).Mod = ModTable;
        WQData(counter).Mod.Properties.VariableNames = {'Modelled'};

        cd(ModDir2);
        ModFiles2 = dir(['*',ModVars{1,j},'*',WQData(counter).Name,'*.csv']);
        ModTable2 = table;
        for k = 1:size(ModFiles2,1)
            Tbl = readtable(ModFiles2(k).name,'delimiter',',');
            ModTable2 = [ModTable2;Tbl];
        end        
        ModTable2 = table2timetable(ModTable2);
        ModTable2 = ModTable2(TR,:);
        ModTable2.(1) = ModTable2.(1)*Multipliers(1,j);
        WQData(counter).Mod2 = ModTable2;
        WQData(counter).Mod2.Properties.VariableNames = {'Modelled_2'};
        
        cd(ModDir3);
        ModFiles3 = dir(['*',ModVars{1,j},'*',WQData(counter).Name,'*.csv']);
        ModTable3 = table;
        for k = 1:size(ModFiles3,1)
            Tbl = readtable(ModFiles3(k).name,'delimiter',',');
            ModTable3 = [ModTable3;Tbl];
        end        
        ModTable3 = table2timetable(ModTable3);
        ModTable3 = ModTable3(TR,:);
        ModTable3.(1) = ModTable3.(1)*Multipliers(1,j);
        WQData(counter).Mod3 = ModTable3;
        WQData(counter).Mod3.Properties.VariableNames = {'Modelled_3'};
        
        counter = counter+1;
    end    
end
warning('on')

outdir = uigetdir('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Models\FV\SC','Select Output Dir');
cd(outdir);
mkdir('ScnCompare');
cd('ScnCompare');
for i = 1:size(WQData,2)
    if contains(WQData(i).Param,'_') == 1
        ParamSplit = strsplit(WQData(i).Param,'_');
        Parameter = ParamSplit{1,2};
    else
        Parameter = WQData(i).Param;
    end
    Unit = WQData(i).Unit;
    
    TempTable = synchronize(WQData(i).Mod,WQData(i).Mod2,WQData(i).Mod3);
    
    writetable(timetable2table(TempTable),[WQData(i).Name '_' Parameter,'.csv'],...
        'WriteRowNames',1,'WriteVariableNames',1);
    
    WQData(i).Fig = figure('units','normalized','outerposition',[0 0 1 1]);
    plot(WQData(i).Mod.Date,WQData(i).Mod.Modelled,'color','blue','LineWidth',1);
    title([WQData(i).Name ' ' Parameter]);
    hold on;
    plot(WQData(i).Mod2.Date,WQData(i).Mod2.Modelled_2,'color','green','LineWidth',1);
    plot(WQData(i).Mod3.Date,WQData(i).Mod3.Modelled_3,'color','black','LineWidth',1);    
    ax = gca;
    ax.FontSize = 14;
    legend({'34a Initial','34a rerun','34a rerun'},'location','northeast');
    ylim([0 WQData(i).YLim]);
    xlabel('Date');
    ylabel([Parameter,' in ',Unit]);
    hold off;
    saveas(WQData(i).Fig,[WQData(i).Name '_' Parameter],'jpg'); 
    close all
end