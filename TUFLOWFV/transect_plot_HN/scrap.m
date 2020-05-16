



theStruct.fielddata_matfile = '..\..\..\Hawkesbury\matlab\modeltools\matfiles\hawkesbury_all.mat';
theStruct.fielddata = 'hawkesbury_all';


field = load(theStruct.fielddata_matfile);
fdata = field.(theStruct.fielddata);

sites = fieldnames(fdata);

for i = 1:length(sites)
    
    if isfield(fdata.(sites{i}),'WQ_DIAG_TOT_TN') && ...
            isfield(fdata.(sites{i}),'WQ_DIAG_TOT_TP')
        
        
        
        TN_Date = fdata.(sites{i}).WQ_DIAG_TOT_TN.Date;
        TN_Data = fdata.(sites{i}).WQ_DIAG_TOT_TN.Data;
        TN_Depth = fdata.(sites{i}).WQ_DIAG_TOT_TN.Depth;
        
        TP_Date = fdata.(sites{i}).WQ_DIAG_TOT_TP.Date;
        TP_Data = fdata.(sites{i}).WQ_DIAG_TOT_TP.Data;
        TP_Depth = fdata.(sites{i}).WQ_DIAG_TOT_TP.Data;
        
        
        
        inc = 1;
        
        for j = 1:length(TN_Date)
            
            sss = find(TP_Date == TN_Date(j));% & ...
                %TP_Depth == TN_Depth(j));
            
            if ~isempty(sss)
                
                fdata.(sites{i}).TN_TP.Date(inc,1) = TN_Date(j);
                fdata.(sites{i}).TN_TP.Data(inc,1) = TN_Data(j) / TP_Data(sss(1));
                fdata.(sites{i}).TN_TP.Depth(inc,1) = TN_Depth(j);
                fdata.(sites{i}).TN_TP.X = fdata.(sites{i}).WQ_DIAG_TOT_TN.X;
                fdata.(sites{i}).TN_TP.Y = fdata.(sites{i}).WQ_DIAG_TOT_TN.Y;
                fdata.(sites{i}).TN_TP.Agency = fdata.(sites{i}).WQ_DIAG_TOT_TN.Agency;
                
                inc = inc + 1;
                
                
                
                disp('Found TN:TP');
            end
        end
    end
end