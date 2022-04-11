function FlowData = FlowComparison_SC(Res)
    %% Function to compare flows for different scenario %%    
    
    % Assign a structure to hold all data
    FlowData = struct;
    counter = 1;
    
    % Loop through every site in the Flow Index file
    for i = 1:size(Res(1).QIndex,1)
        FlowData(counter).Site = Res(1).QIndex.Name{i,1};
        FVQ = table(Res(1).Date);
        FVQ.Properties.VariableNames = {'Date'};
        FVQ = table2timetable(FVQ);
        
        % Loop through every scenario
        for j = 1:size(Res,2)           
            FVQIdx = find(contains(Res(j).Flow.Properties.VariableNames,strcat('NS',num2str(Res(j).QIndex.NSnum(i,1)),'_FLOW')));            
            
            FlowDate = Res(j).Flow(:,1);
            FlowDate.Properties.VariableNames = {'Date'};
            FlowExtract = Res(j).Flow(:,FVQIdx);
            FlowExtract.(1) = FlowExtract.(1).*86.4; %m3s of TUFLOW FV to MLD for report
            FlowTable = table2timetable([FlowDate,FlowExtract]);
            FlowTable.Date = dateshift(FlowTable.Date,'start','minute','nearest'); % Round the FLUX file TIME column to nearest minute
            FlowTable = retime(FlowTable,'hourly','nearest'); % If flows are not hourly, then retime it to hourly by taking the flow on the hour
            FlowTable = FlowTable(Res(1).TR,:); % Cut dataset to required period            
            FlowTable.Properties.VariableNames{1,1} = [Res(j).Name,'_inMLD'];
            FVQ = synchronize(FVQ,FlowTable,'first','fillwithmissing');
            
            if any(any(ismissing(timetable2table(FVQ)))) == 1
                error('Missing Data in flow dataset') % Check to see if there is any missing data point. This should ideally never happen.
            end
        end
        
        FVQ.Date.Format = 'dd/MM/yyyy HH:mm';        
        
        FVannual = retime(FVQ,'yearly',@median); % Get annual medians       
        
        % Assign final table to structure
        FlowData(counter).Flow = FVQ;
        FlowData(counter).AnnualMedianFlow = FVannual;
        
        % Calculate minimum, median and maximum stats for 2 scenarios of your choice.    
        FlowData(counter).Min1 = round(min(FVQ.(Res(1).StatsFor(1,1))),1);
        % Set minimum flow to zero if it is marginally minimum. This is because of cell stability than actual backflow        
        if FlowData(counter).Min1 >= -5 && FlowData(counter).Min1 < 0
            FlowData(counter).Min1 = 0;
        end
        FlowData(counter).Median1 = round(median(FVQ.(Res(1).StatsFor(1,1))),1);
        FlowData(counter).Max1 = round(max(FVQ.(Res(1).StatsFor(1,1))),1);

        FlowData(counter).Min2 = round(min(FVQ.(Res(1).StatsFor(1,2))),1);
        if FlowData(counter).Min2 >= -5 && FlowData(counter).Min2 < 0
            FlowData(counter).Min2 = 0;
        end
        FlowData(counter).Median2 = round(median(FVQ.(Res(1).StatsFor(1,2))),1);
        FlowData(counter).Max2 = round(max(FVQ.(Res(1).StatsFor(1,2))),1);
        
        counter = counter+1;        
    end
    
    %% Get Flow Frequency Plots
    for i = 1:size(FlowData,2)
        FrequencyTable = table;
        for j = 1:size(FlowData(i).Flow,2)
            SortedArray = sort(FlowData(i).Flow.(j),'descend');
            FrequencyTable.(j) = SortedArray;
        end
        FrequencyTable.Properties.VariableNames = FlowData(i).Flow.Properties.VariableNames;        
        FlowData(i).SortedFlow = FrequencyTable;
    end
    
    % Get percentage to create percentage duration x-axis for plots
    Ranking = [1:1:size(FlowData(1).SortedFlow,1)]';
    Percentage = (Ranking./size(Ranking,1)).*100;
    
    %% Scenario Comparison Plotting %%
    cd(Res(1).OutDir);
    mkdir('ScenarioFlowComparisons');
    cd('ScenarioFlowComparisons');

    for i = 1:size(FlowData,2)
        
        % Crate a stats text box
        Stats = ['Minimums = ',num2str(FlowData(i).Min1),' and ',num2str(FlowData(i).Min2),' in MLD' newline ...
            'Medians = ',num2str(FlowData(i).Median1),' and ',num2str(FlowData(i).Median2),' in MLD' newline ...
            'Maximums = ',num2str(FlowData(i).Max1),' and ',num2str(FlowData(i).Max2),' in MLD'];
        % Print tables as .csv files
        writetable(timetable2table(FlowData(i).Flow),['HourlyFlowComparisonAt_',FlowData(i).Site,'.csv'],...
            'WriteRowNames',1,'WriteVariableNames',1);
        writetable(timetable2table(FlowData(i).AnnualMedianFlow),['AnnualMedianFlowComparisonAt_',FlowData(i).Site,'.csv'],...
            'WriteRowNames',1,'WriteVariableNames',1);
        
        % Timeseries figure block
        Qfig = figure('units','normalized','outerposition',[0 0 1 1]);
        plot(FlowData(i).Flow.Date,FlowData(i).Flow.(1),'LineStyle',':','color','black','LineWidth',1);
        title(['Flows - ',strrep(FlowData(i).Site,'_',' ')]);
        hold on
        for j = 2:size(Res,2)
            plot(FlowData(i).Flow.Date,FlowData(i).Flow.(j),'color',Res(1).Colours{1,j-1},'LineWidth',1);
        end
        hold off
        ax = gca;
        set(ax,'position',[0.1 0.1 0.85 0.65]);
        ax.FontSize = 22;
        legend({Res.Name},'location','northeastoutside');
        ylim([0 inf]);
        xlabel('Date');
        ylabel('Flow (ML/day)');
        StatBox = annotation('textbox',[0.1,0.80,0.25,0.17],'String',Stats); % Place the stats text box on top left corner of figure
        StatBox.FontSize = 15;
        saveas(Qfig,['Flows at ',FlowData(i).Site],'jpg');
        
        % Frequency Distribution plot block
        QFfig = figure('units','normalized','outerposition',[0 0 1 1]);
        semilogy(Percentage,FlowData(i).SortedFlow.(1),...
            'LineStyle',':','color','black','LineWidth',1);
        title(['Flow frequency distribution - ',strrep(FlowData(i).Site,'_',' ')]);
        hold on
        for j = 2:size(Res,2)
            semilogy(Percentage,FlowData(i).SortedFlow.(j),...
                'color',Res(1).Colours{1,j-1},'LineWidth',1);
        end
        hold off
        ax = gca;        
        ax.FontSize = 22;
        legend({Res.Name},'location','northeastoutside');
        ylim([0.1 inf]);
        xlabel('Percentage Duration %');
        ylabel('Flow (ML/day)');        
        saveas(QFfig,['Flow frequency distribution at ',FlowData(i).Site],'jpg');

        close all   
    end
    
    cd(Res(1).OutDir);
end