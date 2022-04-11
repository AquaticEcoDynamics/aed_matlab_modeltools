%% Rename and move Scenario Plots that were wrongly plotted %%

ScriptDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\30_1_Modelling\Script\TUFLOW\TUFLOW FV Scenario Comparison\';

Idx = readtable('N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Models\FV\HNupgrade\geo\IndexForMismatchInNames.csv',...
    'delimiter',',');

OldDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Analysis\20210506_HN_ScenarioComparison_Pathogens\';
NewDir = 'N:\Asset Knowledge\Manage Projects\ASCM HN UpdateProject\20_1_Data\TUFLOW\Analysis\20210511_HN_ScenarioComparison_Plots_Renamed\';

Folders = {'Scn05_Scn01_Scn00_DRY';...
    'Scn05_Scn01_Scn00_WET';...
    'Scn06_Scn02_Scn00_DRY';...
    'Scn06_Scn02_Scn00_WET';...
    'Scn07_Scn03_Scn00_DRY';...
    'Scn07_Scn03_Scn00_WET';...
    'Scn08_Scn04_Scn00_DRY';...
    'Scn08_Scn04_Scn00_WET';...
    'Scn13_Scn01_Scn00_DRY';...
    'Scn13_Scn01_Scn00_WET';...
    'Scn14_Scn02_Scn00_DRY';...
    'Scn14_Scn02_Scn00_WET';...
    'Scn15_Scn03_Scn00_DRY';...
    'Scn15_Scn03_Scn00_WET';...
    'Scn16_Scn04_Scn00_DRY';...
    'Scn16_Scn04_Scn00_WET'};

for i = 1:size(Folders,1)
    
    cd(OldDir);
    cd(Folders{i,1});
    cd('Scenario TS plots and tables');
    Files = [dir('*.jpg');dir('*.csv')];
    Files = {Files.name}';
    
    for j = 1:size(Files,1)
        
        sprintf('Running file %d of %d in Folder %d of %d',j,size(Files,1),i,size(Folders,1))
        
        OldPath = [OldDir,Folders{i,1},'\Scenario TS plots and tables\'];
        FileName = strsplit(Files{j,1},{' ','.'});
        if size(FileName,2) == 6
            Param = FileName{1,5};
            FileType = FileName{1,6};
        elseif size(FileName,2) == 7
            Param = [FileName{1,5},' ',FileName{1,6}];
            FileType = FileName{1,7};
        elseif size(FileName,2) == 8
            Param = [FileName{1,5},' ',FileName{1,6},' ',FileName{1,7}];
            FileType = FileName{1,8};
        else
            error('Size of FileName')
        end
        PlotType = FileName{1,1};
        Location = FileName{1,3};
        IdxRow = find(strcmp(Location,Idx.ExistingName));
        NewLocation = Idx.CorrectName{IdxRow,1};
        cd([NewDir,Folders{i,1}]);
        if j == 1
            mkdir('Scenario TS plots and tables');
        end
        NewPath = [NewDir,Folders{i,1},'\Scenario TS plots and tables\'];
        Status = copyfile([OldPath,Files{j,1}],[NewPath,PlotType,' at ',NewLocation,' for ',Param,'.',FileType]);
        if Status ~= 1
            error('Wrong')
        end        
    end
    
end
    
