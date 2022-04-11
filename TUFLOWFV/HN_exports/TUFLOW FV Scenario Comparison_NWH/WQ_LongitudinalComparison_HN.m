function Data2 = WQ_LongitudinalComparison_HN(Res)
    %% Function to generate longitudinal plots for different scenario to compare %%
    ScriptDir = pwd;
    
    LongRows = find(strcmp(Res(1).PointIdx.Type,'Long'));
    LongIdx = Res(1).PointIdx(LongRows,:);
    PointNames = LongIdx.Pt;
    PointNames = strcat(PointNames,'_');
    SiteNames = LongIdx.Name';
    XAxisCngNames = strrep(LongIdx.Name,'_',' ');
    
    ZoomLongParams = readtable(Res(1).ZoomLong,'delimiter',',');
    
    % Read raw data from netcdf
    Data = struct;

    for i = 1:size(Res,2)
        cd(Res(i).WQPath);
        Data(i).Name = Res(i).Name;        
        tic;
        RawFull = readtable(Res(i).WQFile,'delimiter',',');
        sprintf('Reading data from Scenario %s',Data(i).Name)
        Data(i).Raw = RawFull;
        Cols = find(contains(Data(i).Raw.Properties.VariableNames,PointNames));        
        Cols = [1,Cols];
        Data(i).Raw = Data(i).Raw(:,Cols);
        ADScols = find(contains(Data(i).Raw.Properties.VariableNames,'_ADS'));
        Data(i).Raw(:,ADScols) = [];
        toc;
        FinTime = round(double(toc),1);
        sprintf('Finished extracting raw data from Scenario %s in %0.1f second',Data(i).Name,FinTime)   
    end

    cd(ScriptDir);

    % Rearrange raw data
    Data2 = struct;
    counter = 1;
    for i = 1:size(Res(1).Params,1)    
        for j = 1:size(Res,2)
            ScRows = find(strcmp(Res(j).Name,{Data.Name}));
            Data2(counter).Param = Res(j).Params{i,1};
            Data2(counter).Sc = Res(j).Name;
            
            ParamCol = find(contains(Data(j).Raw.Properties.VariableNames,['_',Data2(counter).Param]));
            ParamCol = [1,ParamCol];
            TempTable = Data(j).Raw(:,ParamCol);
            TempTable.Properties.VariableNames{1,1} = 'Date';
            TempTable.Date = datetime(TempTable.Date,'InputFormat','dd-MM-yyyy HH:mm');
            TempTable.Date = dateshift(TempTable.Date,'start','minute','nearest');
            TempTable.Date.Format = 'dd/MM/yyyy HH:mm';            
            Data2(counter).Raw = TempTable;            
            TempTable = [];
            counter = counter+1;
        end
    end
    
    % Perform calcs on rearranged data to get medians
    for i = 1:size(Data2,2)
        Data2(i).TT = table2timetable(Data2(i).Raw);
        Data2(i).TT.Properties.VariableNames = SiteNames;
        Data2(i).TT = retime(Data2(i).TT,'daily','nearest');
        Data2(i).TT = Data2(i).TT(Res(1).TR,:);
        Data2(i).Median = varfun(@median,Data2(i).TT);
        
        TriggerRow = find(strcmp(Data2(i).Param,Res(1).TriggerIdx.Param));
        if ~isempty(TriggerRow) == 1
            Data2(i).TriggerValue = Res(1).TriggerIdx.Limit(TriggerRow,1);            
        else
            Data2(i).TriggerValue = NaN;
        end       
    end

    % Change to output directory
    cd(Res(1).OutDir);
    mkdir('Scenario LP plots and tables');
    cd('Scenario LP plots and tables');

    % Tables and Plots for every parameter
    for i = 1:size(Res(1).Params,1)

        Table = table(LongIdx.ID);
        Table.Properties.VariableNames{1,1} = 'Chainage';
        
        % Find all scenarios in Data2 for this parameter
        Parameter = Res(1).Params{i,1};
        ParamRows = find(strcmp(Parameter,{Data2.Param}));
        TriggerValue = Data2(ParamRows(1,1)).TriggerValue;
                       
        % Function to get parameter related info including conversion from
        % FV to SI units
        [ConversionFactor,ParamStdName,ParamUnit,ParamYLim] = UnitConvLong(Parameter);

        % Populate tables with medians from each scenario
        for j = 1:size(ParamRows,2)
            TempArray = timetable2table(Data2(ParamRows(1,j)).Median);
            TempArray(:,1) = [];
            TempArray = table2array(TempArray)';
            TempArray = TempArray.*ConversionFactor;
            Table.(j+1) = TempArray;
            Table.Properties.VariableNames{1,j+1} = Data2(ParamRows(1,j)).Sc;            
        end
        CurrentSize = size(Table,2);
        Table.(CurrentSize+1) = repmat(TriggerValue,size(Table,1),1);        
        Table.Properties.VariableNames{1,end} = 'ANZECCtrigger';
        
        % Write tables
        writetable(Table,['LP Median for ',ParamStdName,'.csv'],...
            'WriteRowNames',1,'WriteVariableNames',1);    

        % Plot Figures
        MedianFig = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(Table.Chainage,Table.(Res(1).Name),'color','black','LineStyle','--','LineWidth',1.2);
        ax = gca;
        ax.FontSize = 22;
        title(['Longitudinal Median - ',ParamStdName]);
        hold on;
        for k = 2:size(Res,2)
            plot(Table.Chainage,Table.(Res(k).Name),'color',Res(1).Colours{1,k-1},'LineWidth',1.2);
        end
        plot(Table.Chainage,Table.ANZECCtrigger,'color','magenta','LineStyle',':','LineWidth',1.2);        
        ylim([0 ParamYLim]);
        xlim([-14 124]);
        xticks([-12:4:-4 0.3 4 8 14 20 22 26:4:34 38 40 44:4:56 58 60 66 70 76 82 88 94:6:118 122]);
        Ticks = get(ax,'xtick');
        Ticks = rot90(Ticks,1);
        XTickLabelIdx = find(ismember(LongIdx.ID,Ticks));
        XTickLabelIdx = rot90(XTickLabelIdx,2);
        xticklabels(XAxisCngNames(XTickLabelIdx,1));               
        xtickangle(90);
        xlabel('Chainage in km relative to AWRC');
        ylabel([ParamStdName ' ' ParamUnit]);    
        hold off;
        legend([{Res.Name},'ANZG DGV'],'Location','northeastoutside');
        if strcmp(ParamStdName,'Enterococci') == 1
            legend([{Res.Name},'NHMRC DGV'],'Location','northeastoutside');
        end
        ax.XAxis.FontSize = 14;        
        saveas(MedianFig,['LP Median for ',ParamStdName],'jpg');
        
        if Res(1).IsZoomLong == 1
            if ismember(Res(1).Params{i,1},ZoomLongParams.Param) == 1
                ZoomRow = find(strcmp(Res(1).Params{i,1},ZoomLongParams.Param));
                ZoomYLim = ZoomLongParams.YLim(ZoomRow,1);
                % Zoomed Plot Figures
                ZoomMedianFig = figure('units','normalized','outerposition',[0 0 1 1]);
                plot(Table.Chainage,Table.(Res(1).Name),'color','black','LineStyle','--','LineWidth',1.2);
                ax = gca;
                ax.FontSize = 22;
                title(['Longitudinal Median - ',ParamStdName]);
                hold on;
                for k = 2:size(Res,2)
                    plot(Table.Chainage,Table.(Res(k).Name),'color',Res(1).Colours{1,k-1},'LineWidth',1.2);
                end
                plot(Table.Chainage,Table.ANZECCtrigger,'color','magenta','LineStyle',':','LineWidth',1.2);
                ylim([0 ZoomYLim]);
                xlim([-14 124]);
                xticks([-12:4:-4 0.3 4 8 14 20 22 26:4:34 38 40 44:4:56 58 60 66 70 76 82 88 94:6:118 122]);
                Ticks = get(ax,'xtick');
                Ticks = rot90(Ticks,1);
                XTickLabelIdx = find(ismember(LongIdx.ID,Ticks));
                XTickLabelIdx = rot90(XTickLabelIdx,2);
                xticklabels(XAxisCngNames(XTickLabelIdx,1));                
                xtickangle(90);
                xlabel('Chainage in km relative to AWRC');
                ylabel([ParamStdName ' ' ParamUnit]);    
                hold off;
                legend([{Res.Name},'ANZG DGV'],'Location','northeastoutside');
                if strcmp(ParamStdName,'Enterococci') == 1
                    legend([{Res.Name},'NHMRC DGV'],'Location','northeastoutside');
                end
                ax.XAxis.FontSize = 14;
                saveas(ZoomMedianFig,['Zoom LP Median for ',ParamStdName],'jpg');
            end
        end

        close all
    end
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%Parameter Conversion from AED to human language
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [ConversionFactor,ParamStdName,ParamUnit,ParamYLim] = UnitConvLong(Parameter)
    switch Parameter
        case 'D'
            ConversionFactor = 1;
            ParamStdName = 'Depth';
            ParamUnit = '(m)';
            ParamYLim = inf;
        case 'H'
            ConversionFactor = 1;
            ParamStdName = 'Water Level';
            ParamUnit = '(mAHD)';
            ParamYLim = inf;
        case 'SAL'
            ConversionFactor = 1;
            ParamStdName = 'Salinity';
            ParamUnit = '(g/L)';
            ParamYLim = 5;
        case 'TEMP'
            ConversionFactor = 1;
            ParamStdName = 'Temperature';
            ParamUnit = '(^oC)';
            ParamYLim = 27;
        case 'WQ_DIAG_OXY_SAT'
            ConversionFactor = 1;
            ParamStdName = 'Dissolved Oxygen Saturation';
            ParamUnit = '(%)';
            ParamYLim = 130;
        case 'WQ_DIAG_TOT_TSS'
            ConversionFactor = 1;
            ParamStdName = 'TSS';
            ParamUnit = '(mg/L)';
            ParamYLim = 120;
        case 'WQ_OXY_OXY'
            ConversionFactor = 0.032;
            ParamStdName = 'Dissolved Oxygen';
            ParamUnit = '(mg/L)';
            ParamYLim = 10;
        case 'WQ_SIL_RSI'
            ConversionFactor = 0.028;
            ParamStdName = 'Silicates';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_NIT_AMM'
            ConversionFactor = 0.014;
            ParamStdName = 'Ammonia';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.15;
        case 'WQ_NIT_NIT'
            ConversionFactor = 0.014;
            ParamStdName = 'NOx';
            ParamUnit = '(mg/L)';
            ParamYLim = 1.5;
        case 'WQ_PHS_FRP'
            ConversionFactor = 0.031;
            ParamStdName = 'FRP';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.06;
        case 'WQ_PHS_FRP_ADS'
            ConversionFactor = 0.031;
            ParamStdName = 'Adsorbed FRP';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DOC'
            ConversionFactor = 0.012;
            ParamStdName = 'Dissolved Organic Carbon';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_POC'
            ConversionFactor = 0.012;
            ParamStdName = 'Particulate Organic Carbon';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DON'
            ConversionFactor = 0.014;
            ParamStdName = 'Dissolved Organic Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_PON'
            ConversionFactor = 0.014;
            ParamStdName = 'Particulate Organic Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_DOP'
            ConversionFactor = 0.031;
            ParamStdName = 'Dissolved Organic Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_OGM_POP'
            ConversionFactor = 0.031;
            ParamStdName = 'Particulate Organic Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = inf;
        case 'WQ_DIAG_PHY_TCHLA'
            ConversionFactor = 1;
            ParamStdName = 'Total Chlorophyll-a';
            ParamUnit = '(\mug/L)';
            ParamYLim = 30;
        case 'WQ_DIAG_TOT_TN'
            ConversionFactor = 0.014;
            ParamStdName = 'Total Nitrogen';
            ParamUnit = '(mg/L)';
            ParamYLim = 3;
        case 'WQ_DIAG_TOT_TP'
            ConversionFactor = 0.031;
            ParamStdName = 'Total Phosphorus';
            ParamUnit = '(mg/L)';
            ParamYLim = 0.2;
        case 'WQ_PHY_GRN'
            ConversionFactor = 1;
            ParamStdName = 'Green Phytoplankton';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_BGA'
            ConversionFactor = 1;
            ParamStdName = 'Blue-green Phytoplankton';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_FDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Freshwater Diatom';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_PHY_MDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Marine Diatom';
            ParamUnit = '(\mug/L)';
            ParamYLim = inf;
        case 'WQ_TRC_TR1'
            ConversionFactor = 1;
            ParamStdName = 'Ecoli';
            ParamUnit = '(cfu/100mL)';
            ParamYLim = inf;
        case 'WQ_TRC_TR2'
            ConversionFactor = 1;
            ParamStdName = 'Enterococci';
            ParamUnit = '(cfu/100mL)';
            ParamYLim = inf;
        otherwise
            error('Parameter not recognised')            
    end        
end
