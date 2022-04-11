function run_CopyScnFigures_HN(uiScenario,uiScnName)%% Copy figures to word document %%
    % Code to copy different scenario png or jpeg files directly to
    % Microsoft Word pages for easier copying into the EIS scenario report
    % Kaushal Kumandur
    % R2020b
    % Requires MATLAB to be in an environment where a relatively new version of
    % Microsoft Word is also available.

    %% User Input %%

    WorkDir = 'C:\Users\sqn\Documents\20210902_FiguresToCopy_EIS_ScenarioReport\';

    Folders = {'HN'};

    FolderNameToPrint = {'Hawkesbury-Nepean WQRM'};

    Scenario = {uiScenario};

    ScnName = {uiScnName};

    PlotTypes = {'Longitudinal plot','Timeseries plots','Box plots'};

%     Locations = {'Upstream_WallaciaWeir','DS_WallaciaWeir_500m','DS_WarragambaRivulet','DS_14_KM',...
%         'Upstream_PenrithWeir','DS_PenrithWeir','Downstream_CattaiCk','SackvilleBend'};

    Locations = {'Upstream_WallaciaWeir','DS_WallaciaWeir_500m','Upstream_AWRC_Warragamba',...
        'Downstrean_AWRC_Warragamba','DS_WarragambaRivulet','DS_14_KM',...
        'Upstream_PenrithWeir','DS_PenrithWeir','Downstream_CattaiCk','SackvilleBend'};    

    Vars = {'Total Nitrogen','Ammonia','NOx','Total Phosphorus','FRP',...
        'Total Chlorophyll-a','Salinity','TSS','Dissolved Oxygen',...
        'Dissolved Oxygen Saturation','Ecoli','Enterococci','Cyano'};

    VarUnits = {'mg/L','mg/L','mg/L','mg/L','mg/L',...
        [char(181),'g/L'],'g/L','mg/L','mg/L',...
        '%','cfu/100mL','cfu/100mL',''};

    word = actxserver('word.application');
    word.Visible = true;
    document = word.Documents.Add;
    selection = word.Selection;

    for i = 1:length(Folders)

        for j = 1:length(Vars)
            DomainFolderName = Folders{i};
            for iLineBreak = 1:4
                selection.InsertBreak(6);
            end
            selection.Font.Name = 'Arial';
            selection.Font.Size = 22;
            selection.ParagraphFormat.Alignment = 0;
            selection.Font.Italic = 1;
            selection.Font.Bold = 0;
            selection.TypeText(FolderNameToPrint{i});
            selection.TypeParagraph;

            selection.Font.Name = 'Arial';
            selection.Font.Size = 20;
            selection.ParagraphFormat.Alignment = 0;
            selection.Font.Italic = 0;
            selection.Font.Bold = 0;
            selection.TypeText(Vars{j});
            selection.TypeText(' ');
            selection.TypeText(['(',VarUnits{j},')']);
            selection.TypeParagraph;

            selection.Font.Name = 'Arial';
            selection.Font.Size = 17;
            selection.ParagraphFormat.Alignment = 0;
            selection.Font.Italic = 0;
            selection.Font.Bold = 0;
            selection.TypeText(ScnName{1});        
            selection.TypeParagraph;

            for iLineBreak = 1:2
                selection.InsertBreak(6);
            end
            
            if strcmp(Vars{j},'Cyano')
                selection.Font.Name = 'Arial';
                selection.Font.Size = 16;
                selection.ParagraphFormat.Alignment = 0;
                selection.Font.Italic = 0;
                selection.Font.Bold = 0;
                selection.TypeText('--> Timeseries plots for reaches');        
                selection.TypeParagraph;
            else
                selection.Font.Name = 'Arial';
                selection.Font.Size = 16;
                selection.ParagraphFormat.Alignment = 0;
                selection.Font.Italic = 0;
                selection.Font.Bold = 0;
                selection.TypeText('--> Longitudinal plots');        
                selection.TypeParagraph;

                selection.Font.Name = 'Arial';
                selection.Font.Size = 16;
                selection.ParagraphFormat.Alignment = 0;
                selection.Font.Italic = 0;
                selection.Font.Bold = 0;
                selection.TypeText('--> Timeseries plots at geographic markers and gauge locations');        
                selection.TypeParagraph;

                selection.Font.Name = 'Arial';
                selection.Font.Size = 16;
                selection.ParagraphFormat.Alignment = 0;
                selection.Font.Italic = 0;
                selection.Font.Bold = 0;
                selection.TypeText('--> Box plots at geographic markers and gauge locations');        
                selection.TypeParagraph;
            end

            selection.InsertBreak(7);

            for k = 1:length(PlotTypes)
                selection.Font.Name = 'Arial';
                selection.Font.Size = 16;
                selection.ParagraphFormat.Alignment = 0;
                selection.Font.Italic = 0;
                selection.Font.Bold = 1;
                selection.TypeText(PlotTypes{k});        
                selection.TypeParagraph;

                if strcmp(PlotTypes{k},'Timeseries plots')==1 || strcmp(PlotTypes{k},'Box plots')==1
                    SubFolder = 'Scenario TS plots and tables v2';
                elseif strcmp(PlotTypes{k},'Longitudinal plot')==1
                    SubFolder = 'Scenario LP plots and tables';            
                end

                if strcmp(Vars{j},'Cyano')==1
                    SubFolder = 'Cyano';
                end

                ImageDir = [WorkDir,Folders{i},'\',Scenario{1},'\',SubFolder,'\'];
                cd(ImageDir);

                Images = struct;
                switch PlotTypes{k}
                    case 'Longitudinal plot'
                        Images(1).name = ['LP Median for ',Vars{j},'.jpg'];
                    case 'Timeseries plots'
                        for iLoc = 1:length(Locations)                
                            Images(iLoc).name = ['TS at ',Locations{iLoc},' for ',Vars{j},'.jpg'];
                        end
                    case 'Box plots'
                        for iLoc = 1:length(Locations)
                            Images(iLoc).name = ['BoxPlot at ',Locations{iLoc},' for ',Vars{j},'.jpg'];
                        end                
                    case 'Cyano'
                        Images(1).name = 'Will get overwritten by Cyano condition in next block';
                    otherwise
                        error('Not matching plot type')            
                end

                if strcmp(Vars{j},'Cyano')==1
                    Images = dir('*.png');
                    Images = Images';
                end

                for l = 1:size(Images,2)
                    FigInWord = selection.InlineShapes.AddPicture([ImageDir,Images(l).name],0,1);
                    FigInWord.LockAspectRatio = 1;

                    switch PlotTypes{k}
                        case 'Longitudinal plot'
                            FigInWord.ScaleHeight = 30;
                        case 'Timeseries plots'
                            FigInWord.ScaleHeight = 12.5;
                        case 'Box plots'
                            FigInWord.ScaleHeight = 12.5;
                        case 'Cyano'
                            sprintf('.')
                        otherwise
                            error('Not matching plot type')                
                    end

                    if strcmp(Vars{j},'Cyano')==1
                        FigInWord.ScaleHeight = 15.5;
                    end

                    if mod(l,2) == 0
                        selection.TypeParagraph;
                        %selection.TypeParagraph;
                    end

                end

                selection.InsertBreak(7);
            end        
        end
    end
end