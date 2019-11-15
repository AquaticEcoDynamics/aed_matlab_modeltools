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

conv = [32/1000];

var = 'WQ_OXY_OXY';

for i = 1:length(filelist)
    
    load([main_dir,filelist(i).name]);
    
    disp(filelist(i).name);
    
    sim = fieldnames(outdata);
    
    for j = 1:length(site_order)
        for k = 1:length(date_order)
            
            mtime = outdata.(sim{1}).(var).(site_order{j}).(date_order{k}).Time; 
            DO = outdata.(sim{1}).(var).(site_order{j}).(date_order{k}).Bot * conv;
            Area = outdata.(sim{1}).(var).(site_order{j}).(date_order{k}).Area;
            
            DOc.(sim{1}).(site_order{j}).(date_order{k}).crit = [];
            
            for l = 1:length(mtime)
                ss = find(DO(:,l) < 4);
                if ~isempty(ss)
                    DOc.(sim{1}).(site_order{j}).(date_order{k}).crit(l) = (sum(Area(ss)) / sum(Area)) * 100;
                else
                    DOc.(sim{1}).(site_order{j}).(date_order{k}).crit(l) = 0;
                end
            end
            
        end
    end
                
            
 
    
end
save DOc.mat DOc -mat