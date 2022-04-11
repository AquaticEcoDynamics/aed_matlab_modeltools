function Data2 = WQ_TimeseriesComparison_HN(Res)
    
    %% Function to generate timeseries plots for different scenario to compare %%
    ScriptDir = pwd;
    
    TSRows = find(strcmp(Res(1).PointIdx.Type,'TS'));
    TSIdx = Res(1).PointIdx(TSRows,:);
    PointNames = TSIdx.Pt;
    PointNames = strcat(PointNames,'_');
    SiteNames = TSIdx.Name';
    
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
        for k = 1:size(Res,2)
            ScRows = find(strcmp(Res(k).Name,{Data.Name}));
            Data2(counter).Param = Res(k).Params{i,1};
            Data2(counter).Sc = Res(k).Name;
            
            ParamCol = find(contains(Data(k).Raw.Properties.VariableNames,['_',Data2(counter).Param]));
            ParamCol = [1,ParamCol];
            TempTable = Data(k).Raw(:,ParamCol);
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
        
        TriggerRow = find(strcmp(Data2(i).Param,Res(1).TriggerIdx.Param));
        if ~isempty(TriggerRow) == 1
            Data2(i).TriggerValue = Res(1).TriggerIdx.Limit(TriggerRow,1);
        else
            Data2(i).TriggerValue = NaN;
        end       
    end

    % Change to output directory
    cd(Res(1).OutDir);
    mkdir('Scenario TS plots and tables v2');
    cd('Scenario TS plots and tables v2');

    % Tables and Plots for every parameter
    for i = 1:size(SiteNames,2)        
        for j = 1:size(Res(1).Params,1)        
            % Find all scenarios in Data2 for this parameter
            Parameter = Res(1).Params{j,1};
            ParamRows = find(strcmp(Parameter,{Data2.Param}));
            TriggerValue = Data2(ParamRows(1,1)).TriggerValue;

            % Function to get parameter related info including conversion from
            % FV to SI units
            [ConversionFactor,ParamStdName,ParamUnit] = UnitConvTS(Parameter);

            % Populate tables with medians from each scenario
            for k = 1:size(ParamRows,2)                
                if k == 1
                    Date = Data2(ParamRows(1,k)).TT.Date;
                    Table = table(Date);
                    Table.Properties.VariableNames{1,1} = 'Date';
                    Table.Date.Format = 'dd/MM/yyyy HH:mm';
                end                
                SiteCol = find(strcmp(Data2(ParamRows(1,k)).TT.Properties.VariableNames,SiteNames{1,i}));
                TempArray = Data2(ParamRows(1,k)).TT.(SiteCol);                
                TempArray = TempArray.*ConversionFactor;
                Table.(k+1) = TempArray;
                Table.Properties.VariableNames{1,k+1} = Data2(ParamRows(1,k)).Sc;            
            end
            CurrentSize = size(Table,2);
            Table.(CurrentSize+1) = repmat(TriggerValue,size(Table,1),1);
            Table.Properties.VariableNames{1,end} = 'ANZECCtrigger';
            
            % Write tables
            writetable(Table,['TS at ',SiteNames{1,i},' for ',ParamStdName,'.csv'],...
                'WriteRowNames',1,'WriteVariableNames',1);
            
            TSFig = figure('units','normalized','outerposition',[0 0 1 1]);
            plot(Table.Date,Table.(2),'color','black','LineStyle','--','LineWidth',1.2);
            title(['Timeseries at - ',strrep(SiteNames{1,i},'_',' '),' for ',ParamStdName]);
            hold on;
            for iScn = 2:size(Res,2)
                plot(Table.Date,Table.(iScn+1),'color',Res(1).Colours{1,iScn-1},'LineWidth',1.2);
            end
            plot(Table.Date,Table.ANZECCtrigger,'color','magenta','LineStyle',':','LineWidth',1.2);
            ax = gca;
            ax.FontSize = 22;
            MaxOfTable = max(max(Table{:,2:end}));
            NewYLim = MaxOfTable + (MaxOfTable*0.15);
            ylim([0 NewYLim]);
            if strcmp(ParamStdName,'Water Level') == 1
               ylim([-inf NewYLim]);
            end
            xlabel('Date');
            ylabel([ParamStdName ' ' ParamUnit]);    
            hold off;
            legend([{Res.Name},'ANZG DGV'],'Location','northeastoutside');
            if strcmp(ParamStdName,'Enterococci') == 1
                legend([{Res.Name},'NHMRC DGV'],'Location','northeastoutside');
            end
            saveas(TSFig,['TS at ',SiteNames{1,i},' for ',ParamStdName],'jpg');
            
            % Box plot block
            BoxFig = figure('units','normalized','outerposition',[0 0 1 1]);
            BoxPlot = boxplot(table2array(Table(:,2:end-1)),'BoxStyle','outline','Colors','kbgry',...
               'Notch','off','OutlierSize',3);
            set(BoxPlot,'LineWidth',2);
            title(['Box plot at - ',strrep(SiteNames{1,i},'_',' '),' for ',ParamStdName]);
            BoxGCA = gca;
            BoxTck = BoxGCA.XTick;
            hold on;
            BoxTrigger = plot(BoxTck,repmat(TriggerValue,1,size(BoxTck,2)),'m:*','LineWidth',1.2);
            BoxGCA.FontSize = 22;
            ylim([0 NewYLim]);
            if strcmp(ParamStdName,'Water Level') == 1
               ylim([-inf NewYLim]);
            end
            xticklabels({Res.Name});
            xlabel('Scenarios');
            ylabel([ParamStdName ' ' ParamUnit]);
            hold off;
            legend({'ANZG DGV'},'Location','northeastoutside');
            if strcmp(ParamStdName,'Enterococci') == 1
                legend({'NHMRC DGV'},'Location','northeastoutside');
            end
            saveas(BoxFig,['BoxPlot at ',SiteNames{1,i},' for ',ParamStdName],'jpg');

            close all
        end
    end
end

%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
%Parameter Conversion from AED to SI unit
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
function [ConversionFactor,ParamStdName,ParamUnit] = UnitConvTS(Parameter)
    switch Parameter
       case 'D'
            ConversionFactor = 1;
            ParamStdName = 'Depth';
            ParamUnit = '(m)';
        case 'H'
            ConversionFactor = 1;
            ParamStdName = 'Water Level';
            ParamUnit = '(mAHD)';
        case 'SAL'
            ConversionFactor = 1;
            ParamStdName = 'Salinity';
            ParamUnit = '(g/L)';
        case 'TEMP'
            ConversionFactor = 1;
            ParamStdName = 'Temperature';
            ParamUnit = '(^oC)';
        case 'WQ_DIAG_OXY_SAT'
            ConversionFactor = 1;
            ParamStdName = 'Dissolved Oxygen Saturation';
            ParamUnit = '(%)';
        case 'WQ_DIAG_TOT_TSS'
            ConversionFactor = 1;
            ParamStdName = 'TSS';
            ParamUnit = '(mg/L)';
        case 'WQ_OXY_OXY'
            ConversionFactor = 0.032;
            ParamStdName = 'Dissolved Oxygen';
            ParamUnit = '(mg/L)';
        case 'WQ_SIL_RSI'
            ConversionFactor = 0.028;
            ParamStdName = 'Silicates';
            ParamUnit = '(mg/L)';
        case 'WQ_NIT_AMM'
            ConversionFactor = 0.014;
            ParamStdName = 'Ammonia';
            ParamUnit = '(mg/L)';
        case 'WQ_NIT_NIT'
            ConversionFactor = 0.014;
            ParamStdName = 'NOx';
            ParamUnit = '(mg/L)';
        case 'WQ_PHS_FRP'
            ConversionFactor = 0.031;
            ParamStdName = 'FRP';
            ParamUnit = '(mg/L)';
        case 'WQ_PHS_FRP_ADS'
            ConversionFactor = 0.031;
            ParamStdName = 'Adsorbed FRP';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_DOC'
            ConversionFactor = 0.012;
            ParamStdName = 'Dissolved Organic Carbon';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_POC'
            ConversionFactor = 0.012;
            ParamStdName = 'Particulate Organic Carbon';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_DON'
            ConversionFactor = 0.014;
            ParamStdName = 'Dissolved Organic Nitrogen';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_PON'
            ConversionFactor = 0.014;
            ParamStdName = 'Particulate Organic Nitrogen';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_DOP'
            ConversionFactor = 0.031;
            ParamStdName = 'Dissolved Organic Phosphorus';
            ParamUnit = '(mg/L)';
        case 'WQ_OGM_POP'
            ConversionFactor = 0.031;
            ParamStdName = 'Particulate Organic Phosphorus';
            ParamUnit = '(mg/L)';
        case 'WQ_DIAG_PHY_TCHLA'
            ConversionFactor = 1;
            ParamStdName = 'Total Chlorophyll-a';
            ParamUnit = '(\mug/L)';
        case 'WQ_DIAG_TOT_TN'
            ConversionFactor = 0.014;
            ParamStdName = 'Total Nitrogen';
            ParamUnit = '(mg/L)';
        case 'WQ_DIAG_TOT_TP'
            ConversionFactor = 0.031;
            ParamStdName = 'Total Phosphorus';
            ParamUnit = '(mg/L)';
        case 'WQ_PHY_GRN'
            ConversionFactor = 1;
            ParamStdName = 'Green Phytoplankton';
            ParamUnit = '(\mug/L)';
        case 'WQ_PHY_BGA'
            ConversionFactor = 1;
            ParamStdName = 'Blue-green Phytoplankton';
            ParamUnit = '(\mug/L)';
        case 'WQ_PHY_FDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Freshwater Diatom';
            ParamUnit = '(\mug/L)';
        case 'WQ_PHY_MDIAT'
            ConversionFactor = 1;
            ParamStdName = 'Marine Diatom';
            ParamUnit = '(\mug/L)';
        case 'WQ_TRC_TR1'
            ConversionFactor = 1;
            ParamStdName = 'Ecoli';
            ParamUnit = '(cfu/100mL)';
        case 'WQ_TRC_TR2'
            ConversionFactor = 1;
            ParamStdName = 'Enterococci';
            ParamUnit = '(cfu/100mL)';
        otherwise
            error('Parameter not recognised')            
    end        
end