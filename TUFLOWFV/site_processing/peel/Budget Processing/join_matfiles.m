
clear all; close all;

dirlist = dir(['T:\Scenarios\Fluxes_v12\Join/','*.mat']);

flux_all = [];

load(['T:\Scenarios\Fluxes_v12\Join/',dirlist(1).name]);

sites = fieldnames(flux);
vars = fieldnames(flux.(sites{1}));

flux_all = flux;

for ii = 2:length(dirlist)
    clear flux;
    load(['T:\Scenarios\Fluxes_v12\Join/',dirlist(ii).name]);
    
    for i = 1:length(sites)
        for j = 1:length(vars)
            
            
            
            flux_all.(sites{i}).(vars{j}) = [flux_all.(sites{i}).(vars{j});flux.(sites{i}).(vars{j})];
            
            
        end
        
        if length(flux_all.(sites{i}).mDate) ~= length(flux_all.(sites{i}).OGM_donr)
            stop;
        end
    end
end

sites = fieldnames(flux_all);
for i = 1:length(sites)
    
    mvec = datevec(flux_all.(sites{i}).mDate);
    flux_all.(sites{i}).mDate = datenum(mvec(:,1),mvec(:,2),mvec(:,3),mvec(:,4),mvec(:,5),00);
    
    [flux_all.(sites{i}).mDate,ind] = unique(flux_all.(sites{i}).mDate);
    vars = fieldnames(flux_all.(sites{i}));
    for j = 1:length(vars)
        if strcmpi(vars{j},'mDate') == 0
            flux_all.(sites{i}).(vars{j}) = flux_all.(sites{i}).(vars{j})(ind);
        end
    end
end




save flux_all.mat flux_all -mat;