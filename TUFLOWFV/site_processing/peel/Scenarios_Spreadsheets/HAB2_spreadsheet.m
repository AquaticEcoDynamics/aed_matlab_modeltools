clear all; close all;

load HAB2.mat;

sims = fieldnames(DOc);

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


fid = fopen('HAB2 Crit.csv','wt')

fprintf(fid,'Region,Period,');

for i = 1:length(sims)
    fprintf(fid,'%s,',sims{i});
end
fprintf(fid,'\n');

for i = 1:length(site_order)
    for j = 1:length(date_order)
        
        fprintf(fid,'%s,%s,',site_order{i},date_order{j});
        
        for k = 1:length(sims)
            
            pval = mean(DOc.(sims{k}).(site_order{i}).(date_order{j}).crit);
            
            fprintf(fid,'%4.4f,',pval);
            
            clear pval;
        end
        fprintf(fid,'\n');
    end
end
fclose(fid);
            
        

