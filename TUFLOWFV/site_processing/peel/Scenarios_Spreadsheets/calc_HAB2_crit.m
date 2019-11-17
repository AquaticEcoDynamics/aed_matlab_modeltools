clear all; close all;

% main_dir = 'Y:\Peel Final Report\Scenarios\Scenarios_Spreadsheets\';
% 
% filelist = dir([main_dir,'*.mat']);

load Scenarios_Spreadsheets\HAB.mat;

filelist = fieldnames(outdata);

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

conv = [1];

var = 'HAB2';

for i = 1:length(filelist)
    
%     load([main_dir,filelist(i).name]);
%     
%     disp(filelist(i).name);
    
    %sim = fieldnames(outdata);
    
    for j = 1:length(site_order)
        for k = 1:length(date_order)
            
            mtime = outdata.(filelist{i}).(var).(site_order{j}).(date_order{k}).Time; 
            DO = outdata.(filelist{i}).(var).(site_order{j}).(date_order{k}).Data * conv;
            Area = outdata.(filelist{i}).(var).(site_order{j}).(date_order{k}).Area;
            
            DOc.(filelist{i}).(site_order{j}).(date_order{k}).crit = [];
            
            for l = 1:length(mtime)
                ss = find(DO(:,l)> 0.5);
                if ~isempty(ss)
                    DOc.(filelist{i}).(site_order{j}).(date_order{k}).crit(l) = (sum(Area(ss)) / sum(Area)) * 100;
                else
                    DOc.(filelist{i}).(site_order{j}).(date_order{k}).crit(l) = 0;
                end
            end
            
        end
    end
                
            
 
    
end
save HAB2.mat DOc -mat