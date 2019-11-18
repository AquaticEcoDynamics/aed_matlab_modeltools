clear all; close all;

scenlist = dir('Inflows/');

for j = 3:length(scenlist)
    
    filelist = dir(['Inflows/',scenlist(j).name,'/']);
    
    
    
    scenario = scenlist(j).name;
    
    
    
    for i = 3:length(filelist)
        
        disp(['Inflows/',scenlist(j).name,'/',filelist(i).name]);
        
        dat = tfv_readBCfile(['Inflows/',scenlist(j).name,'/',filelist(i).name]);
        
        site = ['site_',regexprep(filelist(i).name,'.csv','')];
        
        ldata.(scenario).(site) = dat;
        ldata.(scenario).(site).ML = dat.Flow * 86400 /1000;
        
    end
    
end

save ldata.mat ldata -mat;

historical_data;
