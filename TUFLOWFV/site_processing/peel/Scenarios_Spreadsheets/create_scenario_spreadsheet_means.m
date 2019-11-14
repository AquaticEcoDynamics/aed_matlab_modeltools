clear all; close all;

main_dir = 'Y:\Peel Final Report\Scenarios\Scenarios_Spreadsheets\';

filelist = dir([main_dir,'*.mat']);

site_order = {...
    'Geogrup',...
'Serpentine_Lower',...
'Murray_Mid',...
'Murray_Delta',...
'Peel_East',...
'Peel_South',...
'Peel_North',...
'Dawesville_Cut',...
'Harvey_North',...
'Harvey_South',...
};

date_order = {...
    'April_June',...
    'July_Sept',...
    'Oct_Dec',...
    'Jan_Mar',...
    };

vars = {...
    'WQ_DIAG_TOT_TN',...
    'WQ_DIAG_TOT_TP',...
    'WQ_DIAG_PHY_TCHLA',...
    };

conv = [14/1000 31/1000 1];

for i = 1:length(filelist)
    
    load([main_dir,filelist(i).name]);
    
    sim = fieldnames(outdata);
    
    
    fid = fopen([sim{1},'_Means.csv'],'wt');
    fprintf(fid,'Polygon,Season,');
    for j = 1:length(vars)
        fprintf(fid,'%s,',vars{j});
    end
    fprintf(fid,'\n');
    
    for j = 1:length(site_order)
        for k = 1:length(date_order)
            
            fprintf(fid,'%s,%s,',site_order{j},date_order{k});
            
            for l = 1:length(vars)
                
                pval = mean(mean(outdata.(sim{1}).(vars{l}).(site_order{j}).(date_order{k}).Top)) * conv(l);
                
                fprintf(fid,'%4.4f,',pval);
                
                clear pval;
                
            end
            fprintf(fid,'\n');
        end
    end
            
      fclose(fid);      
            
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
end
    
    