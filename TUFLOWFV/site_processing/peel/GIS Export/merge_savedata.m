clear all; close all;

vars = {'TEMP';'SAL';'WQ_OXY_OXY';'WQ_NIT_AMM';};

matdir1 = 'J:\Matfiles_All\run_2016_1\';
matdir2 = 'J:\Matfiles_All\run_2016\';
matdir3 = 'J:\Matfiles_All\run_2017\';


findir = 'J:\Matfiles_All\run_2016_2017_rerun_ALL\';

if ~exist(findir,'dir')
    mkdir(findir);
end

for i = 1:length(vars)
    
    data1 = load([matdir1,vars{i},'.mat']);
    data2 = load([matdir2,vars{i},'.mat']);
    data3 = load([matdir3,vars{i},'.mat']);
    
    savedata = data1.savedata;
    
    savedata.Time = [savedata.Time;data2.savedata.Time];
    savedata.Time = [savedata.Time;data3.savedata.Time];
    
    savedata.(vars{i}).Top = [savedata.(vars{i}).Top data2.savedata.(vars{i}).Top];
    savedata.(vars{i}).Bot = [savedata.(vars{i}).Bot data2.savedata.(vars{i}).Bot];

    savedata.(vars{i}).Top = [savedata.(vars{i}).Top data3.savedata.(vars{i}).Top];
    savedata.(vars{i}).Bot = [savedata.(vars{i}).Bot data3.savedata.(vars{i}).Bot];
    
    save([findir,vars{i},'.mat'],'savedata','-mat');
    
    clear savedata;
end
    
    
    
    