clear all; close all;

base_dir = 'T:\Scenarios\Fluxes_v12\';

load([base_dir,'flux_all.mat']);

flux.run_scenario_0a = flux_all;

filelist = dir([base_dir,'*.mat']);

for i = 2:length(filelist)
    
    simname = regexprep(filelist(i).name,'_FLUX.mat','');
    
    data = load([base_dir,filelist(i).name]);
    
    flux.(simname) = data.flux;
    
end

save('Y:\Peel Final Report\Scenarios\flux.mat','flux','-mat','-v7.3');